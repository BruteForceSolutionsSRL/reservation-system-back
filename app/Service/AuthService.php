<?php
namespace App\Service;

interface AuthService
{
    function store(array $data): array;
    function resetPassword(array $data): array;
    function changePassword(array $data): array;
}

