<?php  
namespace App\Service; 

interface AcademicPeriodService
{
	function getAllAcademicPeriods(): array; 
	function getAcademicPeriods(array $data): array; 
	function getAcademicPeriod(int $academicPeriodId): array;
	function store(array $data): string; 
	function update(array $data, int $academicPeriodId): array;  
}