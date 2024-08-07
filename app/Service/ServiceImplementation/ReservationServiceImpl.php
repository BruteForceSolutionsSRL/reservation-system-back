<?php
namespace App\Service\ServiceImplementation;

use App\Service\ReservationService;

use App\Models\{
    Reservation,
    ReservationStatus,
};
use App\Repositories\{
    PersonRepository,
    ReservationStatusRepository as ReservationStatuses,
    ReservationRepository,
    RoleRepository
};
use Carbon\Carbon;

class ReservationServiceImpl implements ReservationService
{
    private $personRepository;
    private $reservationRepository;
    private $roleRepository;

    private $mailService;
    private $timeSlotService;
    private $notificationService;
    private $classroomService;
    private $reservationAssignerService; 
    private $blockService;

    public function __construct()
    {
        $this->personRepository = new PersonRepository();
        $this->reservationRepository = new ReservationRepository();
        $this->roleRepository = new RoleRepository();

        $this->timeSlotService = new TimeSlotServiceImpl();
        $this->mailService = new MailerServiceImpl();
        $this->notificationService = new NotificationServiceImpl();
        $this->classroomService = new ClassroomReservationsTakerServiceImpl();
        $this->reservationAssignerService = new ReservationsAssignerServiceImpl();
        $this->blockService = new BlockServiceImpl();
    }

    /**
     * Retrieve a list of all reservations
     * @param none
     * @return array
     */
    public function getAllReservations(): array
    {
        return $this->reservationRepository->getAllReservations();
    }

    /**
     * Retrieve a list of all reservations except pending requests
     * @return array
     */
    public function getAllReservationsExceptPending(): array
    {
        return $this->reservationRepository->getReservationsWithoutPendingRequest();
    }

    /**
     * Retrieve a single reservation based on its ID
     * @param int $reservationId
     * @return array
     */
    public function getReservation(int $reservationId): array
    {
        return $this->reservationRepository->getReservation($reservationId);
    }

    /**
     * Retrieve a list of all pending request
     * @param none
     * @return array
     */
    public function getPendingRequest(): array
    {
        return $this->reservationRepository->getPendingRequest();
    }

    /**
     * Retrieve a list of accepted/pending by a teacherId
     * @param int $teacherId
     * @return array
     */
    public function listRequestsByTeacher(int $teacherId): array
    {
        $teacher = $this->personRepository->getPerson($teacherId);
        if ($teacher === []) {
            return ['message' => 'No existe el docente'];
        }
        return $this->reservationRepository->getRequestByTeacher($teacherId);
    }

    /**
     * Retrieve a list of all request by teacherId
     * @param int $teacherId
     * @return array
     */
    public function listAllRequestsByTeacher(int $teacherId): array
    {
        $teacher = $this->personRepository->getPerson($teacherId);
        if ($teacher === []) {
            return ['message' => 'No existe el docente'];
        }
        return $this->reservationRepository->getAllActiveRequestByUser($teacherId);
    }

    /**
     * Retrieve a list of all reservations except pending requests
     * by teacherId
     * @param int $teacherId
     * @return array
     */
    public function getAllReservationsExceptPendingByTeacher(int $teacherId): array
    {
        return $this->reservationRepository
                ->getReservationsWithoutPendingRequestByTeacher($teacherId);
    }

    /**
     * Function to reject a reservation based on its ID
     * @param int $reservationId
     * @return string
     */
    public function reject(int $reservationId, string $message, int $personId): string
    {
        $reservation = $this->reservationRepository->getReservation($reservationId);

        if (empty($reservation)) 
            return 'No existe una solicitud con este ID, por favor intente ingresar a otra reserva';

        if ($reservation['reservation_status'] != 'PENDIENTE')
            return 'Esta solicitud ya fue atendida anteriormente en fecha: '.$reservation['updated_at'];

        $reservation = $this->reservationRepository->updateReservationStatus(
            $reservation['reservation_id'],
            ReservationStatuses::rejected()
        );

        $this->notificationService->store(
            $this->mailService->rejectReservation(
                $reservation,
                PersonRepository::system(),
                $message
            )
        );
        $this->acceptPendingByCollision(
            [
                'date' => $reservation['date'],
                'time_slots' => $reservation['time_slot'],
                'classrooms' => $reservation['classrooms']
            ]
        );

        return 'La solicitud de reserva fue rechazada correctamente.';
    }

