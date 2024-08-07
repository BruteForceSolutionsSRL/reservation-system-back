<?php
namespace App\Service; 

interface FacultyService
{
	function getAllFaculties(): array; 
	function getAllFacultiesByUser(int $personId): array; 
}