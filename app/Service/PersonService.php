<?php
namespace App\Service; 

interface PersonService
{
	function getUser(int $id): array;
	function getAllUsers(): array;
}