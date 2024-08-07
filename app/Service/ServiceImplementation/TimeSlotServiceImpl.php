<?php
namespace App\Service\ServiceImplementation;

use App\Repositories\{
    TimeSlotRepository,
    FacultyRepository
}; 

use App\Service\TimeSlotService;

use App\Models\TimeSlot;
class TimeSlotServiceImpl implements TimeSlotService
{
    private $timeSlotRepository; 
    private $facultyRepository; 
    public function __construct()
    {
        $this->timeSlotRepository  = new TimeSlotRepository();
        $this->facultyRepository = new FacultyRepository();
    }

    /**
     * Retrieves a list of all time slots 
     * @param none
     * @return array
     */
    public function getAllTimeSlots(): array
    {
        return $this->timeSlotRepository->getAllTimeSlots();
    }
    
    /**
     * Retrieves a single time slot
     * @param int $timeSlotID
     * @return array
     */
    public function getTimeSlot(int $timeSlotID): array
    {
        return $this->timeSlotRepository->getTimeSlotById($timeSlotID);
    }

    /**
     * Sort two timeSlost by its id
     * @param array $timeSlots
     * @return array
     */
    public function getTimeSlotsSorted(array $times): array
    {
        $array = array_map(
            function ($time) 
            {
                return $this->timeSlotRepository->getTimeSlot($time)['time_slot_id']; 
            },
            $times
        );
        sort($array);
        return $array;
    }

    /**
     * Function to get all time slots available for a single faculty
     * @param int $facultyId
     * @return array
     */
    public function getAllTimeSlotsByFaculty(int $facultId): array 
    {
        $times = $this->getAllTimeSlots();
        $faculty = $this->facultyRepository->getFacultyByID($facultId);
        $result = []; 

        for ($time = $faculty['time_slot_id']; $time < count($times); $time+=3) {
            array_push($result, $this->timeSlotRepository->getTimeSlotById($time)); 
        }

        return $result; 
    }
}