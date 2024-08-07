<?php
namespace App\Service\ServiceImplementation;

use App\Repositories\UniversitySubjectRepository;
use App\Service\UniversitySubjectService;

class UniversitySubjectImpl implements UniversitySubjectService
{
    private $universitySubjectRepository;

    public function __construct()
    {
        $this->universitySubjectRepository = new UniversitySubjectRepository();
    }

    /**
     * Retrieve a single university subject by its id
     * @param int $universitySubjectId
     * @return array
     */
    public function getUniversitySubject(int $universitySubjectId): array 
    {
        return $this->universitySubjectRepository
            ->getUniversitySubject($universitySubjectId);
    }

    /**
     * Delete a university subject 
     * @param int $universitySubjectId
     * @return string
     */
    public function delete(int $universitySubjectId): string 
    {
        $this->universitySubjectRepository->delete($universitySubjectId);
        return 'La materia fue eliminada correctamente';
    }

    /**
     * get all the subjects registered in the system
     *
     * @return array
     */
    public function getAllUniversitySubject(): array
    {
        return $this->universitySubjectRepository->getAllUniversitySubjects();
    }

    /**
     * Store a single university subject
     * @param array $data
     * @return string
     */
    public function store(array $data): string 
    {
        $universitySubject = $this->universitySubjectRepository->store($data); 
        return 'Se realizo el registro correctamente del la materia '.$universitySubject['name'].'('.$universitySubject['university_subject_id'].')';
    }
}

