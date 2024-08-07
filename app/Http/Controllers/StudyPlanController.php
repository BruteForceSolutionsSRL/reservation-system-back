<?php

namespace App\Http\Controllers;

use App\Service\ServiceImplementation\StudyPlanServiceImpl;

use Illuminate\Http\{
    Request,
    JsonResponse as Response
};

use Illuminate\Support\Facades\Validator;

class StudyPlanController extends Controller
{
    private $studyPlanService; 

    public function __construct() 
    {
        $this->studyPlanService = new StudyPlanServiceImpl();
    }

    /**
     * Retrieve a list of all study plans
     * @return \Illuminate\Http\JsonResponse
     */
    public function list(): Response
    {
        try {
            return response()->json($this->studyPlanService->getAllStudyPlans(), 200);
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

    /**
     * Retrieve a list of study plans by department
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getStudyPlansByDepartments(Request $request): Response 
    {
        try {
            $validator = $this->validateSelectionForDepartments($request); 
            if ($validator->fails()) {
                return response()->json(
                    ['message' => implode(',', $validator->errors()->all())],
                    400
                );
            }
            $data = $validator->validated();
            return response()->json($this->studyPlanService
                ->obtainStudyPlansBySetOfFaculties($data), 200);
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
    /**
     * Validate a selection request for study plans
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Validation\Validator
     */
    private function validateSelectionForDepartments(Request $request)
    {
        return Validator::make($request->all(), 
        [
            'department_ids' => 'required|array', 
            'department_ids.*' => 'integer|exists:departments,id',
        ],
        [
            'department_ids.required' => 'Los departamentos seleccionados no deben ser nulos',
            'department_ids.*.integer' => 'Los departamentos seleccionados deben ser numeros', 
            'department_ids.*.exists' => 'Los departamentos seleccionados no existen.',
        ]
        );
    }
}
