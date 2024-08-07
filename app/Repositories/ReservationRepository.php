<?php

namespace App\Repositories;

use App\Models\{
    Reservation,
    Person
};


use App\Repositories\{
    ReservationStatusRepository as ReservationStatuses,
    ClassroomLogsRepository
};

use App\Service\ServiceImplementation\TimeSlotServiceImpl;
use Carbon\Carbon;
use DateTime;

use Illuminate\Cache\Repository;
use Illuminate\Support\Facades\DB;

class ReservationRepository extends Repository
{
    protected $model;
    private $timeSlotService;
    private $classroomLog;
    private $timeSlotRepository; 
    function __construct()
    {
        $this->model = Reservation::class;
        $this->timeSlotRepository = new TimeSlotRepository();
        $this->timeSlotService = new TimeSlotServiceImpl();

        $this->classroomLog = new ClassroomLogsRepository();
    }

    /**
     * Retrieve a single Reservation in array by its ID
     * @param int $id
     * @return array
     */
    public function getReservation(int $id): array
    {
        return $this->formatOutput($this->model::with([
            'reservationStatus:id,status',
            'reservationReason:id,reason',
            'timeSlots:id,time',
            'teacherSubjects:id,group_number,person_id,university_subject_id',
            'teacherSubjects.person:id,name,last_name',
            'teacherSubjects.universitySubject:id,name',
            'classrooms:id,name,capacity,block_id',
            'classrooms.block:id,name',
            'classrooms.classroomType:id,description'
        ])->find($id));
    }

    /**
     * Retrieve a list of all reservations
     * @param none
     * @return array
     */
    public function getAllReservations(): array
    {
        return $this->model::with([
            'reservationStatus:id,status',
            'reservationReason:id,reason',
            'timeSlots:id,time',
            'teacherSubjects:id,group_number,person_id,university_subject_id',
            'teacherSubjects.person:id,name,last_name',
            'teacherSubjects.universitySubject:id,name',
            'classrooms:id,name,capacity,block_id',
            'classrooms.block:id,name',
            'classrooms.classroomType:id,description'
        ])->orderBy('date')->get()->map(
            function ($reservation) {
                return $this->formatOutput($reservation);
            }
        )->toArray();
    }

    /**
     * Retrieve a list of reservations except pending request
     * @param none
     * @return array
     */
    public function getReservationsWithoutPendingRequest(): array
    {
        return $this->model::with([
            'reservationStatus:id,status',
            'reservationReason:id,reason',
            'timeSlots:id,time',
            'teacherSubjects:id,group_number,person_id,university_subject_id',
            'teacherSubjects.person:id,name,last_name',
            'teacherSubjects.universitySubject:id,name',
            'classrooms:id,name,capacity,block_id',
            'classrooms.block:id,name',
            'classrooms.classroomType:id,description'
        ])->where('reservation_status_id', '!=', ReservationStatuses::pending())
            ->orderBy('date')
            ->get()->map(
                function ($reservation) {
                    return $this->formatOutput($reservation);
                }
            )->toArray();
    }

    /**
     * Retrieve a list of pending request
     * @param none
     * @return array
     */
    public function getPendingRequest(): array
    {
        $now = Carbon::now()->setTimeZone('America/New_York'); 
        $hourTime = $now->format('H:i:s');
        $date = $now->format('Y-m-d');
        return $this->model::with([
            'reservationStatus:id,status',
            'reservationReason:id,reason',
            'timeSlots:id,time',
            'teacherSubjects:id,group_number,person_id,university_subject_id',
            'teacherSubjects.person:id,name,last_name',
            'teacherSubjects.universitySubject:id,name',
            'classrooms:id,name,capacity,block_id',
            'classrooms.block:id,name',
            'classrooms.classroomType:id,description'
        ])->where(
            function ($query) use ($date, $hourTime)
            {
                $query->where('date', '>', $date);
                $query->orWhere(
                    function ($query) use ($date, $hourTime) {
                        $query->where('date', $date)
                            ->whereHas('timeSlots',
                            function ($query) use ($hourTime)
                            {
                                $query->where('time', '>=', $hourTime);
                            }
                    );
                });
            }
        )
            ->where('reservation_status_id', ReservationStatuses::pending())
            ->where('priority', 0)
            ->orderBy('date')->get()->map(
                function ($reservation) {
                    return $this->formatOutput($reservation);
                }
            )->toArray();
    }

