<?php

namespace App\Http\Controllers;

use App\Service\ServiceImplementation\UniversitySubjectImpl;
use Exception;
use Illuminate\Http\{
    JsonResponse as Response,
    Request
};

use Illuminate\Support\Facades\Validator;

class UniversitySubjectController extends Controller
{
    private $universitySubjectService;

    public function __construct()
    {
        $this->universitySubjectService = new UniversitySubjectImpl();
    }

    /**
     * get all the subjects registered in the system
     * @param Request $request
     * @return array
     */
    public function list(Request $request): Response
    {
        try {
            return response()->json(
                $this->universitySubjectService->getAllUniversitySubject(),
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

    /**
     * Retrieve a single university subject by its ID
     * @param int $universitySubjectId
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(int $universitySubjectId): Response 
    {
        try {
            return response()->json(
                $this->universitySubjectService->getUniversitySubject($universitySubjectId),
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

    /**
     * Function to register a new university subject
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request): Response 
    {
        try {
            $validator = $this->validateUniversitySubjectData($request); 
            if ($validator->fails()) {
                return response()->json(
                    ['message' => implode(',', $validator->errors()->all())],
                    400
                );
            }

            $data = $validator->validated();

            if (count($data['study_plan_ids']) !== count($data['levels'])) {
                return response()->json(
                    ['message' => 'El numero de carreras a asignar con su correspondiente grado no concuerda, intente nuevamente'], 
                    400
                );
            }

            return response()->json(
                ['message' => $this->universitySubjectService->store($data)],
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
    /**
     * Validate a university subject create request
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Validation\Validator
     */
    private function validateUniversitySubjectData(Request $request) 
    {
        return Validator::make($request->all(), [
            'cod_sis' => 'required|integer|unique:university_subjects,id', 
            'name' => 'required|string|unique:university_subjects,name',
            'department_id' => 'required|integer|exists:departments,id',
            'study_plan_ids' => 'required|array', 
            'study_plan_ids.*' => 'integer|exists:study_plans,id',
            'levels' => 'required|array',
            'levels.*' => 'string',
        ], [
            'cod_sis.required' => 'Debe llenar un codigo sis.',
            'cod_sis.integer' => 'El codigo sis de la materia debe ser un numero.',
            'cod_sis.unique' => 'El codigo sis de la materia ya existe.',

            'name.required' => 'Debe llenar un nombre de materia.',
            'name.string' => 'El nombre de la materia debe ser un texto valido.',
            'name.unique' => 'El nombre de la materia ya existe.',

            'department_id.required' => 'Debe llenar un departamento al que pertenece debe ser seleccionado.',
            'department_id.integer' => 'El departamento al que pertenece la materia debe ser uno valido.',
            'department_id.exists' => 'El departamento al que pertenece la materia debe existir.',

            'study_plans_ids' => 'Las carreras a las que se asigne la materia deben ser opciones validas.',

            'levels' => 'Los niveles de las carreras a las que se asigne la materia deben ser opciones no vacias.',
        ]);
    }

    /**
     * Delete a single university subject
     * @param int $universitySubjectId
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(int $universitySubjectId): Response
    {
        try {
            $universitySubject = $this->universitySubjectService
                ->getUniversitySubject($universitySubjectId); 
            if (empty($universitySubject)) {
                return response()->json(
                    ['message' => 'No existe la materia seleccionada.'], 
                    404
                );
            }
            return response()->json(
                ['message' => $this->universitySubjectService->delete($universitySubjectId)],
                200
            );
    } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Hubo un error en el servidor.',
                    'error' => $e->getMessage()
                ],
                500
            );
        }
    }
}