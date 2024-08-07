<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Service\ServiceImplementation\FacultyServiceImpl; 

use Exception;

class FacultyController extends Controller
{
    private $facultyService; 

    public function __construct() 
    {
        $this->facultyService = new FacultyServiceImpl();
    }


    /**
     * Retrieve a list of all faculties
     * @return mixed|\Illuminate\Http\JsonResponse
     */
    public function list() 
    {
        try {
            return response()->json(
                $this->facultyService->getAllFaculties(),
                200
            );
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Ocurrio un error en el servidor.', 
                    'error' => $e->getMessage()
                ],
                500
            );
        }
    }

    public function getFacultiesByUser(Request $request) 
    {
        try {
            $personId = $request['session_id'];
            return response()->json(
                $this->facultyService->getAllFacultiesByUser($personId),
                200
            );
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Ocurrio un error en el servidor.', 
                    'error' => $e->getMessage()
                ],
                500
            );
        }
    }
}