    /**
     * Retrieve a list of all request accepted/pending by teacher ID
     * @param int $teacherId
     * @return array
     */
    public function getRequestByTeacher(int $teacherId): array
    {
        $reservations =  $this->model::with([
            'reservationStatus:id,status',
            'reservationReason:id,reason',
            'timeSlots:id,time',
            'teacherSubjects:id,group_number,person_id,university_subject_id',
            'teacherSubjects.person:id,name,last_name',
            'teacherSubjects.universitySubject:id,name',
            'classrooms:id,name,capacity,block_id',
            'classrooms.block:id,name',
            'classrooms.classroomType:id,description'
        ])->where('date', '>=', Carbon::now()->format('Y-m-d'))
            ->whereIn(
                'reservation_status_id',
                [
                    ReservationStatuses::accepted(),
                    ReservationStatuses::pending()
                ]
            )->whereHas(
                'teacherSubjects',
                function ($query) use ($teacherId) {
                    $query->where('person_id', $teacherId);
                }
            )->orderBy('date')->get()->map(
                function ($reservation) {
                    return $this->formatOutput($reservation);
                }
            )->toArray();

        return $reservations;
    }

    /**
     * Retrieve a list of all request by teacher ID
     * @param int $teacherId
     * @return array
     */
    public function getAllRequestByTeacher(int $teacherId): array
    {
        return $this->model::with([
            'reservationStatus:id,status',
            'reservationReason:id,reason',
            'timeSlots:id,time',
            'teacherSubjects:id,group_number,person_id,university_subject_id',
            'teacherSubjects.person:id,name,last_name',
            'teacherSubjects.universitySubject:id,name',
            'classrooms:id,name,capacity,block_id',
            'classrooms.block:id,name',
            'classrooms.classroomType:id,description'
        ])->whereHas('teacherSubjects', function ($query) use ($teacherId) {
            $query->where('person_id', $teacherId);
        })->orderBy('date')->get()->map(
            function ($reservation) {
                return $this->formatOutput($reservation);
            }
        )->toArray();
    }

    /**
     * Retrieve a list of all active reservations by person id 
     * @param int $personId
     * @return array
     */
    public function getAllActiveRequestByUser(int $personId): array 
    {
        $now = Carbon::now()->setTimeZone('America/New_York'); 
        $hourTime = $now->format('H:i:s');
        $date = $now->format('Y-m-d');
        return $this->model::with([
            'reservationStatus:id,status',
            'reservationReason:id,reason',
            'timeSlots:id,time',
            'teacherSubjects:id,group_number,person_id,university_subject_id',
            'teacherSubjects.person:id,name,last_name',
            'teacherSubjects.universitySubject:id,name',
            'classrooms:id,name,capacity,block_id',
            'classrooms.block:id,name',
            'classrooms.classroomType:id,description'
        ])->whereHas('teacherSubjects', function ($query) use ($personId) {
            $query->where('person_id', $personId);
        })->where(
            function ($query) use ($date, $hourTime)
            {
                $query->where('date', '>', $date);
                $query->orWhere(
                    function ($query) use ($date, $hourTime) {
                        $query->where('date', $date)
                            ->whereHas('timeSlots',
                            function ($query) use ($hourTime)
                            {
                                $query->where('time', '>=', $hourTime);
                            }
                    );
                });
            })
        ->orderBy('date')->get()->map(
            function ($reservation) {
                return $this->formatOutput($reservation);
            }
        )->toArray();
    }

    /**
     * Retrieve a list of all request by teacher ID
     * @param int $teacherId
     * @return array
     */
    public function getReservationsWithoutPendingRequestByTeacher(int $teacherId): array
    {
        $reservations = $this->model::with([
            'reservationStatus:id,status',
            'reservationReason:id,reason',
            'timeSlots:id,time',
            'teacherSubjects:id,group_number,person_id,university_subject_id',
            'teacherSubjects.person:id,name,last_name',
            'teacherSubjects.universitySubject:id,name',
            'classrooms:id,name,capacity,block_id',
            'classrooms.block:id,name',
            'classrooms.classroomType:id,description'
        ])->where('reservation_status_id', '!=', ReservationStatuses::pending())
           ->whereHas('teacherSubjects', function ($query) use ($teacherId) {
               $query->where('person_id', $teacherId);
           })
        ->orderBy('date')->get()->map(
                function ($reservation) {
                    return $this->formatOutput($reservation);
                }
            )->toArray();

        return $reservations;
    }

