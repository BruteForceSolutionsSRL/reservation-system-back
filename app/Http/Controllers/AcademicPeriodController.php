<?php

namespace App\Http\Controllers;

use App\Service\ServiceImplementation\AcademicPeriodServiceImpl;

use Illuminate\Http\{
    Request,
    JsonResponse as Response
};

use Exception;

use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;

class AcademicPeriodController extends Controller
{
    private $academicPeriodService;

    public function __construct() 
    {
        $this->academicPeriodService = new AcademicPeriodServiceImpl();
    }

    /**
     * Retrieve a list of all academic periods registeres
     * @return \Illuminate\Http\JsonResponse
     */
    public function list(): Response
    {
        try {
            return response()->json($this->academicPeriodService->getAllAcademicPeriods(), 200); 
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Se ha producido un error en el servidor.', 
                    'error' => $e->getMessage()
                ], 
                500
            );
        }
    }

    /**
     * Retrieve a response of a single academic period 
     * @param int $academicPeriodId
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(int $academicPeriodId): Response
    {
        try {
            $academicPeriod = $this->academicPeriodService
                ->getAcademicPeriod($academicPeriodId);
            if (empty($academicPeriod)) {
                return response()->json(
                    ['message' => 'No existe el periodo academica seleccionado, por favor seleccione otro.'], 
                    404
                );
            }
            return response()->json($academicPeriod, 200); 
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Se ha producido un error en el servidor.', 
                    'error' => $e->getMessage()
                ], 
                500
            );
        }        
    }

    /**
     * Retrieve a single academic period based of an faculty 
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getAcademicPeriodByFaculty(Request $request): Response
    {
        try {
            $facultyId = \JWTAuth::parseToken($request->bearerToken())->getClaim('faculty_id');
            if ($facultyId == -1) {
                $facultyId = $request->input('faculty_id');
            }
            $academicPeriod = $this->academicPeriodService
                ->getActualAcademicPeriodByFaculty($facultyId);
            if (empty($academicPeriod)) {
                return response()->json(
                    ['message' => 'No existe el periodo academica seleccionado, por favor seleccione otro.'], 
                    404
                );
            }
            return response()->json($academicPeriod, 200); 
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Se ha producido un error en el servidor.', 
                    'error' => $e->getMessage()
                ], 
                500
            );
        }
    }

    /**
     * Copy a single academic period with request params
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function copyAcademicPeriod(Request $request): Response 
    {
        try {
            $validator = $this->validateCopying($request);
            if ($validator->fails()) {
                return response()->json([
                    'message' => implode(',', $validator->errors()->all())
                ], 400);
            }
            $data = $validator->validated();

            if ($this->existsNameInAcademicManagement($data['name'], $data['academic_management_id'])) {
                return response()->json([
                    'message' => 'Ya existe un periodo academico con este nombre en esta gestion academica, por favor introduce otro nombre.',
                ], 400);
            }

            if ($data['date_start'] > $data['initial_date_reservations']) {
                return response()->json(
                    ['message' => 'La fecha seleccionada para inicio de aceptacion de reservas no puede empezar antes que la fecha de inicio del periodo academico.'], 
                    400
                );
            }

            if ($data['date_end'] < $data['initial_date_reservations']) {
                return response()->json(
                    ['message' => 'La fecha seleccionada para inicio de aceptacion de reservas no puede ser despues que la fecha de fin del periodo academico.'],
                    400
                );
            }

            $now = Carbon::now()->setTimeZone('America/New_York')->format('Y-m-d');
            if ($now > $data['date_start']) {
                return response()->json(
                    ['message' => 'Fecha de inicio de semestre no puede ser una fecha pasada a la fecha actual.'],
                    400
                );
            }
            $message = $this->academicPeriodService->copyAcademicPeriod($data);
            $pos = strpos($message, 'existe');
            if ($pos !== false) {
                return response()->json(['message' => $message], 400);
            }

            return response()->json($message, 200);
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Se ha producido un error en el servidor.',
                    'error' => $e->getMessage()
                ]
            );
        }
    }

    /**
     * Validate a copy request
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Validation\Validator
     */
    private function validateCopying(Request $request) 
    {
        return \Validator::make($request->all(), 
        [
            'academic_period_id' => 'required|integer|exists:academic_periods,id',
            'date_start' => 'required|date',
            'date_end' => 'required|date',
            'name' => 'required|string|unique:academic_periods,name',
            'academic_management_id' => 'required|int|exists:academic_managements,id',
            'initial_date_reservations' => 'required|date',
        ], 
        [
            'date_start.required' => 'La fecha de inicio de periodo academico es obligatoria.',
            'date_start.date' => 'La fecha de inicio de periodo academico debe ser un formato válido.',

            'date_end.required' => 'La fecha fin del periodo academico es obligatoria.',
            'date_end.date' => 'La fecha fin del periodo academico debe ser un formato válido.',

            'name.required' => 'El nombre no puede ser nulo.',
            'name.unique' => 'El nombre no es valido, ya existe un periodo academica con ese nombre, intente con otro nombre.',
            'name.string' => 'El nombre esta vacio, por favor llene correctamente el nombre.',
            
            'academic_management_id.required' => 'La gestion academica debe ser seleccionada.',
            'academic_management_id.int' => 'La gestion academica seleccionada no es valida, intente otra vez.',
            'academic_management_id.exists' => 'La gestion academica seleccionada no existe.',

            'initial_date_reservations.required' => 'La fecha de inicio de pedir reservas es obligatoria.',
            'initial_date_reservations.date' => 'La fecha de inicio de pedir reservas debe ser un formato válido.',

            'academic_period_id.required' => 'Es necesario el periodo academico que quiere copiar', 
            'academic_period_id.integer' => 'El periodo academico seleccionado no es valido', 
            'academic_period_id.exists' => 'El periodo academico seleccionado no existe',
        ]);
    }

    /**
     * Retrieve if exists a an academcic period name on a single academic management
     * @param string $name
     * @param int $academicManagementId
     * @return bool
     */
    private function existsNameInAcademicManagement(string $name, int $academicManagementId): bool 
    {
        return count(
            $this->academicPeriodService->getAcademicPeriods([
                'name' => $name, 
                'academic_management_id' => $academicManagementId,
            ])
        ) != 0;
    }

    /**
     * Register a new academic period
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request): Response 
    {
        try {
            $validator = $this->validateAcademicPeriodData($request); 
            if ($validator->fails()) {
                return response()->json(
                    ['message' => implode(',',$validator->errors()->all())],
                    400
                );
            }
            $data = $validator->validated();
            if ($this->existsNameInAcademicManagement($data['name'], $data['academic_management_id'])) {
                return response()->json([
                    'message' => 'Ya existe un periodo academico con este nombre en esta gestion academica, por favor introduce otro nombre.',
                ], 400);
            }

            if ($data['date_start'] > $data['initial_date_reservations']) {
                return response()->json(
                    ['message' => 'La fecha seleccionada para inicio de aceptacion de reservas no puede empezar antes que la fecha de inicio del periodo academico.'], 
                    400
                );
            }
            if ($data['date_end'] < $data['initial_date_reservations']) {
                return response()->json(
                    ['message' => 'La fecha seleccionada para inicio de aceptacion de reservas no puede ser despues que la fecha de fin del periodo academico.'],
                    400
                );
            }
            $now = Carbon::now()->setTimeZone('America/New_York')->format('Y-m-d');
            if ($now > $data['date_start']) {
                return response()->json(
                    ['message' => 'Fecha de inicio de semestre no puede ser una fecha pasada a la fecha actual.'],
                    400
                );
            }

            $message = $this->academicPeriodService->store($data);
            
            $pos = strpos($message, 'existe'); 
            if ($pos !== false) {
                return response()->json(['message' => $message], 400);
            }

            return response()->json(['message' => $message], 200); 
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Se ha producido un error en el servidor.', 
                    'error' => $e->getMessage()
                ], 
                500
            );
        }
    }

    /**
     * Validate a academic period data to register
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Validation\Validator
     */
    private function validateAcademicPeriodData(Request $request)
    {
        return Validator::make($request->all(), [
            'date_start' => 'required|date',
            'date_end' => 'required|date',
            'name' => 'required|string',
            'academic_management_id' => 'required|int|exists:academic_managements,id',
            'initial_date_reservations' => 'required|date',
            'faculty_id' => 'required|int|exists:faculties,id',
        ], [
            'date_start.required' => 'La fecha de inicio de periodo academico es obligatoria.',
            'date_start.date' => 'La fecha de inicio de periodo academico debe ser un formato válido.',

            'date_end.required' => 'La fecha fin del periodo academico es obligatoria.',
            'date_end.date' => 'La fecha fin del periodo academico debe ser un formato válido.',

            'name.required' => 'El nombre no puede ser nulo.',
            'name.unique' => 'El nombre no es valido, ya existe un periodo academica con ese nombre, intente con otro nombre.',
            'name.string' => 'El nombre esta vacio, por favor llene correctamente el nombre.',
            
            'academic_management_id.required' => 'La gestion academica debe ser seleccionada.',
            'academic_management_id.int' => 'La gestion academica seleccionada no es valida, intente otra vez.',
            'academic_management_id.exists' => 'La gestion academica seleccionada no existe.',

            'initial_date_reservations.required' => 'La fecha de inicio de pedir reservas es obligatoria.',
            'initial_date_reservations.date' => 'La fecha de inicio de pedir reservas debe ser un formato válido.',

            'faculty_id.required' => 'La facultad debe ser seleccionada.',
            'faculty_id.int' => 'La facultad seleccionada no es valida, intente otra vez.',
            'faculty_id.exists' => 'La facultad seleccionada no existe.',
        ]);
    }

    /**
     * Update an academic period with a new request
     * @param \Illuminate\Http\Request $request
     * @param int $academicPeriodId
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, int $academicPeriodId): Response 
    {
        try {
            $validator = $this->validateAcademicPeriodUpdateData($request); 
            if ($validator->fails()) {
                return response()->json(
                    ['message' => implode(',',$validator->errors()->all())],
                    400
                );
            }
            $data = $validator->validated();
            $academicPeriod = $this->academicPeriodService->getAcademicPeriod($academicPeriodId);
            if (empty($academicPeriod)) {
                return response()->json(
                    ['message' => 'No existe el periodo academico seleccionado, por favor seleccione otro.'], 
                    404
                );
            }

            return response()->json(
                $this->academicPeriodService->update($data, $academicPeriodId), 
                200
            ); 
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Se ha producido un error en el servidor.', 
                    'error' => $e->getMessage()
                ], 
                500
            );
        }
    }

    /**
     * Validate update request
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Validation\Validator
     */
    private function validateAcademicPeriodUpdateData(Request $request)
    {
        return Validator::make($request->all(), [
            'date_start' => 'date',
            'date_end' => 'date',
            'academic_management_id' => 'integer|exists:academic_managements,id',
            'initial_date_reservations' => 'date',
            'faculty_id' => 'integer|exists:faculties,id',
            'activated' => 'integer'
        ], [
            'date_start.date' => 'La fecha de inicio de periodo academico debe ser un formato válido.',

            'date_end.date' => 'La fecha fin del periodo academico debe ser un formato válido.',

            'name.unique' => 'El nombre no es valido, ya existe un periodo academica con ese nombre, intente con otro nombre.',
            'name.string' => 'El nombre esta vacio, por favor llene correctamente el nombre.',
            
            'academic_management_id.integer' => 'La gestion academica seleccionada no es valida, intente otra vez.',
            'academic_management_id.exists' => 'La gestion academica seleccionada no existe.',

            'initial_date_reservations.date' => 'La fecha de inicio de pedir reservas debe ser un formato válido.',

            'faculty_id.integer' => 'La facultad seleccionada no es valida, intente otra vez.',
            'faculty_id.exists' => 'La facultad seleccionada no existe.',
        
            'activated.integer' => 'Debe elegir una seleccion valida para la activacion/desactivado del periodo academico'
        ]);
    }
}