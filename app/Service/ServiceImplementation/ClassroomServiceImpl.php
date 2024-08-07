<?php

namespace App\Service\ServiceImplementation;

use App\Repositories\BlockRepository;
use App\Service\ClassroomService;

use App\Repositories\{
    ClassroomRepository,
    ReservationRepository,
    ReservationStatusRepository as ReservationStatuses,
    TimeSlotRepository,
    ClassroomStatusRepository,
    ClassroomLogsRepository,
    PersonRepository,
    NotificationTypeRepository
};

class ClassroomServiceImpl implements ClassroomService
{
    private $classroomRepository;
    private $reservationRepository;
    private $timeSlotRepository;
    private $blockRepository;
    private $classroomStatusRepository;
    private $classroomLogRepository;

    private $reservationService;
    private $timeSlotService;
    private $notificationService; 
    private $mailService;

    public function __construct()
    {
        $this->classroomRepository = new ClassroomRepository();
        $this->reservationRepository = new ReservationRepository();
        $this->timeSlotRepository = new TimeSlotRepository();
        $this->blockRepository = new BlockRepository();
        $this->classroomStatusRepository = new ClassroomStatusRepository();

        $this->timeSlotService = new TimeSlotServiceImpl();
        $this->reservationService = new ClassroomReservationsTakerServiceImpl();
        $this->classroomLogRepository = new ClassroomLogsRepository();
        $this->notificationService = new NotificationServiceImpl();
        $this->mailService = new MailerServiceImpl();
    }
 
    /**
     * Retrieve a list of classrooms through a status
     * @param string $statuses
     * @return array
     */
    public function getAllClassrooms(string $statuses): array
    {
        $idStatuses = $this->classroomStatusRepository->getStatusesIdByName($statuses);
        return $this->classroomRepository->getClassroomsByStatus($idStatuses);
    }

    /**
     * Function to return to information about a classroom with it's statistics
     * @param none
     * @return array
     */
    public function getAllClassroomsWithStatistics(): array
    {
        $classroomsStatistics = $this->classroomRepository
            ->getAllClassroomsWithStatistics();
        return $classroomsStatistics;
    }

    /**
     * 
     * @param none
     * @return array
     */
    public function getAllAvailableClassrooms(): array
    {
        return $this->classroomRepository->getClassrooomsByStatus(
            [
                ClassroomStatusRepository::available(),
                ClassroomStatusRepository::disabled()
            ]
        );
    }

    /**
     * Retrieve a single classroom by its id
     * @param int $id
     * @return array
     */
    public function getClassroomByID(int $id): array
    {
        return $this->classroomRepository->getClassroomById($id);
    }

    /**
     * Retrieve a boolean if a classroom is deleted
     * @param int $classroomId
     * @return bool
     */
    public function isDeletedClassroom(int $classroomId): bool
    {
        return $this->classroomRepository->isDeletedClassroom(
            $classroomId
        );
    }

    /**
     * To retrieve array classrooms within block ID by its disponibility
     * @param int $blockID
     * @return array
     */
    public function getDisponibleClassroomsByBlock(int $blockId): array
    {
        return $this->classroomRepository
            ->getDisponibleClassroomsByBlock($blockId);
    }

    /**
     * Retrieve a list of all classrooms
     * @param int $blockId
     * @return array
     */
    public function getAllClassroomsByBlock(int $blockId): array 
    {
        return $this->classroomRepository->getAllClassroomByBlock($blockId);
    }

    /**
     * To retrieve array classrooms within block ID
     * @param int $blockID
     * @return array
     */
    public function getClassroomsByBlock(int $blockId): array
    {
        return $this->classroomRepository
            ->getClassroomsByBlock($blockId);
    }

    /**
     * Save a classroom with all data previously validated
     * @param array $data
     * @return string
     */
    public function store(array $data): string
    {
        $classroom = $this->classroomRepository->save($data);

        $data['title'] = 'CREACION DE AMBIENTE '.$classroom['name'].'#'.$classroom['classroom_id'];
        $data['sended'] = 1;
        $data['sendBy'] = PersonRepository::system();
        $data['to'] = ['TODOS']; 
        $data['type'] = NotificationTypeRepository::informative();
        $data['body'] = 'Se creo un nuevo ambiente denominado '.$classroom['name'];

        $emailData = $this->notificationService->store($data);
        $emailData = array_merge($emailData, $classroom);

        $this->mailService->sendCreationClassroomEmail($emailData);

        return 'El ambiente '.$classroom['name'].' fue creado exitosamente.';
    }