    /**
     * Function to retrieve a list of all active reservations
     * @param array $statuses
     * @param string $date format must be: 'Y-m-d'
     * @param int $classroomId
     * @return array
     */
    public function getActiveReservationsWithDateStatusAndClassroom(
        array $statuses,
        string $date,
        int $classroomId
    ): array {
        $reservationSet = $this->model::whereHas(
            'classrooms',
            function ($query) use ($classroomId) {
                $query->where('classroom_id', $classroomId);
            }
        )->where(
            function ($query) use ($statuses) {
                foreach ($statuses as $status)
                    $query->orWhere('reservation_status_id', $status);
            }
        )->where(
            function ($query) use ($date) {
                $query->where('date', '>=', date('Y-m-d'));
                $query->where('date', $date);
                $query->orWhere('repeat', '>', 0);
            }
        )->get();
        $result = [];
        foreach ($reservationSet as $reservation) {
            $initialDate = new DateTime($date);
            if ($reservation->repeat > 0) {
                $goalDate = new DateTime($reservation->date);
                $repeat = $reservation->repeat;

                $difference = $initialDate->diff($goalDate)->days;
                if ($difference % $repeat == 0)
                    array_push($result, $reservation);
            } else array_push($result, $reservation);
        }
        return $result;
    }

    /**
     * Function to retrieve a list of all active reservations
     * @param array $statuses
     * @param string $date format must be: 'Y-m-d'
     * @param int $classroomId
     * @param array $times
     * @return array
     */
    public function getActiveReservationsWithDateStatusClassroomTimes(
        array $statuses,
        string $date,
        int $classroomId,
        array $times
    ): array {
        $reservations = $this->getActiveReservationsWithDateStatusAndClassroom(
            $statuses,
            $date,
            $classroomId
        );
        $refinedReservationSet = [];
        foreach ($reservations as $reservation) {
            $time = $this->timeSlotService->getTimeSlotsSorted($reservation->timeSlots);
            if (!($time[1] <= $times[0] || $time[0] >= $times[1])) {
                array_push($refinedReservationSet, $reservation);
            }
        }
        return $refinedReservationSet;
    }

    /** 
     * Store a new Reservation request
     * @param array $data
     * @return array
     */
    public function save(array $data): array
    {
        $data['time_slot_id'][1]--;
        $reservation = new Reservation();
        $reservation->number_of_students = $data['quantity'];
        $reservation->repeat = $data['repeat'];
        $reservation->date = $data['date'];
        $reservation->reservation_reason_id = $data['reason_id'];
        $reservation->reservation_status_id = ReservationStatuses::pending();
        $reservation->priority = $data['priority'];
        if (array_key_exists('observation', $data)) {
            $reservation->observation = $data['observation'];
        }
        else {
            $reservation->observation = 'Ninguna';
        }
        if (array_key_exists('parent_id', $data))
            $reservation->parent_id = $data['parent_id'];
        
        $reservation->save();
        
        if ($reservation->parent_id == NULL) {
            $reservation->parent_id = $reservation->id;
            $reservation->save();
        }
        if (!empty($data['group_id']))
            $reservation->teacherSubjects()->attach($data['group_id']);
        
        if (!empty($data['classroom_id']))
            $reservation->classrooms()->attach($data['classroom_id']);
        $reservation->timeSlots()->attach($data['time_slot_id']);

        return $this->formatOutput($reservation);
    }

    /**
     * Update the reservation status within status id based on its ID
     * @param int $reservationId
     * @param int $statusId
     * @return array
     */
    public function updateReservationStatus(int $reservationId, int $statusId): array 
    {
        $reservation = $this->model::find($reservationId); 
        if ($reservation == null) return []; 
        $reservation->reservation_status_id = $statusId;
        $reservation->save();
        return $this->formatOutput($reservation);
    }

    /**
     * Retrieve a list of reservations with a specified classroom with status
     * @param int $classroomId
     * @param array $statuses
     * @return array
     */
    public function getReservationsByClassroomAndStatuses(
        int $classroomId,
        array $statuses
    ): array 
    {
        return $this->model::whereHas(
            'classrooms',
            function ($query) use ($classroomId) {
                $query->where('classroom_id', $classroomId);
            }
        )->where(
            function ($query) use ($statuses) {
                foreach ($statuses as $status)
                    $query->orWhere('reservation_status_id', $status);
            }
        )->get()
            ->map(
                function ($reservation) {
                    return $this->formatOutput($reservation);
                }
            )->toArray();
    }

