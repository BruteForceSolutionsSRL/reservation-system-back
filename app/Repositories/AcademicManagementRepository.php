<?php
namespace App\Repositories;

use App\Models\AcademicManagement;
use Carbon\Carbon; 

class AcademicManagementRepository 
{
    protected $model; 

    public function __construct()
    {
        $this->model = AcademicManagement::class;
    }

    /**
     * Retrieve all Academic Managements registered
     * @return array
     */
    public function list(): array 
    {
        return $this->model::all()->map(
            function ($academicManagement) 
            {
                return $this->formatOutput($academicManagement);
            }
        )->toArray();
    }

    /**
     * Retrieve a single academic management based on its id
     * @param int $academicManagementId
     * @return array
     */
    public function getAcademicManagement(int $academicManagementId): array 
    {
        return $this->formatOutput($this->model::find($academicManagementId));
    }

    /**
     * Function to save/register a single Academic Management
     * @param array $data
     * @return array
     */
    public function store(array $data): array 
    {
        $academicManagement = new $this->model(); 
        $academicManagement->name = $data['name']; 
        $academicManagement->initial_date = $data['date_start']; 
        $academicManagement->end_date = $data['date_end'];
        $academicManagement->save(); 
        return $this->formatOutput($academicManagement);
    }

    /**
     * Update a single academic management updating only dates 
     * @param array $data
     * @param int $academicManagementId
     * @return array
     */
    public function update(array $data, int $academicManagementId): array 
    {
        $academicManagement = $this->model::find($academicManagementId);
        if (array_key_exists('date_start', $data)) 
            $academicManagement->initial_date = $data['date_start'];
        if (array_key_exists('date_end', $data)) 
            $academicManagement->end_date = $data['date_end'];
        $academicManagement->save();         
        return $this->formatOutput($academicManagement);
    }

    /**
     * Function to format Academic Management Model to array
     * @param mixed $academicManagement
     * @return array
     */
    public function formatOutput($academicManagement) 
    {
        if ($academicManagement === null) return [];
        return [
            'academic_management_id' => $academicManagement->id,
            'name' => $academicManagement->name,
            'initial_date' => $academicManagement->initial_date,
            'end_date' => $academicManagement->end_date,
        ];
    }
}