    /**
     * Update with all data previously validated
     * @param array $data
     * @return string
     */
    public function update(array $data): string
    {
        $classroom = $this->classroomRepository->getClassroomById(
            $data['classroom_id']
        );
        $modifiedClassroom = $this->classroomRepository->update($data);
        if (($classroom['classroom_status_id'] != $modifiedClassroom['classroom_status_id'])
              && ($modifiedClassroom['classroom_status_id'] == ClassroomStatusRepository::disabled())) {
            $this->disable($classroom['classroom_id']);
        }

        $data['title'] = 'ACTUALIZACION DE DATOS DEL AMBIENTE '.$classroom['name'].'#'.$classroom['classroom_id'];
        $data['sended'] = 1;
        $data['sendBy'] = PersonRepository::system();
        $data['to'] = ['TODOS']; 
        $data['type'] = NotificationTypeRepository::informative();
        $data['body'] = 'Se actualizaron los datos del ambiente denominado '.$classroom['name'];

        $emailData = $this->notificationService->store($data);
        $emailData = array_merge($emailData, $classroom);

        $this->mailService->sendUpdateClassroomEmail($emailData);

        return 'El ambiente '.$classroom['name'].' fue actualizado correctamente';
    }

    /**
     * Function to retrieve disponibility
     * status for all selected classrooms
     * @param array $data
     * @return array
     */
    public function getClassroomByDisponibility(array $data): array
    {
        $classroomList = [];
        $reservations = $this->reservationRepository->getReservations(
            [
                'dates' => [
                    'date_start' => $data['date'], 
                    'date_end' => $data['date']
                ],
                'reservation_statuses' => [
                    ReservationStatuses::pending(), 
                    ReservationStatuses::accepted()
                ],
                'time_slots' => $data['time_slot_ids'],
                'classrooms' => $data['classroom_ids'],
                'academic_period' => $data['academic_period_id'],
            ]
        );
        $dp = [];
        foreach ($reservations as $reservation) {
            $accepted = $reservation['reservation_status'] == 'ACEPTADO';
            foreach ($reservation['classrooms'] as $classroom) {
                if (!array_key_exists($classroom['classroom_id'], $dp)) {
                    $dp[$classroom['classroom_id']] = [];
                }
                $times = $this->timeSlotService->getTimeSlotsSorted($reservation['time_slot']);
                for ($id = $times[0]; $id < $times[1]; $id++) {
                    $index = $this->timeSlotRepository->getTimeSlotById($id)['time'];
                    if (!array_key_exists($index, $dp[$classroom['classroom_id']])) {
                        $dp[$classroom['classroom_id']][$index] = 2;
                    }
                    if ($dp[$classroom['classroom_id']][$index] == 1) continue;
                    if ($accepted) {
                        $dp[$classroom['classroom_id']][$index] = 1;
                    }
                }
            }
        }
        foreach ($data['classroom_ids'] as $classroomId) {
            $classroom = $this->classroomRepository->getClassroomById($classroomId); 
            $element = ['name' => $classroom['name']]; 

            for ($id = $data['time_slot_ids'][0]; $id <= $data['time_slot_ids'][1]; $id++) {
                $index = $this->timeSlotRepository->getTimeSlotById($id)['time']; 
                if ((!array_key_exists($classroom['classroom_id'], $dp)) || 
                (!array_key_exists($index, $dp[$classroom['classroom_id']]))) {
                    $element[$index] = ['valor' => 0, 'message' => 'Disponible'];
                } else {
                    $element[$index] = ['valor' => $dp[$classroom['classroom_id']][$index]];
                    if ($element[$index]['valor'] == 1) $element[$index]['message'] = 'Ocupado';
                    else $element[$index]['message'] = 'En revision';
                }
            }
            array_push($classroomList, $element);
        }
        
        return $classroomList;
    }