    /**
     * Function to retrive reservations accepted and rejected by classroom
     * @param int $classroomId
     * @return array
     */
    public function getAcceptedAndPendingReservationsByClassroom(int $classroomId): array
    {
        $acceptedStatus = ReservationStatuses::accepted();
        $pendingStatus = ReservationStatuses::pending();

        if (!$acceptedStatus || !$pendingStatus) {
            return ['error' => 'Reservation statuses not found.'];
        }

        $reservations = Reservation::whereHas('classrooms', function ($query) use ($classroomId) {
            $query->where('classroom_id', $classroomId);
        })->where(function ($query) use ($acceptedStatus, $pendingStatus) {
            $query->where('reservation_status_id', $acceptedStatus)
                ->orWhere('reservation_status_id', $pendingStatus);
        })->get(['id', 'reservation_status_id']);

        $acceptedReservations = [];
        $pendingReservations = [];

        foreach ($reservations as $reservation) {
            if ($reservation->reservation_status_id === $acceptedStatus) {
                $acceptedReservations[] = $reservation->id;
            } elseif ($reservation->reservation_status_id === $pendingStatus) {
                $pendingReservations[] = $reservation->id;
            }
        }

        return [
            'accepted' => $acceptedReservations,
            'pending' => $pendingReservations,
        ];
    }

    /**
     * Deletes all classrooms attached for a single reservation
     * @param int $reservationId
     * @return void
     */
    public function detachReservationsClassrooms(int $reservationId): void 
    {
        $reservation = $this->model::find($reservationId); 
        $reservation->classrooms()->sync([]);
        $reservation->save();
    }

    /**
     * Attach classrooms for a reservation by its ID
     * @param int $reservationId
     * @param array $classrooms
     * @return array
     */
    public function attachClassroomsReservation(int $reservationId, array $classrooms): array 
    {
        $reservation = $this->model::find($reservationId); 
        $reservation->classrooms()->attach($classrooms);
        return $this->formatOutput($reservation);
    }

    /**
     * Function to format from Reservation class to array
     * @param mixed $reservation
     * @return array
     */
    public function formatOutput($reservation): array
    {
        if ($reservation == null) return [];
        $reservationReason = $reservation->reservationReason;
        $reservationStatus = $reservation->reservationStatus;
        $classrooms = $reservation->classrooms;
        $teacherSubjects = $reservation->teacherSubjects;
        $timeSlots = $reservation->timeSlots;
        $priority = 0;
        $createdAt = $reservation->created_at;
        $updatedAt = $reservation->updated_at;

        $times = []; 
        foreach ($timeSlots as $timeSlot) {
            if (empty($times)) array_push($times, $timeSlot->time);
            else {
                $id = $timeSlot->id;
                $aux = $this->timeSlotRepository->getTimeSlotById(min($id+1, 21));
                array_push($times, $aux['time']);
            }
        }

        $subjectName = 'RESERVA ESPECIAL'; 
        if ($teacherSubjects->first() !== null) 
            $subjectName = $teacherSubjects->first()->universitySubject->name;

        $groups = ['teacher_name' => 'ADMINISTRACION DEL SISTEMA SURA - FCYT.']; 
        if ($teacherSubjects->first() !== null) {
            $groups = $teacherSubjects->map(function ($teacherSubject) {
                $person = Person::find($teacherSubject->person_id);
                return [
                    'teacher_name' => $person->name . ' ' . $person->last_name,
                    'group_number' => $teacherSubject->group_number,
                    'person_email' => $person->email,
                    'person_id' => $teacherSubject->person_id,
                ];
            })->toArray();
        }

        if (Carbon::now()->diffInDays(Carbon::parse($reservation->date)) <= 5) {
            $priority = 1;
        }

        $dp = []; 
        $blockNames = []; 
        foreach ($reservation->classrooms as $classroom) {
            if (array_key_exists($classroom->block->name, $dp)) continue;
            array_push($blockNames, $classroom->block->name);
            $dp[$classroom->block->name] = 1;
        }

        $output =  [
            'reservation_id' => $reservation->id,
            'subject_name' => $subjectName,
            'quantity' => $reservation->number_of_students,
            'reservation_date' => $reservation->date,
            'time_slot' => $times,
            'groups' => $groups,
            'block_name' => $blockNames,
            'classrooms' => $classrooms->map(
                function ($classroom) use ($reservation) {
                    $classroomData = $this->classroomLog->retriveLastClassroom(
                        [
                            'classroom_id' => $classroom->id,
                            'date' => $reservation->created_at
                        ]
                    );
                    return [
                        'classroom_id' => $classroomData['classroom_id'],
                        'classroom_name' => $classroomData['classroom_name'],
                        'capacity' => $classroomData['capacity'],
                        'floor' => $classroomData['floor'],
                    ];
                }
            )->toArray(),
            'reason_name' => $reservationReason->reason,
            'priority' => $priority,
            'special' => $reservation->priority,
            'reservation_status' => $reservationStatus->status,
            'repeat' => $reservation->repeat,
            'date' => $reservation->date,
            'observation' => $reservation->observation,
            'parent_id' => $reservation->parent_id,
            'created_at' => $createdAt,
            'updated_at' => $updatedAt,
        ];
        if ((count($output['block_name']) == 1) && 
            ($reservation->priority == 0)) 
                $output['block_name'] = $output['block_name'][0];
        return $output;
    }

