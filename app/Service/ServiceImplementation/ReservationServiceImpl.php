<?php 
namespace App\Service\ServiceImplementation;

use App\Service\ReservationService;

use App\Models\{
    Reservation, 
    Person,
    Classroom
};
use App\Repositories\{
    PersonRepository, 
    ReservationStatusRepository as ReservationStatuses,
    ReservationRepository
};

class ReservationServiceImpl implements ReservationService 
{
    private $personRepository;
    private $reservationRepository; 
    function __construct()
    {
        $this->personRepository = new PersonRepository(Person::class);
        $this->reservationRepository = new ReservationRepository(Reservation::class);     
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
        if ($teacher == null) {
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
        if ($teacher == null) {
            return ['message' => 'No existe el docente']; 
        }
        return $this->reservationRepository->getAllRequestByTeacher($teacherId);
    }
    /**
     * Function to reject a reservation based on its ID
     * @param int $reservationId
     * @return string
     */
    public function reject(int $reservationId): string 
    {
        $reservation = Reservation::find($reservationId);

        if ($reservation == null) {
            return 'No existe una solicitud con este ID';
        }

        $reservationStatusId = $reservation->reservation_status_id; 
        if ($reservationStatusId == ReservationStatuses::$rejected) {
            return 'Esta solicitud ya fue rechazada';
        }

        if ($reservationStatusId == ReservationStatuses::$pending) {
            $reservation->reservation_status_id = ReservationStatuses::$rejected;
            $reservation->save();

            return 'La solicitud de reserva fue rechazada.';
        } else {
            return 'Esta solicitud ya fue atendida';
        }
    }
    /**
     * Function to cancel a accepted/pending reservation based on its ID
     * @param int $reservationId
     * @return string
     */
    public function cancel(int $reservationId): string 
    {
        $reservation = Reservation::find($reservationId);

        if ($reservation == null) {
            return 'No existe una solicitud con este ID';
        }

        $reservationStatusId = $reservation->reservation_status_id;  
        if ($reservationStatusId == ReservationStatuses::$cancelled) {
            return 'Esta solicitud ya fue cancelada';
        }
        if ($reservationStatusId == ReservationStatuses::$rejected) {
            return 'Esta solicitud ya fue rechazada';
        }

        $reservation->reservation_status_id = ReservationStatuses::$cancelled;
        $reservation->save();

        return 'La solicitud de reserva fue cancelada.';

    }
    /**
     * Function to accept a request of reservation based on its ID
     * @param int $reservationId
     * @return string
     */
    public function accept(int $reservationId): string 
    {
        $reservation = Reservation::find($reservationId);
        if ($reservation==null) {
            return 'La solicitud de reserva no existe';
        }

        $reservationStatus = $reservation->reservationStatus->id;
        if ($reservationStatus != ReservationStatuses::$pending) {
            return 'Esta solicitud ya fue atendida';
        }
        if (!$this->checkAvailibility($reservation)) {
            return  'La solicitud no puede aceptarse, existen ambientes ocupados';
        }
        
        $reservation->reservation_status_id = ReservationStatuses::$accepted;
        $reservation->save();
        
        $times = $this->getTimeSlotsSorted($reservation->timeSlots);
        foreach ($reservation->classrooms as $classroom) {
            $reservationSet = $this->reservationRepository
                ->getActiveReservationsWithDateStatusClassroomTimes(
                    [ReservationStatuses::$pending],
                    $reservation->date,
                    $classroom->id, 
                    $times
                );
            foreach ($reservationSet as $reservationIterable) 
                $this->reject($reservationIterable->id);
        }
        return 'La reserva fue aceptada correctamente';
    }
    /**
     * Function to store full data about a request and automatic accept/reject
     * @param array $data
     * @return string
     */
    public function store(array $data): string 
    {
        // esto es otra funcion
        $block_id = -1;
        foreach ($data['classroom_id'] as $classroomId) {
            $classroom = Classroom::find($classroomId); 
            if ($block_id == -1) $block_id = $classroom->block_id;
            if ($classroom->block_id != $block_id) {
                return  'Los ambientes no pertenecen al bloque';
            }
        }

        if (!array_key_exists('repeat', $data)) {
            $data['repeat'] = 0;
        }

        $reservation = $this->reservationRepository->save($data);

        if ($this->checkAvailibility($reservation)) {
            if ($this->alertReservation($reservation)['ok'] != 0) {
                return  'Tu solicitud debe ser revisada por un administrador, se enviara una notificacion para mas detalles';
            }
            $reservation->reservation_status_id = ReservationStatuses::$accepted;
            $reservation->save();
            return 'Tu solicitud de reserva fue aceptada';
        } else {
            return $this->reject($reservation->id); 
        }
    }
    /**
     * Retrieve an array of all conflicts of a reservation
     * @param int $reservationId
     * @return array
     */
    public function getConflict(int $reservationId): array 
    {
        $reservation = Reservation::find($reservationId);
        if ($reservation == null) {
            return ['meesage' => 'La reserva no existe'];
        }
        $result = $this->alertReservation($reservation);
        unset($result['ok']);
        return $result;
    }
    /**
     * Function to check availability for all classrooms to do a reservation in a step
     * @param Reservation $reservation
     * @return boolean
     */
    private function checkAvailibility(Reservation $reservation): bool
    {
        $time = $this->getTimeSlotsSorted($reservation->timeSlots);
        foreach ($reservation->classrooms as $classroom) {
            $reservations = $this->reservationRepository
                ->getActiveReservationsWithDateStatusClassroomTimes(
                    [ReservationStatuses::$accepted],
                    $reservation->date,
                    $classroom->id, 
                    $time
                );
            if (count($reservations) != 0)
                return false;
        }
        return true;
    }
    /**
     * Check if a reservation in pending status have conflicts or is really `weird`
     * @param Reservation $reservation
     * @return array
     */
    public function alertReservation(Reservation $reservation): array
    {
        $result = [
            'quantity' => '',
            'classroom' => [
                'message' => '',
                'list' => array()
            ],
            'teacher' => [
                'message' => '',
                'list' => array()
            ],
            'ok' => 0
        ];
        $totalCapacity = $this->getTotalCapacity($reservation->classrooms);
        if ($totalCapacity < $reservation->number_of_students) {
            $result['quantity'] .= 'la cantidad de estudiantes excede la capacidad de estudiantes.\n';
            $result['ok'] = 1;
        }

        $usagePercent = $reservation->number_of_students / $totalCapacity * 100;
        if ($usagePercent < 50.0) {
            $message = 'la capacidad de los ambientes solicitados es muy elevada para la capacidad de ambientes solicitados.\n';
            $result['quantity'] .= $message;
            $result['ok'] = 1;
        }

        if ($this->getTotalFloors($reservation->classrooms) > 2) {
            $result['ok'] = 1;
            $message = 'los ambientes solicitados, se encuentran en mas de 2 pisos diferentes\n';
            $result['classroom']['message'] .= $message;
        }

        foreach ($reservation->classrooms as $classroom) {
            $reservations = $this->reservationRepository
                ->getActiveReservationsWithDateStatusAndClassroom(
                    [ReservationStatuses::$pending],
                    $reservation->date,
                    $classroom->id
                );
            if (count($reservations) > 1) {
                $result['ok'] = 1;
                array_push($result['classroom']['list'], $classroom->name);
            }
        }

        foreach ($reservation->teacherSubjects as $teacherSubject) {
            $teacher = $teacherSubject->person; 
            $fullname = $teacher->name . ' ' . $teacher->last_name; 
            $count = 0;

            foreach ($teacherSubject->reservations as $item)
            if (($item->reservation_status_id == ReservationStatuses::$accepted)
                && $this->isInside(
                    $item, 
                    $reservation->date, 
                    $this->getTimeSlotsSorted($reservation->timeSlots))
            )
                $count++;

            if (($count > 3) && (!array_key_exists($fullname, $set))) {
                $result['ok'] = 1;
                array_push($result['teacher']['list'], $fullname);
                $set[$fullname] = 1;
            }
        }
        $result['classroom']['list'] = array_unique($result['classroom']['list']); 
        $result['teacher']['list'] = array_unique($result['teacher']['list']);
        return $result;
    }
    private function getTimeSlotsSorted($timeSlots): array
    {
        $array = array(); 
        foreach ($timeSlots as $timeSlot) 
            array_push($array, $timeSlot->id);
        sort($array); 
        return $array;
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
            $total += $classroom->capacity;
        return $total;
    }
    private function isInside(
        Reservation $reservation, 
        string $date, 
        array $times
    ): bool
    {
        if ($date == $reservation->date) {
            $time = $this->getTimeSlotsSorted($reservation->timeSlots);
            if (!($time[1] <= $times[0] || $time[0] >= $times[1])) {
                return true;
            }
        } else {
            $initialDate = new \DateTime($date);
            if ($reservation->repeat > 0) {
                $goalDate = new \DateTime($reservation->date);
                $repeat = $reservation->repeat;

                $difference = $initialDate->diff($goalDate)->days;
                if ($difference % $repeat == 0) {
                    $time = $this->getTimeSlotsSorted($reservation->timeSlots);
                    if (!($time[1] <= $times[0] || $time[0] >= $times[1])) {
                        return true;
                    }                        
                }
            } 

        }
        return false;
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
            $floor = $classroom->floor;
            if ($dp[$floor] == 0) {
                $dp[$floor] = 1;
                $usedFloors++;
            }
        }
        return $usedFloors; 
    }
}
