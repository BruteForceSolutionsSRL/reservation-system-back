<?php
namespace App\Service\ServiceImplementation; 

use App\Service\PersonService; 

use App\Repositories\{
	PersonRepository,
	RoleRepository
}; 

class PersonServiceImpl implements PersonService 
{
	private $personRepository; 

	private $roleRepository;

	public function __construct() 
	{
		$this->personRepository = new PersonRepository();
		$this->roleRepository = new RoleRepository();
	}

	/**
	 * Retrieve a array with data save of a person
	 * @param array $data
	 * @return array
	 */
	public function store(array $data): array
	{
		return $this->personRepository->store($data);
	}

	/**
	 * Retrieve a single User within its ID
	 * @param int $id
	 * @return array
	 */
	public function getUser(int $id): array
	{
		return $this->personRepository->getPerson($id);
	}

	/**
	 * Retrieve a single User within its email
	 * @param string $email
	 * @return mixed
	 */
	public function getUserByEmail(string $email): mixed
	{
		return $this->personRepository->getPersonByEmail($email);
	}

	/**
	 * Retrieve a list of all users registed 
	 * @param none
	 * @return array
	 */
	public function getAllUsers(): array
	{
		return $this->personRepository->getAllPersons(); 
	}

	/**
	 * Retrieve all teachers 
	 * @param none
	 * @return array
	 */
	public function getAllTeachers(): array 
	{
		return $this->personRepository->getUsersByRole(
			[
				$this->roleRepository->teacher()
			]
		);
	}

	/**
	 * Retrieve if a person have permission
	 * @param array $data
	 * @return bool
	 */
	public function havePermission(array $data):bool 
	{
		return $this->personRepository->havePermission($data);
	}

	/**
	 * Retrieve a list of roles a person has through a person ID
	 * @param int $personId
	 * @return array
	 */
	public function getRoles(int $personId):array 
	{
		return $this->personRepository->getRoles($personId);
	}

	/**
	 * Retrieve a list of all persons based on an array of group ids 
	 * @param array $teacherSubjectIds
	 * @return array
	 */
	public function getPersonsByTeacherSubjectIds(array $teacherSubjecIds): array 
	{
		return $this->personRepository->getTeachersBySubjectGroups($teacherSubjecIds);
	}

	/**
	 * Update a person information
	 * @param array $data
	 * @return array
	 */
	public function update(array $data, int $personId): array 
	{
		return $this->personRepository->update($data, $personId);
	}

	/**
	 * Have a format based on a person object
	 * @param mixed
	 * @return array
	 */
	public function personToArray($person)
	{
		return $this->personRepository->formatOutput($person);
	}
}