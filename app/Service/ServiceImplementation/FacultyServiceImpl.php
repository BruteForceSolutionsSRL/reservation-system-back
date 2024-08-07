<?php
namespace App\Service\ServiceImplementation; 

use App\Service\FacultyService;

use App\Repositories\{
	FacultyRepository,
	PersonRepository
}; 

use Carbon\Carbon;

class FacultyServiceImpl implements FacultyService
{
	private $facultyRepository; 
	private $personRepository; 

	public function __construct() {
		$this->facultyRepository = new FacultyRepository(); 
		$this->personRepository = new PersonRepository();
	}

	/**
	 * Retrieve a list of all faculties
	 * @return array
	 */
	public function getAllFaculties(): array 
	{
		return $this->facultyRepository->getAllFaculties(); 
	}

	/**
	 * Retrieve a list of all faculties by user
	 * @param int $personId
	 * @return array
	 */
	public function getAllFacultiesByUser(int $personId): array 
	{
		$now = Carbon::now()->format('Y-m-d'); 
		return $this->facultyRepository->getAllFacultiesByUser($personId, $now);
	}

}