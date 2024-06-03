<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse as Response; 

use App\Service\ServiceImplementation\{
    PersonServiceImpl
};

class PersonController extends Controller
{
    private $personService; 

    public function __construct()
    {
        $this->personService = new PersonServiceImpl();
    }

    /**
     * Retrieve information about a single user based on its ID
     * @param int $userIs
     * @param Response
     */
    public function show(int $userId): Response
    {
        try {
            return response()->json(
                $this->personService->getUser($userId),
                200
            );
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Hubo un error en el servidor', 
                    'error' => $e->getMessage()
                ], 
                500
            );
        }
    }

    public function list(): Response
    {
        try {
            return response()->json(
                $this->personService->getAllUsers(),
                200
            );
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Hubo un error en el servidor', 
                    'error' => $e->getMessage()
                ], 
                500
            );
        }
    }
}