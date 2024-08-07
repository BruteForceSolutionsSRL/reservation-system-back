<?php
namespace App\Service; 

interface PersonService
{
	function store(array $data): array;
	function getUser(int $id): array;
	function getUserByEmail(string $email): mixed;
	function getAllUsers(): array;
	function havePermission(array $data):bool;
	function getRoles(int $personId):array ;
	function update(array $data, int $personId): array;
}