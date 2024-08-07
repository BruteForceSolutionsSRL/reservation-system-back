<?php

namespace App\Http\Controllers;

use Illuminate\Http\{
    Request,
    JsonResponse as Response
};

use App\Service\ServiceImplementation\DepartmentServiceImpl;

class DepartmentController extends Controller
{
    private $departmentService; 
    public function __construct()
    {
        $this->departmentService = new DepartmentServiceImpl();
    }

    /**
     * Retrieve a list of all departments
     * @return \Illuminate\Http\JsonResponse
     */
    public function list(): Response
    {
        try {
            return response()->json($this->departmentService->getAllDepartments(), 200);
        } catch (\Exception $e) {
            return response()->json(
                [
                    'message' => 'Se ha producido un error en el servidor.', 
                    'error' => $e->getMessage()
                ],
                500
            );
        }
    }
}