    /**
     * Function to cancel a accepted/pending reservation based on its ID
     * @param int $reservationId
     * @return string
     */
    public function cancel(int $reservationId, string $message): string
    {
        $reservation = Reservation::find($reservationId);

        if ($reservation == null) 
            return 'No existe una solicitud con este ID, por favor intente ingresar a otra reserva.';

        $reservationStatusId = $reservation->reservation_status_id;
        $reservationAux = $this->reservationRepository->formatOutput($reservation);
        if ($reservationStatusId == ReservationStatuses::cancelled()) {
            return 'Esta solicitud ya fue cancelada en fecha: '.$reservationAux['updated_at'];
        }
        if ($reservationStatusId == ReservationStatuses::rejected()) {
            return 'Esta solicitud ya fue rechazada en fecha: '.$reservationAux['updated_at'];
        }

        $reservation->reservation_status_id = ReservationStatuses::cancelled();
        $reservation->save();

        $this->notificationService->store(
            $this->mailService->cancelReservation(
                $this->reservationRepository->formatOutput($reservation),
                PersonRepository::system(),
                $message
            )
        );

        $reservation = $this->reservationRepository->getReservation($reservation->id);

        $this->acceptPendingByCollision(
            [
                'date' => $reservation['date'],
                'time_slots' => $reservation['time_slot'],
                'classrooms' => $reservation['classrooms']
            ]
        );

        return 'La solicitud de reserva fue cancelada correctamente.';
    }

     /**
     * Function to cancel a accepted special reservation based on its ID
     * @param int $specialReservationId
     * @return string
     */
    public function specialCancel(int $specialReservationId): string
    {
        $specialReservationParent = Reservation::find($specialReservationId);

        if ($specialReservationParent == null) {
            return 'No existe una reserva con este ID';
        }

        $reservationStatusId = $specialReservationParent->reservation_status_id;
        if ($reservationStatusId == ReservationStatuses::cancelled()) {
            return 'Esta solicitud ya fue cancelada';
        } 
        if ($reservationStatusId == ReservationStatuses::rejected()) {
            return 'Esta solicitud ya fue rechazada';
        }

        $specialReservations = $this->reservationRepository->getSpecialReservations($specialReservationParent->parent_id);

        $specialReservationsFormat = [];

        foreach ($specialReservations as $specialReservation) {
            $this->reservationRepository->updateReservationStatus($specialReservation->id, ReservationStatuses::cancelled());
            $specialReservationsFormat[] = $this->reservationRepository->formatOutputSpecial($specialReservation);
        }

        $administratorRol = [$this->roleRepository->administrator()];

        array_push($specialReservationsFormat[0]['groups'], $this->personRepository->getUsersByRole($administratorRol));

        $this->notificationService->store(
            $this->mailService->specialCancelReservation(
                $specialReservationsFormat[0],
                PersonRepository::system()
            )
        );

        return 'La reserva fue cancelada.';
    }

