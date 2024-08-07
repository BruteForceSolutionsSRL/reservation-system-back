<?php 
namespace App\Service; 

interface AcademicManagementService
{
	function list(): array ;
	function getAcademicManagement(int $academicManagementId): array;
	function store(array $data): string; 
	function update(array $data, int $academicManagementId): string;
}