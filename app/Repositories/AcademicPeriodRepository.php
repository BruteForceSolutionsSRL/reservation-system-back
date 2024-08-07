<?php
namespace App\Repositories;

use App\Models\AcademicPeriod;
use Carbon\Carbon; 

class AcademicPeriodRepository 
{
    protected $model; 
    private $academicManagementRepository;

    public function __construct()
    {
        $this->model = AcademicPeriod::class;

        $this->academicManagementRepository = new AcademicManagementRepository();
    }

    /**
     * Retrieve a single academic period based on its ID
     * @param int $academicPeriodId
     * @return array
     */
    public function getAcademicPeriod(int $academicPeriodId): array 
    {
        return $this->formatOutput($this->model::find($academicPeriodId));
    }

    /**
     * Retrieve all academic periods of all faculties 'active' by the actual date
     * @param string $date
     * @return array
     */
    public function getActiveAcademicPeriods(string $date): array 
    {
        return $this->model::where('initial_date', '<=', $date)
            ->where('end_date', '>=', $date)
            ->get()->map(
                function ($academicPeriod) 
                {
                    return $this->formatOutput($academicPeriod);
                }
            )->toArray();
    }

    /**
     * Retrieve a single academic period based on which faculty it belongs
     * @param int $facultyId
     * @return array
     */
    public function getActualAcademicPeriod(int $facultyId): array 
    {
        $now = Carbon::now();
        $now = $now->format('Y-m-d');
        return $this->formatOutput(
            $this->model::where('faculty_id', $facultyId)
                ->where('initial_date', '<=', $now)
                ->where('end_date', '>=', $now)
                ->get()->first()
        );
    }

    /**
     * Get a single academic period by its ID.
     * @param int $academicPeriodId
     * @return array
     */
    public function getAcademicPeriodById(int $academicPeriodId): array 
    {
        return $this->formatOutput(
            $this->model::find($academicPeriodId)
        );
    }

    /**
     * Register a new academic period
     * @param array $data
     * @return array
     */
    public function store(array $data): array 
    {
        $academicPeriod = new $this->model(); 
        $academicPeriod->name = $data['name'];
        $academicPeriod->initial_date = $data['date_start'];
        $academicPeriod->end_date = $data['date_end'];
        $academicPeriod->initial_date_reservations = $data['initial_date_reservations'];
        $academicPeriod->faculty_id = $data['faculty_id'];
        $academicPeriod->academic_management_id = $data['academic_management_id'];
        $academicPeriod->activated = 1;

        $academicPeriod->save();
        return $this->formatOutput($academicPeriod);
    }

    /**
     * Update a single academic period with new variables.
     * @param array $data
     * @param int $academicPeriodId
     * @return array
     */
    public function update(array $data, int $academicPeriodId): array 
    {
        $academicPeriod = $this->model::find($academicPeriodId);
        
        if (array_key_exists('date_start', $data)) {
            $academicPeriod->initial_date = $data['date_start'];            
        } 
        
        if (array_key_exists('date_end', $data)) {
            $academicPeriod->end_date = $data['date_end'];
        }
        
        if (array_key_exists('initial_date_reservations', $data)) {
            $academicPeriod->initial_date_reservations = $data['initial_date_reservations'];
        }
        
        if (array_key_exists('faculty_id', $data)) {
            $academicPeriod->faculty_id = $data['faculty_id'];
        }
        
        if (array_key_exists('academic_management_id', $data)) {
            $academicPeriod->academic_management_id = $data['academic_management_id'];
        }

        if (array_key_exists('activated', $data)) {
            $academicPeriod->activated = $data['activated'];
        }

        $academicPeriod->save();
        return $this->formatOutput($academicPeriod);
    }

    /**
     * Get all academic periods based on all query params 
     * @param array $data
     * @return array
     */
    public function getAcademicPeriods(array $data): array 
    {
        $query = AcademicPeriod::with([
            'studyPlans:id,name',
            'reservations:id',
            'faculty:id,name', 
            'academicManagement:id,name'
        ]); 

        if (array_key_exists('date', $data)) {
            if (!array_key_exists('date_end', $data)) {
                $data['date_end'] = $data['date'];
            }
            $query->where(
                function ($query) use ($data){
                    $query->where('initial_date', '<=', $data['date'])
                        ->where('end_date', '>=', $data['date_end']);
                }
            );
        }

        if (array_key_exists('name', $data)) {
            $query->where('name', $data['name']);
        }

        if (array_key_exists('facultyId', $data)) {
            $query->where('faculty_id', $data['facultyId']);
        }

        return $query->get()->map(
            function ($academicPeriod) {
                return $this->formatOutput($academicPeriod);
            }
        )->toArray();
    }

    /**
     * Transform Academic Period Model to array
     * @param mixed $academicPeriod
     * @return array
     */
    public function formatOutput($academicPeriod) 
    {
        if ($academicPeriod === null) return [];
        return [
            'academic_period_id' => $academicPeriod->id,
            'name' => $academicPeriod->name,
            'initial_date' => $academicPeriod->initial_date,
            'end_date' => $academicPeriod->end_date,
            'activated' => $academicPeriod->activated,
            'initial_date_reservations' => $academicPeriod->initial_date_reservations,
            'faculty_id' => $academicPeriod->faculty->id, 
            'faculty_name' => $academicPeriod->faculty->name, 
            'academic_management_id' => $academicPeriod->academicManagement->id, 
            'academic_management_name' => $academicPeriod->academicManagement->name,
            'academic_management' => $this->academicManagementRepository
                ->getAcademicManagement($academicPeriod->academicManagement->id),
        ];
    }
}