    /**
     * Function to accept a request of reservation based on its ID
     * @param int $reservationId
     * @return string
     */
    public function accept(int $reservationId, bool $ignoreFlag): string
    {
        $reservation = $this->reservationRepository->getReservation($reservationId);
        if (empty($reservation))
            return 'La solicitud de reserva no existe, por favor intente ingresar a otra reserva.';

        if ($reservation['reservation_status'] != 'PENDIENTE')
            return 'Esta solicitud ya fue atendida en fecha: '.$reservation['updated_at'];

        if ($this->isExpired($reservation)) 
            return 'Esta solicitud ya es expirada, no puede atenderse.';

        if (!$this->checkAvailibility($reservation)) {
            $this->reject(
                $reservation['reservation_id'],
                'Se rechazo su solicitud, existe una solicitud de reserva que ya fue aceptada en las aulas que solicito.',
                PersonRepository::system()
            );
            return 'La solicitud se rechazo, existen ambientes ocupados que solicito en su reserva, por favor elija otras aulas u algun otro horario.';
        }

        $alertas = $this->alertReservation($reservation);

        if (!$ignoreFlag && ($alertas['ok'] != 0)) 
            return 'Tu solicitud debe ser revisada por un encargado responsable, esto fue producido por que existen advertencias en tu reserva: '.$alertas['quantity'].' '.$alertas['classroom']['message'].': '.implode(',',$alertas['classroom']['list']);
        
        $reservation = $this->reservationRepository->updateReservationStatus(
            $reservation['reservation_id'],
            ReservationStatuses::accepted()
        );

        $reservationSet = $this->reservationRepository->getReservations(
            [
                'dates' => [
                    'date_start' => $reservation['date'],
                    'date_end' => $reservation['date']
                ],
                'reservation_statuses' => [
                    ReservationStatuses::pending()
                ],
                'time_slots' => $this->timeSlotService->getTimeSlotsSorted(
                    $reservation['time_slot']
                ),
                'classrooms' => array_map(
                    function ($classroom)
                    {
                        return $classroom['classroom_id'];
                    },
                    $reservation['classrooms']
                )
            ]
        );

        foreach ($reservationSet as $reservationIterable)
            $this->reject(
                $reservationIterable['reservation_id'],
                'Se rechazo su solicitud, dado que las aulas solicitadas fueron asignadas a otra solicitud, por favor elija otras aulas u otros periodos/fecha.',
                PersonRepository::system()
            );

        $this->notificationService->store(
            $this->mailService->acceptReservation(
                $reservation,
                PersonRepository::system()
            )
        );

        return 'La reserva fue aceptada correctamente, se le fue asignadas las siguientes aulas: '.implode(',', array_map(
                function ($classroom) {
                    return $classroom['classroom_name'];
                }, 
                $reservation['classrooms']
            )
        ).' para ver a mayor detalle la reserva, puede verificar en el Historial de solicitudes';
    }

    /**
     * Function to store full data about a request and automatic accept/reject
     * @param array $data
     * @return mixed
     */
    public function store(array $data): string
    {
        if (!array_key_exists('classroom_id', $data) || count($data['classroom_id']) == 0) {
            $data['classroom_id'] = $this->classroomService->suggestClassrooms(
                [
                    'date' => $data['date'],
                    'time_slot_id' => $data['time_slot_id'],
                    'block_id' => $data['block_id'],
                    'quantity' => $data['quantity']
                ]
            );
            if (empty($data['classroom_id']) || ($data['classroom_id'] == ['No existe una sugerencia apropiada']))
                return 'No existen ambientes disponibles que cumplan con los requerimientos de la solicitud, por favor elija otros periodos/fecha.';
            $data['classroom_id'] = array_map(
                function ($classroom) {
                    return $classroom['classroom_id'];
                }, $data['classroom_id']
            );
        }

        if (!$this->classroomService->sameBlock($data['classroom_id'])) 
            return 'Los ambientes no pertenecen al bloque, vuelva a seleccionar los ambientes disponibles del bloque seleccionado.';

        if (!array_key_exists('repeat', $data)) {
            $data['repeat'] = 0;
        }
        if (!array_key_exists('priority', $data)) {
            $data['priority'] = 0;
        }

        $reservation = $this->reservationRepository->save($data);

        $this->notificationService->store(
            $this->mailService->createReservation(
                $reservation,
                PersonRepository::system()
            )
        );

        return $this->accept($reservation['reservation_id'], false);
    }

    /**
     * Retrieve an array of all conflicts of a reservation
     * @param int $reservationId
     * @return array
     */
    public function getConflict(int $reservationId): array
    {
        $reservation = $this->reservationRepository->getReservation($reservationId);
        if ($reservation == []) {
            return ['message' => 'La reserva no existe'];
        }
        $result = $this->alertReservation($reservation);
        unset($result['ok']);
        return $result;
    }

