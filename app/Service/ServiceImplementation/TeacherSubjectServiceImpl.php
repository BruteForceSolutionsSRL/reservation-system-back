<?php
namespace App\Service\ServiceImplementation;

use App\Http\Controllers\AcademicPeriodController;
use App\Service\TeacherSubjectService;

use App\Models\{
    Reservation,
    TeacherSubject
};

use App\Repositories\{
    AcademicPeriodRepository,
    TeacherSubjectRepository,
    ReservationStatusRepository as ReservationStatuses,
    ReservationRepository,
    PersonRepository
};

use Carbon\Carbon;

class TeacherSubjectServiceImpl implements TeacherSubjectService
{
    private $teacherSubjectRepository; 
    private $academicPeriodRepository;
    private $reservationRepository;
    private $personRepository;

    private $reservationService;

    public function __construct()
    {
        $this->teacherSubjectRepository = new TeacherSubjectRepository();
        $this->academicPeriodRepository = new AcademicPeriodRepository();
        $this->reservationRepository = new ReservationRepository();
        $this->personRepository = new PersonRepository();

        $this->reservationService = new ReservationServiceImpl();
    }

    /**
     * Retrieve all teacher subjects 
     * @return mixed
     */
    public function getAllTeacherSubjects() {
        return $this->teacherSubjectRepository->getAllTeacherSubjects(); 
    }

    /**
     * Retrieve a list of university subjects with teacher id
     * @param int $teacherID
     * @return array
     */
    public function getSubjectsByTeacherId(int $teacherID): array
    {
        $result = $this->getTeacherSubjectByParams(
            ['person_id' => $teacherID]
        );
        $result['university_subjects'] = [];
        $dp = []; 
        foreach ($result as $teacherSubject) {
            if (empty($teacherSubject)) {
                continue;
            }
            if (array_key_exists($teacherSubject['subject_id'], $dp)) {
                continue;
            }
            $dp[$teacherSubject['subject_id']] = 1;
            array_push($result['university_subjects'], [
                'subject_id' => $teacherSubject['subject_id'], 
                'subject_name' => $teacherSubject['subject_name'],
            ]);
        }

        return $result;
    }
    
    /**
     * Retrieve a list of teachers which dictates a university subject
     * @param int $universitySubjectID
     * @return array
     */
    public function getTeachersBySubjectId(int $universitySubjectID): array
    {
        return ($this->teacherSubjectRepository
            ->getTeachersBySubject($universitySubjectID)); 
    }

    /**
     * Retrive all teacher subjects by query params
     * @param array $data
     * @return array
     */
    public function getTeacherSubjectByParams(array $data): array 
    {
        return $this->teacherSubjectRepository->getTeacherSubjects($data); 
    }

    /**
     * Special format for teacher subjects by a single academic period
     * @param array $teacherSubjects
     * @param int $academicPeriodId
     * @return array
     */
    public function formatByAcademicPeriod(array $teacherSubjects, int $academicPeriodId): array
    {
        return array_map(
            function ($teacherSubject) use ($academicPeriodId) {
                $reservations = $this->reservationRepository->getReservations([
                    'academic_period' => $academicPeriodId, 
                    'teacher_subjects' => [$teacherSubject['group_id']], 
                    'configuration_flag' => 1,
                    'repeat' => 7,
                ]);
                $result = $teacherSubject; 
                $result['class_schedules'] = []; 
                foreach ($reservations as $reservation) {
                    $item = [
                        'day' => Carbon::parse($reservation['date'])->dayOfWeek - 1, 
                        'classroom' => $reservation['classrooms'][0],
                        'time_slots' => $reservation['time_slot'],
                    ];
                    array_push($result['class_schedules'], $item);
                }

                return $result; 
            }, 
            $teacherSubjects
        );
    }

    /**
     * Store a single group - teacher subject
     * @param array $data
     * @return array
     */
    public function saveGroup(array $data): array
    {
        $data['teacher_subject_ids'] = [$this->teacherSubjectRepository->saveGroup($data)['group_id']];
        $errors = [];
        $reservations = [];
        $academicPeriod = $this->academicPeriodRepository->getAcademicPeriodById($data['academic_period_id']);
        foreach ($data['class_schedules'] as $class) {
            $reservationData = [];
            $reservationData['time_slot_ids'] = $class['time_slot_ids'];
            $reservationData['quantity'] = 25;
            $reservationData['repeat'] = 7;
            $reservationData['reservation_reason_id'] = 2;
            $reservationData['reservation_status_id'] = ReservationStatuses::pending();
            $reservationData['priority'] = 0;
            $reservationData['academic_period_id'] = $data['academic_period_id'];
            $reservationData['configuration_flag'] = 1;
            $reservationData['verified'] = 1; 
            $reservationData['classroom_ids'] = [$class['classroom_id']];
            $reservationData['persons'] = $this->personRepository->getTeachersBySubjectGroups(
                $data['teacher_subject_ids']
            );
            $reservationData['date'] = Carbon::parse($academicPeriod['initial_date'])->next($class['day']+1); 
            $reservation = $this->reservationRepository->save($reservationData);
            $message = $this->reservationService->accept($reservation['reservation_id'], true);
            $pos = strpos($message, 'aceptada');
            if ($pos === false) {
                array_push($errors, $message);
            }
            array_push($reservations, $reservation['reservation_id']);
        }
        if (!empty($errors)) {
            foreach ($reservations as $reservationId) {
                $this->reservationRepository
                    ->updateReservationStatus($reservationId, ReservationStatuses::cancelled());
            }
            return ['message' => 'Existe error(es): '.implode(',', $errors)];
        }
        return ['message' => 'Grupo creado con exito'];
    }
}