    /**
     * Retrieve a list of all special reservations
     * @return array 
     */
    public function getActiveSpecialReservations(): array 
    {
        $reservations = $this->model::where('priority', 1)
            ->where('date', '>=', Carbon::now()->format('Y-m-d'))
            ->where('reservation_status_id', ReservationStatuses::accepted())
            ->get();
        $dp = [];
        $result = [];
        foreach ($reservations as $reservation) {
            if (array_key_exists($reservation->parent_id, $dp)) {
                array_push($dp[$reservation->parent_id], $reservation->id);
                continue;
            }
            $dp[$reservation->parent_id] = [$reservation->id]; 
            array_push($result, $this->formatOutputSpecial($reservation));
        }
        return array_map(
            function ($reservation) use ($dp) {
                $reservation['reservation_ids'] = $dp[$reservation['parent_id']];
                return $reservation;
            }, $result
        );
    }

    /**
     * Get a single special reservation by its id (for any of all reservations leafs)
     * @param int $reservation
     * @return array
     */
    public function getSpecialReservation(int $reservationId): array 
    {
        return $this->formatOutputSpecial($this->model::find($reservationId));
    }

    /**
     * Format output for a single reservation 
     * @param $reservation
     * @return array
     */
    public function formatOutputSpecial($reservation): array 
    {
        $reservationSet = $this->model::where('priority', 1)
            ->where('parent_id', $reservation->parent_id)
            ->get();
        $reservation = $this->formatOutput($reservation);
        $reservation['date_start'] = $reservation['date'];
        $reservation['date_end'] = $reservation['date'];
        foreach ($reservationSet as $reservationIterator) {
            $reservation['date_start'] = min($reservation['date_start'], $reservationIterator->date);
            $reservation['date_end'] = max($reservation['date_end'], $reservationIterator->date);            
        }
        return $reservation;
    }

    /**
     * Function to format from function "getAllReservationsByClassroom"
     * @param array $classroomId
     * @return array
     */
    public function formatOutputGARBC(array $reservations): array
    {
        if (empty($reservations)) return [];
        $formatReservations = [];
        foreach ($reservations as $reservation) {

            $formatReservations[] = [
                'reservation_id' => $reservation['reservation_id'],
                'subject_name' => $reservation['subject_name'],
                'reason_name' => $reservation['reason_name'],
                'reservation_date' => $reservation['reservation_date'],
                'quantity' => $reservation['quantity'],
                'reservation_status' => $reservation['reservation_status'],
            ];
        }
        return $formatReservations;
    }