    /**
     * Function to check availability for all classrooms to do a reservation in a step
     * @param array $reservation
     * @return boolean
     */
    private function checkAvailibility(array $reservation): bool
    {
        return count($this->reservationRepository->getReservations(
            [
                'dates' => [
                    'date_start' => $reservation['date'],
                    'date_end' => $reservation['date']
                ],
                'reservation_statuses' => [
                    ReservationStatuses::accepted()
                ],
                'time_slots' => $this->timeSlotService->getTimeSlotsSorted(
                    $reservation['time_slot']
                ),
                'classrooms' => array_map(
                    function ($classroom)
                    {
                        return $classroom['classroom_id'];
                    },
                    $reservation['classrooms']
                )
            ]
        )) == 0;
    }

    /**
     * Check if a reservation in pending status have conflicts or is really `weird`
     * @param array $reservation
     * @return array
     */
    public function alertReservation(array $reservation): array
    {
        $result = [
            'quantity' => '',
            'classroom' => [
                'message' => '',
                'list' => array()
            ],
            'ok' => 0
        ];
        $totalCapacity = $this->getTotalCapacity($reservation['classrooms']);

        $usagePercent = $reservation['quantity'] / $totalCapacity * 100;
        if ($usagePercent < 50.0) {
            $message = 'la capacidad de los ambientes solicitados es muy elevada para la cantidad de estudiantes.';
            $result['quantity'] .= $message;
            $result['ok'] = 1;
        }

        if ($usagePercent > 150.0) {
            $result['quantity'].='La capacidad de los ambientes solicitados en muy baja para la cantidad de estudiantes';
            $result['ok'] = 1;
        }

        if ($this->getTotalFloors($reservation['classrooms']) > 2) {
            $result['ok'] = 1;
            $message = 'los ambientes solicitados, se encuentran en mas de 2 pisos diferentes.';
            $result['classroom']['message'] .= $message;
        }

        $classrooms = [];
        foreach ($reservation['classrooms'] as $classroom)
            $classrooms[$classroom['classroom_name']] = 0;

        $reservationSet = $this->reservationRepository->getReservations(
            [
                'dates' => [
                    'date_start' => $reservation['date'],
                    'date_end' => $reservation['date']
                ],
                'reservation_statuses' => [
                    ReservationStatuses::pending()
                ],
                'time_slots' => $this->timeSlotService->getTimeSlotsSorted(
                    $reservation['time_slot']
                ),
                'classrooms' => array_map(
                    function ($classroom)
                    {
                        return $classroom['classroom_id'];
                    },
                    $reservation['classrooms']
                )
            ]
        );
        foreach ($reservationSet as $reservationIterable) {
            if ($reservation['reservation_id'] == $reservationIterable['reservation_id'])
                continue;
            foreach ($reservationIterable['classrooms'] as $classroom) {
                if (!array_key_exists($classroom['classroom_name'], $classrooms))
                    $classrooms[$classroom['classroom_name']] = 0;
                if ($classrooms[$classroom['classroom_name']] == 0) {
                    $classrooms[$classroom['classroom_name']] = 1;
                }
            }
        }

        foreach ($reservation['classrooms'] as $classroom)
            if ( ($classrooms[$classroom['classroom_name']] == 1)) {
                array_push($result['classroom']['list'], $classroom['classroom_name']);
            }

        if (count($result['classroom']['list']) != 0) {
            $result['classroom']['message'] .= 'Existen ambientes que se quieren ocupar por diversos docentes en los mismos periodos y fecha especificada.';
            $result['ok'] = 1;
        }
        return $result;
    }

    /**
     * Function to get Total Capacity of a set of classrooms
     * @param array $classrooms
     * @return int
     */
    public function getTotalCapacity(array $classrooms): int
    {
        $total = 0;
        foreach ($classrooms as $classroom)
            $total += $classroom['capacity'];
        return $total;
    }

    /**
     * Retrieve a list of accepted/pending reservations
     * @param int $classroomId
     * @return array
     */
    public function getActiveReservationsByClassroom(int $classroomId): array
    {
        return $this->reservationRepository->getReservationsByClassroomAndStatuses(
            $classroomId,
            [
                ReservationStatuses::accepted(),
                ReservationStatuses::pending()
            ]
        );
    }

