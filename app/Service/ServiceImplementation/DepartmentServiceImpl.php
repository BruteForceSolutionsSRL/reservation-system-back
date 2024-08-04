<?php 
namespace App\Service\ServiceImplementation;

use App\Repositories\DepartmentRepository;

class DepartmentServiceImpl
{
	private $departmentRepository; 

	public function __construct()
	{
		$this->departmentRepository = new DepartmentRepository();
	}

	public function getAllDepartments()
	{
		return $this->departmentRepository->getAllDepartments();
	}
}