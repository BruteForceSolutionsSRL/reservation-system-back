<?php

namespace App\Http\Controllers;

use App\Service\ServiceImplementation\AcademicManagementServiceImpl;

use Illuminate\Http\{
    Request,
    JsonResponse as Response
};

class AcademicManagementController extends Controller
{
    private $academicManagementService;
    public function __construct() 
    {
        $this->academicManagementService = new AcademicManagementServiceImpl();
    }

    public function list(): Response
    {
        try {
            return response()->json($this->academicManagementService->list(), 200); 
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

    public function index(int $academicManagementId): Response
    {
        try {
            $academicManagement = $this->academicManagementService->getAcademicManagement($academicManagementId);
            if (empty($academicManagement)) {
                return response()->json(
                    ['message' => 'No existe la gestion academica seleccionada, por favor seleccione otra.'], 
                    404
                );
            }
            return response()->json(
                $academicManagement, 
                200
            ); 
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

    public function store(Request $request): Response 
    {
        try {
            $validator = $this->validateAcademicManagement($request); 
            if ($validator->fails()) {
                return response()->json(
                    ['message' => implode(',',$validator->errors()->all())],
                    400
                );
            }
            $data = $validator->validated();
            return response()->json(
                ['message' => $this->academicManagementService->store($data)], 
                200
            ); 
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

    private function validateAcademicManagement(Request $request)
    {
        return \Validator::make($request->all(), [
            'date_start' => 'required|date',
            'date_end' => 'required|date',
            'name' => 'required|string|unique:academic_managements,name',
        ], [
            'date_start.required' => 'La fecha es obligatoria.',
            'date_start.date' => 'La fecha debe ser un formato válido.',

            'date_end.required' => 'La fecha es obligatoria.',
            'date_end.date' => 'La fecha debe ser un formato válido.',

            'name.required' => 'El nombre no puede ser nulo.',
            'name.unique' => 'El nombre no es valido, ya existe una gestion academica con ese nombre, intente con otro nombre.',
            'name.string' => 'El nombre esta vacio, por favor llene correctamente el nombre.',
        ]);
    }

    public function update(Request $request, int $academicManagementId): Response 
    {
        try {
            $validator = $this->validateAcademicManagementUpdate($request); 
            if ($validator->fails()) {
                return response()->json(
                    ['message' => implode(',',$validator->errors()->all())],
                    400
                );
            }
            $data = $validator->validated();
            $academicManagement = $this->academicManagementService->index($academicManagementId);
            if (empty($academicManagement)) {
                return response()->json(
                    ['message' => 'No existe la gestion academica seleccionada, por favor seleccione otra.'], 
                    404
                );
            }

            return response()->json(
                ['message' => $this->academicManagementService->update($data, $academicManagementId)], 
                200
            ); 
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
    private function validateAcademicManagementUpdate(Request $request)
    {
        return \Validator::make($request->all(), [
            'date_start' => 'required|date',
            'date_end' => 'required|date',
        ], [
            'date_start.required' => 'La fecha es obligatoria.',
            'date_start.date' => 'La fecha debe ser un formato válido.',

            'date_end.required' => 'La fecha es obligatoria.',
            'date_end.date' => 'La fecha debe ser un formato válido.',
        ]);
    }
}