    /**
     * Retrieve a number of floors used in a set of classrooms
     * @param array $classrooms
     * @return int
     */
    private function getTotalFloors(array $classrooms): int
    {
        $dp = [];
        foreach ($classrooms as $classroom) {
            $floor = $classroom['floor'];
            if (!array_key_exists($floor, $dp))
                $dp[$floor] = 0;
            if ($dp[$floor] == 0)
                $dp[$floor] = 1;
        }
        return count($dp);
    }

    /**
     * Function to cancel and reject all reservations related to a classroom in the process to delete
     * @param int $classroomId
     * @return array
     */
    public function cancelAndRejectReservationsByClassroom(int $classroomId): array
    {
        $reservations = $this->reservationRepository
            ->getAcceptedAndPendingReservationsByClassroom($classroomId);

        $acceptedReservations = $reservations['accepted'];
        $pendingReservations = $reservations['pending'];

        if (!empty($acceptedReservations) || !empty($pendingReservations)) {
            foreach ($acceptedReservations as $reservationId) {
                $reservation = $this->reservationRepository->getReservation($reservationId);
                if ($reservation['special'] == 0) {
                    $this->cancel(
                        $reservationId,
                        'Razon de la cancelacion de su reserva es la deshabilitacion/eliminacion de un ambiente correspondiente a esta reserva'
                    );    
                } else {
                    $this->specialCancel($reservation['parent_id']); 
                }
            }

            foreach ($pendingReservations as $reservationId) {
                $this->reject(
                    $reservationId,
                    'Se rechazo su solicitud, un ambiente especificado en su solicitud de reserva acaba de ser actualizado.',
                    PersonRepository::system()
                );
            }

            return ['Todas las solicitudes asociadas al ambiente fueron canceladas/rechazadas.'];
        } else {
            return ['El ambiente no está asociado a ninguna reserva.'];
        }
    }

    /**
     * Cancel accepted reservations and reject pending reservations in an array
     * @param array $reservations
     * @return none
     */
    public function cancelAndRejectReservations(array $reservations, string $message): void
    {
        foreach ($reservations as $reservation) {
            if ($reservation['reservation_status'] === 'ACEPTADO') { 
                $this->cancel(
                    $reservation['reservation_id'],
                    $message
                );
            } else {
                $this->reject(
                    $reservation['reservation_id'],
                    $message,
                    PersonRepository::system()
                );
            }
        }
    }

    /**
     * Function to get reservations accepted, pending and reject
     * @param int $classromId
     * @return array
     */
    public function getAllReservationsByClassroom(int $classromId): array
    {
        $reservations = $this->reservationRepository
            ->getReservationsByClassroomAndStatuses(
                $classromId,
                [
                    ReservationStatuses::accepted(),
                    ReservationStatuses::pending(),
                    ReservationStatuses::rejected()
                ]
            );
        return $this->reservationRepository->formatOutputGARBC($reservations);
    }

    /**
     *
     * @param array $data
     * @return array
     */
    public function getReports(array $data): array
    {
        return $this->reservationRepository->getReports($data);
    }

    /**
     * Function to check if a reservation is expired
     * @param array $reservation
     * @return bool
     */
    public function isExpired(array $reservation): bool
    {
        $now = Carbon::now();
        $requestedHour = Carbon::parse($reservation['date'].' '.$reservation['time_slot'][0])->addHours(4);
        return ($now > $requestedHour);
    }

    /**
     * Accept automatically if a reservation is unique and in the classrooms specified
     * @param array $data
     * @return none
     */
    private function acceptPendingByCollision(array $data): void
    {
        $reservations = $this->reservationRepository->getReservations(
            [
                'dates' => [
                    'date_start' => $data['date'],
                    'date_end' => $data['date']
                ],
                'reservation_statuses' => [
                    ReservationStatuses::pending()
                ],
                'time_slots' => $this->timeSlotService->getTimeSlotsSorted($data['time_slots']),
                'classrooms' => array_map(
                    function ($classroom) {
                        return $classroom['classroom_id'];
                    }, $data['classrooms']
                )
            ]
        );
        if (count($reservations) == 1) {
            $reservation = $reservations[0];
            $this->accept($reservation['reservation_id'], false);
        }
    }