    /**
     * Retrieve a list of all disponible classrooms by block for a date and time slots 
     * @param array $data
     * @return array
     */
    public function getClassroomsByDisponibility(array $data): array
    {
        $result = []; 
        $classrooms = $this->classroomRepository->getClassroomsByBlock(
            $data['block_id']
        ); 
        $usedClassrooms = []; 
        foreach ($classrooms as $classroom) 
            $usedClassrooms[$classroom['classroom_id']] = 0; 
        $reservations = $this->reservationRepository->getReservations(
            [
                'dates' => [
                    'date_start' => $data['date'], 
                    'date_end' => $data['date']
                ],
                'reservation_statuses' => [
                    ReservationStatuses::accepted(),
                    ReservationStatuses::pending()
                ],
                'time_slots' => $data['time_slot_ids'],
                'classrooms' => array_map(
                    function ($classroom) 
                    {
                        return $classroom['classroom_id'];
                    },
                    $classrooms
		        ),
		        'priorities' => [1],
                'academic_period' => $data['academic_period_id'],
            ]
	    );
        if (array_key_exists('endpoint', $data)) {
            foreach ($reservations as $reservation) 
            foreach ($reservation['classrooms'] as $classroom) {
                if (!array_key_exists($classroom['classroom_id'], $usedClassrooms))
                    $usedClassrooms[$classroom['classroom_id']] = 0;
                
                if ($usedClassrooms[$classroom['classroom_id']] == 1) 
                    continue;

                if ($reservation['reservation_status'] == 'PENDIENTE') {
                    $usedClassrooms[$classroom['classroom_id']] = 2; 
                }
                else $usedClassrooms[$classroom['classroom_id']] = 1;
            }
        } else {
            foreach ($reservations as $reservation) 
            foreach ($reservation['classrooms'] as $classroom)
                $usedClassrooms[$classroom['classroom_id']] = 1;
        }
    
        foreach ($classrooms as $classroom) 
        if ($usedClassrooms[$classroom['classroom_id']] != 1) {
            $classroom['requested'] = 0;
            if ($usedClassrooms[$classroom['classroom_id']] == 2) 
                $classroom['requested'] = 1;
            $result = array_merge($result, [$classroom]);
        }
        return $result;
    }

    /**
     * Function suggest a set of classrooms for a booking
     * @param array $data
     * @return array
     */
    public function suggestClassrooms(array $data): array
    {
        $classroomSet = $this->getClassroomsByDisponibility($data); 
	    $classroomSets = []; 
        $maxFloor = $this->blockRepository
            ->getBlock($data['block_id'])['maxfloor'];
        for ($i = 0; $i <= $maxFloor; $i++) 
            $classroomSets[$i] = [
                'quantity' => 0,
                'list' => array()
            ];
        for ($i = 0; $i < count($classroomSet); $i++) {

            $classroom = $classroomSet[$i];
            $classroomSets[$classroom['floor']]['quantity'] += $classroom['capacity'];
            array_push($classroomSets[$classroom['floor']]['list'], $classroom);
        }

        $MAX_LEN = 1e4 + 10;
        $INF = 1e6;
        $dp = array_fill(0, $MAX_LEN + 1, $INF);
        $pointerDp = array_fill(0, $MAX_LEN + 1, -1);
        $dp[0] = 0;
        for ($i = 0; $i <= $maxFloor; $i++)
            for ($j = $MAX_LEN; $j > -1; $j--)
                if ($dp[$j] < $INF) {
                    $index = $j + $classroomSets[$i]['quantity'];
                    if ($index > $MAX_LEN) break;
                    $len = $dp[$j] + count($classroomSets[$i]['list']);

                    if ($dp[$index] > $len) {
                        $dp[$index] = $len;
                        $pointerDp[$index] = $i;
                    }
                }
        $bestSuggest = -1;
        for (
            $i = $data['quantity']; 
            ($i <= $MAX_LEN) && 
            (
                ($i <= 5*$data['quantity']) || 
                ($bestSuggest == -1)
            ); 
            $i++
        ) {
            if (($bestSuggest == -1) || ($dp[$bestSuggest] < $dp[$i])) {
                if ($dp[$i] < $INF) 
                    $bestSuggest = $i;
            }
        }

        if (($bestSuggest == -1) || ($pointerDp[$bestSuggest] == -1)) {
            return ['No existe una sugerencia apropiada'];
        }

        $classrooms = array();
        $piv = $bestSuggest;
        while ($piv > 0) {
            $itemId = $pointerDp[$piv];
            foreach ($classroomSets[$itemId]['list'] as $classroom)
                array_push($classrooms, $classroom);
            $piv = $piv - $classroomSets[$itemId]['quantity'];
        }

        $dp = array_fill(0, $MAX_LEN + 1, -1);
        $pointerDp = array_fill(0, $MAX_LEN, -1);
        $dp[0] = 0;
        foreach ($classrooms as $classroom) {
            for ($j = $MAX_LEN; $j > -1; $j--) 
                if ($dp[$j] != -1) {
                    $index = $j + ($classroom['capacity']);
                    if ($index > $MAX_LEN) continue;
                    $len = $dp[$j] + 1;
                    if (($dp[$index] == -1) || ($dp[$index] > $len)) {
                        $dp[$index] = $len;
                        $pointerDp[$index] = $classroom['classroom_id'];
                    }
                }
        }

        $bestSuggest = $data['quantity'];
        for ($i = $data['quantity']; $i <= $MAX_LEN; $i++)
            if ($dp[$i] != -1)
                if (($dp[$bestSuggest] == -1) || ($dp[$bestSuggest] > $dp[$i]))
                    $bestSuggest = $i;

        $res = array();
        $piv = $bestSuggest;
        if (($dp[$piv] == -1) || 
            ($piv > 1.5*$data['quantity']) || 
            ($piv < 0.5*$data['quantity'])
        ) {
            return ['No existe una sugerencia apropiada'];
        }

        while ($piv != 0) {
            $classroom = $this->classroomRepository
                ->getClassroomById($pointerDp[$piv]);
            array_push($res, $classroom);
            $piv -= $classroom['capacity'];
        }
        return $res;
    }

