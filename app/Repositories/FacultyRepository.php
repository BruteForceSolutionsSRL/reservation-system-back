<?php
namespace App\Repositories;

use App\Models\Faculty; 

class FacultyRepository
{
    protected $model; 
    
    public function __construct()
    {
        $this->model = Faculty::class; 
    }

    /**
     * Retrieve all registered faculties
     * @return array
     */
    public function getAllFaculties(): array
    {
        return $this->model::all()->map(
            function ($faculty) 
            {
                return $this->formatOutput($faculty);
            }
        )->toArray();
    }

    /**
     * Get all faculties based on user who is part of a university subject into some academic_period
     * @param int $personId
     * @param string $date
     * @return array
     */
    public function getAllFacultiesByUser(int $personId, string $date): array 
    {
        return $this->model::whereHas('academicPeriods', 
                function ($query) use ($date) 
                {
                    $query->where('initial_date', '<=', $date)
                        ->where('end_date', '>=', $date); 
                }
            )->whereHas('academicPeriods.studyPlans.universitySubjects.teacherSubjects', 
                function ($query) use ($personId)
                {
                    $query->where('person_id', $personId); 
                }
            )->get()->map(
                function ($faculty)
                {
                    return $this->formatOutput($faculty); 
                }
            )->toArray();
    }

    /**
     * Get a faculty based on its ID
     * @param int $facultyId
     * @return array
     */
    public function getFacultyByID(int $facultyId): array 
    {
        return $this->formatOutput($this->model::find($facultyId));
    }

    /**
     * Transform Faculty Model to array
     * @param mixed $faculty
     * @return array
     */
    public function formatOutput($faculty): array 
    {
        return [
            'faculty_id' => $faculty->id,
            'name' => $faculty->name,
            'time_slot_id' => $faculty->time_slot_id,
        ];
    }
}