    /**
     * Store a new reservation - accept it automatically and try to re-assign the accepted reservations.
     * @param array $data
     * @return string
     */
    public function saveSpecialReservation(array $data): string 
    {
        $data['time_slot_id'][1]--;
        if (empty($data['block_id'])) {
            $data['block_id'] = array_map(
                function ($block) {
                    return $block['block_id'];
                }, $this->blockService->suggestBlocks($data)
            );
        }
        $classrooms = $data['classroom_id'];
        if (empty($classrooms)) {
            foreach ($data['block_id'] as $blockId) {
                $classrooms = array_merge(
                    $classrooms, 
                    array_map(
                        function ($classroom) {
                            return $classroom['classroom_id'];
                        },
                        $this->classroomService->getClassroomsByBlock($blockId)
                    )
                );
            }    
            $data['classroom_id'] = $classrooms;
        }
        $specialReservationSet = $this->reservationRepository->getReservations(
            [
                'dates' => [
                    'date_start' => $data['date_start'],
                    'date_end' => $data['date_end']
                ],
                'time_slots' => $data['time_slot_id'],
                'classrooms' => $data['classroom_id'],
                'priorities' => [1],
                'reservation_statuses' => [
                    ReservationStatuses::accepted()
                ],
            ]
        );

        if (!empty($specialReservationSet)) {
            return 'No se puede realizar la reserva de tipo especial, dado que existen ambientes ya ocupados con otra actividad de reserva especial, por favor intente con otra fecha/periodos.';
        }

        if (!array_key_exists('repeat', $data)) {
            $data['repeat'] = 0;
        }
        $data['priority'] = 1;

        $date = Carbon::parse($data['date_start']);
        $dateEnd = Carbon::parse($data['date_end']);
        $data['time_slot_id'][1]++;
        for (; $date <= $dateEnd; $date = $date->addDay()) {
            $reservation = $this->reservationRepository
                ->save(array_merge($data, ['date' => $date->format('Y-m-d')]));
                
            $this->reservationRepository->updateReservationStatus(
                $reservation['reservation_id'],
                ReservationStatuses::accepted()
            );
            $data['parent_id'] = $reservation['parent_id'];
        }

        $reservation = $this->reservationRepository->getSpecialReservation($data['parent_id']);

        $administratorRol = [$this->roleRepository->administrator()];

        array_push($reservation['groups'], $this->personRepository->getUsersByRole($administratorRol));

        $this->notificationService->store(
            $this->mailService->specialAcceptReservation(
                $reservation,
                PersonRepository::system()
            )
        );

        $reservations = $this->reservationRepository->getReservations(
            [
                'reservation_statuses' => [
                    ReservationStatuses::accepted(), 
                    ReservationStatuses::pending()
                ],
                'dates' => [
                    'date_start' => $data['date_start'],
                    'date_end' => $data['date_end']
                ],
                'classrooms' => $data['classroom_id'],
                'priorities' => [0],
                'no_repeat' => 1,
                'time_slots' => $data['time_slot_id'],
            ]
        );

        $this->reservationAssignerService->reassign($reservations);
        return 'Se realizo la reserva de tipo especial de manera correcta, para ver mas detalles revisar en el historial de solicitudes.';
    }

    /**
     * Re-assign classrooms and notificate users. 
     * @param int $reservationId
     * @param array $classroms
     * @return array
     */
    public function assignClassrooms($reservationId, $classrooms): array 
    {
        $reservation = $this->reservationRepository->attachClassroomsReservation(
            $reservationId, 
            $classrooms
        );
        $this->notificationService->store(
            $this->mailService->reassingReservation(
                $reservation, 
                PersonRepository::system()
            )
        );
        return $reservation;
    }

    /**
     * Retrieve a list of all active special reservations based on date and time 
     * @param none
     * @return array
     */
    public function getActiveSpecialReservations(): array 
    {
        return $this->reservationRepository->getActiveSpecialReservations();
    }
}
