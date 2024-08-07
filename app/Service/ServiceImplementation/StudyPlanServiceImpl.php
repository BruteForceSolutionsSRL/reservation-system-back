<?php

namespace App\Service\ServiceImplementation;

use App\Repositories\StudyPlanRepository; 

class StudyPlanServiceImpl
{
    private $studyPlanRepository; 

    public function __construct()
    {
        $this->studyPlanRepository = new StudyPlanRepository();
    }

    /**
     * Retrive all study plans 
     * @return array
     */
    public function getAllStudyPlans(): array
    {
        return $this->studyPlanRepository->getAllStudyPlans(); 
    }

    /**
     * Retrieve all study plans by a set of faculties
     * @param array $data
     * @return array
     */
    public function obtainStudyPlansBySetOfFaculties(array $data): array 
    {
        return $this->studyPlanRepository->getStudyPlans($data);
    }

    /**
     * Attach a academic period to an study plan 
     * @param int $studyPlanId
     * @param int $academicPeriodId
     * @return void
     */
    public function attachAcademicPeriod(int $studyPlanId, int $academicPeriodId) 
    {
        $this->studyPlanRepository->addAcademicPeriod($studyPlanId, $academicPeriodId);
    }
}