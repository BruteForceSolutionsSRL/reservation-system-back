<?php
namespace App\Service; 

interface PersonService
{
	function store(array $data): array;
	function getUser(int $id): array;
	function getAllUsers(): array;
	function havePermission(array $data):bool;
	function getRoles(int $personId):array ;
}