    /**
     * Function to retrive all statuses except deleted
     * @param none
     * @return array
     */
    public function getClassroomStatuses(): array
    {
        return $this->classroomStatusRepository->getStatuses();
    }

    /**
     * Function to retrieve a classroom not deleted and with a date earlier than the provided date
     * @param array $data
     * @return array
     */
    public function retriveLastClassroom(array $data): array
    {
        return $this->classroomLogRepository->retriveLastClassroom($data);
    }

    /**
     * Function to delete classroom through classroom ID and cancel or reject all reservations
     * @param int $classromId
     * @return array
     */
    public function deleteByClassroomId(int $classroomId): array
    {
        $this->reservationService->cancelAndRejectReservationsByClassroom(
            $classroomId
        );
        $classroom = $this->classroomRepository->deleteByClassroomId($classroomId); 
        $data = [];
        $data['title'] = 'ELIMINACION DE AMBIENTE '.$classroom['name'].'#'.$classroom['classroom_id'];
        $data['sended'] = 1;
        $data['sendBy'] = PersonRepository::system();
        $data['to'] = ['TODOS']; 
        $data['type'] = NotificationTypeRepository::informative();
        $data['body'] = 'Se elimino el ambiente denominado '.$classroom['name'];

        $emailData = $this->notificationService->store($data);
        $emailData = array_merge($emailData, $classroom);

        $this->mailService->sendDeleteClassroomEmail($emailData);

        return ['message' => 'Ambiente '.$classroom['name'].' eliminado exitosamente.'];
    }

    /**
     * delete a set of classrooms all in one 
     * @param array $classroomIds
     * @return array
     */
    public function deleteClassroomsByIds(array $classroomIds): array 
    {
        foreach ($classroomIds as $classroomId)
            $this->deleteByClassroomId($classroomId);
        return [];
    }

    /**
     * Function to retrieve statistics from a classroom by start and end date, along with a classroom ID
     * @param array $data
     * @return array
     */
    public function getClassroomStats(array $data): array
    {
        return $this->classroomRepository->getClassroomStats($data);
    }

    /**
     * Disable a single classroom based on its id
     * @param int $classroom_id
     * @return string
     */
    public function disable(int $classroomId): string 
    {
        $classroom = $this->getClassroomById($classroomId);
        $this->classroomRepository->disable($classroomId);
        $reservations = $this->reservationService->getActiveReservationsByClassroom(
                $classroom['classroom_id']
            );
        $dp = [];
        foreach ($reservations as $reservation)
            if ($reservation['repeat'] == 0) {
                if ($reservation['special'] == 0) {
                    $this->reservationService->reject(
                        $reservation['reservation_id'],
                        'Su reserva ha sido rechazada debido a que el ambiente '.$classroom['name'].' fue deshabilitado',
                        PersonRepository::system()
                    );    
                } else {
                    if (array_key_exists($reservation['parent_id'], $dp)) 
                        continue;
                    $dp[$reservation['parent_id']] = 1; 
                    $capacity = 0; 
                    $reservation = $this->reservationRepository
                        ->getSpecialReservation($reservation['parent_id']); 
                    foreach ($reservation['classrooms'] as $classroom) {
                        $classroomData = $this->getClassroomByID($classroom['classroom_id']);
                        if ($classroomData['classroom_status_id'] == ClassroomStatusRepository::disabled()) 
                            continue;
                        $capacity += $classroomData['capacity'];
                    }    
                    if ($capacity < $reservation['quantity']) {
                        $this->reservationService->specialCancel($reservation['parent_id']);
                    }
                }
        }

        return 'Ambiente '.$classroom['name'].' deshabilitado correctamente';
    }

    /**
     * Retrieve a boolean value to correct if a set of classrooms are in the same block 
     * @param array $classromIds
     * @return bool 
     */
    public function sameBlock(array $classroomIds): bool
    {
        $block = -1;
        foreach ($classroomIds as $classroomId) {
            $classroom = $this->classroomRepository->getClassroomById($classroomId); 
            if ($block == -1) $block = $classroom['block_id'];
            if ($block != $classroom['block_id']) 
                return False;
        }
        return True;
    }
}
