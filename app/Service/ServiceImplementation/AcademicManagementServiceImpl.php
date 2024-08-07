<?php
namespace App\Service\ServiceImplementation; 

use App\Service\AcademicManagementService; 

use App\Repositories\AcademicManagementRepository;

class AcademicManagementServiceImpl implements AcademicManagementService
{
	private $academicManagementRepository; 
	
	public function __construct() 
	{
		$this->academicManagementRepository = new AcademicManagementRepository(); 
	}
	
	/**
	 * Retrieve a list of all Academic Managements
	 * @return array
	 */
	public function list(): array 
	{
		return $this->academicManagementRepository->list(); 
	}

	/**
	 * Retrieve a single academic management based on it id
	 * @param int $academicManagementId
	 * @return array
	 */
	public function getAcademicManagement(int $academicManagementId): array 
	{
		return $this->academicManagementRepository
			->getAcademicManagement($academicManagementId); 
	}
	
	/**
	 * Retrieve a message to inform a user from a store action
	 * @param array $data
	 * @return string
	 */
	public function store(array $data): string 
	{
		$academicManagement = $this->academicManagementRepository->store($data); 
		return 'Se guardo correctamente la gestion academica: '.$academicManagement['name'].'.'; 
	}

	/**
	 * Retrieve a message to inform user to an update action
	 * @param array $data
	 * @param int $academicManagementId
	 * @return string
	 */
	public function update(array $data, int $academicManagementId): string 
	{
		$academicManagement = $this->academicManagementRepository
			->update($data, $academicManagementId); 
		return 'Se actualizo correctamente la gestion academica: '.$academicManagement['name'].'.'; 
	}
}