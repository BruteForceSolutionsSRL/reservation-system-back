<?php
namespace App\Service\ServiceImplementation; 

use App\Service\AcademicPeriodService; 

use App\Repositories\{
	AcademicPeriodRepository,
	ReservationRepository,
	ReservationStatusRepository as ReservationStatuses,
	TimeSlotRepository
};

use Carbon\Carbon;

class AcademicPeriodServiceImpl implements AcademicPeriodService
{
	private $academicPeriodRepository; 
	private $reservationRepository; 
	private $timeSlotRepository;
	private $studyPlanService;
	public function __construct() 
	{
		$this->academicPeriodRepository = new AcademicPeriodRepository();
		$this->reservationRepository = new ReservationRepository();
		$this->timeSlotRepository = new TimeSlotRepository();

		$this->studyPlanService = new StudyPlanServiceImpl();
	}

	public function getAllAcademicPeriods(): array 
	{
		return $this->academicPeriodRepository->getAcademicPeriods([]); 
	} 
	
	public function getAcademicPeriods(array $data): array
	{
		return $this->academicPeriodRepository->getAcademicPeriods(
			$data
		);
	} 

	public function getActualAcademicPeriodByFaculty(int $factultyId): array 
	{
		$now = Carbon::now()->setTimeZone('America/New_York')->format('Y-m-d');
		$result = $this->academicPeriodRepository->getAcademicPeriods(
			[
				'facultyId' => $factultyId, 
				'date' => $now,
			]
		);
		if (empty($result)) {
			return [];
		}
		return $result[0];
	}

	public function getAcademicPeriod(int $academicPeriodId): array
	{
		return $this->academicPeriodRepository->getAcademicPeriod($academicPeriodId); 
	}
	
	public function store(array $data): string 
	{
		if ($this->existsCollision($data)) {
			return 'No se pudo realiza el registro del periodo academico, dado que existe un periodo academico ya registrado en dichas fechas, para la facultad seleccionada';
		}
		$academicPeriod = $this->academicPeriodRepository->store($data);
		return 'Se registro correctamente el periodo academico '.$academicPeriod['name'].'.';
	}

	public function existsCollision(array $data): bool 
	{
		return count($this->academicPeriodRepository->getAcademicPeriods([
			'date' => $data['date_start'],
			'date_end' => $data['date_end'], 
			'facultyId' => $data['faculty_id']
		])) !== 0;
	}

	public function update(array $data, int $academicPeriodId): array
	{
		$academicPeriod = $this->academicPeriodRepository->update($data, $academicPeriodId); 
		return array_merge($academicPeriod, [
			'message' => 'Se actualizo correctamente el periodo academico '.$academicPeriod['name'].'.'
		]);
	}  
	
	/**
	 * Copy an academic period based on its ID, copy: reservations, studyplans, groups of a single academic period
	 * @param array $data
	 * @return string
	 */
	public function copyAcademicPeriod(array $data): string 
	{
		$academicPeriodId = $data['academic_period_id'];
		$academicPeriodToCopy = $this->academicPeriodRepository->getAcademicPeriod($academicPeriodId);
		$data['faculty_id'] = $academicPeriodToCopy['faculty_id'];
		if ($this->existsCollision($data)) {
			return 'No se puede copiar el periodo academico, existe un periodo academico previo entre dichas fechas';
		}
		$academicPeriod = $this->academicPeriodRepository->store($data);
		$studyPlans = $this->studyPlanService->obtainStudyPlansBySetOfFaculties([
			'faculty_ids' => [$data['faculty_id']]
		]);

		foreach ($studyPlans as $studyPlan) {
			$this->studyPlanService->attachAcademicPeriod(
				$studyPlan['study_plan_id'], 
				$academicPeriod['academic_period_id']
			);
		}

		$reservations = $this->reservationRepository->getReservations([
			'academic_period' => $academicPeriodId, 
			'configuration_flag' => 1, 
			'repeat' => 7, 
			'verified' => 1,
		]); 

		foreach ($reservations as $reservation) {
			$date = Carbon::parse($academicPeriod['initial_date'])->next(Carbon::parse($reservation['date'])->dayOfWeek);
			$reservationData = [
				'academic_period_id' => $academicPeriod['academic_period_id'], 
				'time_slot_ids' => array_map(
					function ($timeSlot) {
						return $this->timeSlotRepository->getTimeSlot($timeSlot)['time_slot_id'];
					}, 
					$reservation['time_slot']
				),
				'classroom_ids' => array_map(
					function ($classroom) {
						return $classroom['classroom_id'];
					},
					$reservation['classrooms']
				), 
				'persons' => array_map(
					function ($person) {
						return [
							'person_id' => $person['person_id'], 
							'teacher_subject_ids' => array_map(
								function ($teacherSubject) {
									return $teacherSubject['group_id'];
								}, 
								$person['groups']
							)
						];
					}, $reservation['persons']
				), 
				'quantity' => $reservation['quantity'],
				'reservation_status_id' => $reservation['reservation_status_id'], 
				'reservation_reason_id' => $reservation['reservation_reason_id'],
				'configuration_flag' => 1, 
				'repeat' => $reservation['repeat'], 
				'priority' => $reservation['special'], 
				'date' => $date,
				'verified' => 1,
				'observation' => $reservation['observation'],
			];
			$this->reservationRepository->save($reservationData);
		}

		return 'Se copio de manera correcta el periodo academico '.$academicPeriod['name'];
	}
}