    /**
     * Retrieve a list of reports based on the given data.
     * 
     * @param array $data
     * @return array
     */
    public function getReports(array $data): array
    {
        $query = DB::table('reservations')
            ->join('reservation_teacher_subject', 'reservations.id', '=', 'reservation_teacher_subject.reservation_id')
            ->join('teacher_subjects', 'reservation_teacher_subject.teacher_subject_id', '=', 'teacher_subjects.id')
            ->join('people', 'teacher_subjects.person_id', '=', 'people.id')
            ->join('classroom_reservation', 'reservations.id', '=', 'classroom_reservation.reservation_id')
            ->join('classrooms', 'classroom_reservation.classroom_id', '=', 'classrooms.id')
            ->join('blocks', 'classrooms.block_id', '=', 'blocks.id')
            ->join('reservation_time_slot', 'reservations.id', '=', 'reservation_time_slot.reservation_id')
            ->join('time_slots', 'reservation_time_slot.time_slot_id', '=', 'time_slots.id')
            ->join('reservation_reasons', 'reservation_reasons.id', '=', 'reservations.reservation_reason_id')
            ->select(
                'reservations.id as reservation_id',
                'reservations.date',
                DB::raw('CONCAT(people.name, " ", people.last_name) as teacher_name'),
                'blocks.name as block_name',
                'classrooms.name as classroom_name',
                'time_slots.time as time_slot_time',
                'reservations.created_at as date_send',
                'reservations.updated_at as date_approval',
                'reservations.reservation_status_id',
                'reservation_reasons.reason'
            )
            ->whereBetween('reservations.date', [$data['date_start'], $data['date_end']])
            ->whereIn('reservations.reservation_status_id', [
                ReservationStatuses::accepted(), 
                ReservationStatuses::rejected(), 
                ReservationStatuses::cancelled()]
            );

        if (!empty($data['person_id'])) {
            $query->where('people.id', $data['person_id']);
        }

        if (!empty($data['block_id'])) {
            $query->where('blocks.id', $data['block_id']);
        }

        if (!empty($data['classroom_id'])) {
            $query->where('classrooms.id', $data['classroom_id']);
        }

        if (!empty($data['reservation_status_id'])) {
            $query->where('reservations.reservation_status_id', $data['reservation_status_id']);
        }

        if (!empty($data['university_subject_id'])) {
            $query->where('teacher_subjects.university_subject_id', $data['university_subject_id']);
        }

        $acceptedCount = 0;
        $rejectedCount = 0;
        $canceledCount = 0;

        $results = $query->orderBy('reservations.date')->get()->toArray();

        if (empty($results)) {
            return [
                'accepted_reservations' => 0,
                'rejected_reservations' => 0,
                'canceled_reservations' => 0,
                'total_reservations' => 0,
                'report' => []
            ];
        }

        $formattedResults = [];
        foreach ($results as $result) {
            $reservationId = $result->reservation_id;
            if (!isset($formattedResults[$reservationId])) {
                $formattedResults[$reservationId] = [
                    'reservation_id' => $result->reservation_id,
                    'date' => Carbon::parse($result->date)->format('Y-m-d'),
                    'date_send' => Carbon::parse($result->date_send)->format('Y-m-d'),
                    'date_approval' => Carbon::parse($result->date_approval)->format('Y-m-d'),
                    'block_name' => $result->block_name,
                    'reservation_status' => '',
                    'reservation_reason' => $result->reason,
                    'teachers' => [],
                    'classrooms' => [],
                    'time_slots' => [],
                ];
                if ($result->reservation_status_id === ReservationStatuses::accepted()) {
                    $acceptedCount++;
                    $formattedResults[$reservationId]['reservation_status'] = 'ACEPTADO';            
                } else if ($result->reservation_status_id === ReservationStatuses::cancelled()) {
                    $canceledCount++;
                    $formattedResults[$reservationId]['reservation_status'] = 'CANCELADO'; 
                } else if ($result->reservation_status_id === ReservationStatuses::rejected()) {
                    $rejectedCount++;
                    $formattedResults[$reservationId]['reservation_status'] = 'RECHAZADO'; 
                }
            }

            if (!in_array($result->teacher_name, $formattedResults[$reservationId]['teachers'])) {
                $formattedResults[$reservationId]['teachers'][] = $result->teacher_name;
            }

            if (!in_array($result->classroom_name, $formattedResults[$reservationId]['classrooms'])) {
                $formattedResults[$reservationId]['classrooms'][] = $result->classroom_name;
            }

            if (!in_array($result->time_slot_time, $formattedResults[$reservationId]['time_slots'])) {
                $formattedResults[$reservationId]['time_slots'][] = $result->time_slot_time;
            }
        }

        $finalResults = [];
        foreach ($formattedResults as $formattedResult) {
            $classrooms = implode(', ', $formattedResult['classrooms']);
            $timeSlots = $formattedResult['time_slots'];
            $timeSlots = 
                Carbon::parse($timeSlots[0])->format('H:i').
                '-'.
                Carbon::parse($timeSlots[count($timeSlots)-1])->format('H:i');
            foreach ($formattedResult['teachers'] as $teacher) {
                $finalResults [] = [
                    'reservation_id' => $formattedResult['reservation_id'],
                    'date' => $formattedResult['date'],
                    'date_send' => $formattedResult['date_send'],
                    'date_approval' => $formattedResult['date_approval'],
                    'block_name' => $formattedResult['block_name'],
                    'reservation_status' => $formattedResult['reservation_status'],
                    'reservation_reason' => $formattedResult['reservation_reason'],
                    'teacher' => $teacher,
                    'classrooms' => $classrooms,
                    'time_slots' => $timeSlots
                ];
            }
        }

        $totalCount = $acceptedCount + $rejectedCount + $canceledCount;

        return [
            'accepted_reservations' => $acceptedCount,
            'rejected_reservations' => $rejectedCount,
            'canceled_reservations' => $canceledCount,
            'total_reservations' => $totalCount,
            'report' => $finalResults
        ];
    }

    /**
     * Retrieve a list of reports based on the given data.
     * @param array $data
     * @return array
     */
    public function getReservations(array $data): array
    {
        $query = Reservation::with([
            'reservationStatus:id,status',
            'reservationReason:id,reason',
            'timeSlots:id,time',
            'teacherSubjects:id,group_number,person_id,university_subject_id',
            'teacherSubjects.person:id,name,last_name,email',
            'teacherSubjects.universitySubject:id,name',
            'classrooms:id,name,capacity,block_id',
            'classrooms.block:id,name',
            'classrooms.classroomType:id,description'
        ]);
    
        if (!empty($data['reservation_statuses'])) {
            $query->whereIn('reservation_status_id', $data['reservation_statuses']);
        }
    
        if (!empty($data['time_slots'])) {
            $data['time_slots'][1]--;
            $query->whereHas('timeSlots', function($q) use ($data) {
                $q->whereBetween('time_slot_id', $data['time_slots']);
            });
        }
    
        if (!empty($data['classrooms'])) {
            $query->whereHas('classrooms', function($q) use ($data) {
                $q->whereIn('classroom_id', $data['classrooms']);
            });
        }

        if (!empty($data['no_repeat'])) {
            $query->where('repeat', 0);
        }

        if (!empty($data['dates'])) {
            $query->where(
                function ($query) use ($data) {
                    $query->whereBetween('date', [$data['dates']['date_start'], $data['dates']['date_end']])
                    ->orWhere(function ($query) use ($data) {
                        $query->where('repeat', '>', 0)
                            ->where('date', '<=', $data['dates']['date_start'])
                            ->where(function ($query) use ($data) {
                                $query->whereRaw('MOD(DATEDIFF(date, ?), `repeat`) = 0', [$data['dates']['date_start']])
                                    ->orWhereRaw('`repeat` - MOD(DATEDIFF(date, ?), `repeat`) <= DATEDIFF(?, ?)', [
                                        $data['dates']['date_start'],
                                        $data['dates']['date_end'],
                                        $data['dates']['date_start']
                                    ]);
                            });
                    });    
                }
            );
        }

        if (!empty($data['priorities'])) {
            $query->whereIn('priority', $data['priorities']);
        }
        $reservations = $query->orderBy('date')->get()->map(
            function ($reservation) {
                return $this->formatOutput($reservation);
            }
	)->toArray();
        return $reservations;
    }

    /**
     * Function to retrive a special set of special reservations thruogh parent ID
     * @param int $parentId
     * @return mixed
     */
    public function getSpecialReservations(int $parentId)
    {
        return $this->model::with([
            'reservationStatus:id,status',
            'reservationReason:id,reason',
            'timeSlots:id,time',
            'teacherSubjects:id,group_number,person_id,university_subject_id',
            'teacherSubjects.person:id,name,last_name',
            'teacherSubjects.universitySubject:id,name',
            'classrooms:id,name,capacity,block_id',
            'classrooms.block:id,name',
            'classrooms.classroomType:id,description'
        ])->where('parent_id', $parentId)
        ->get();
    }
}
