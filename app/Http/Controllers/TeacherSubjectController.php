<?php

namespace App\Http\Controllers;

use App\Service\ServiceImplementation\{
    TeacherSubjectServiceImpl,
    AcademicPeriodServiceImpl
};

use Illuminate\Http\{
    JsonResponse as Response,
    Request
};

use Illuminate\Support\Facades\{
    Validator,
    DB
};
use Exception;

class TeacherSubjectController extends Controller
{
    private $teacherSubjectService; 
    private $academicPeriodService; 
    public function __construct()
    {
        $this->teacherSubjectService = new TeacherSubjectServiceImpl();
        $this->academicPeriodService = new AcademicPeriodServiceImpl(); 
    }

    public function list() 
    {
        return response()->json($this->teacherSubjectService->getAllTeacherSubjects(), 200);
    }

    /**
     * Obtaining subjects through a teacher id.
     * @param int $personId
     * @param Request $request
     * @return Response
     */
    public function subjectsByTeacher(int $personId, Request $request): Response
    {
        try {
            return response()->json(
                $this->teacherSubjectService->getSubjectsByTeacherId(
                    $personId
                ), 
                200
            );
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Hubo un error en el servidor',
                    'error' => $e -> getMessage()
                ],
                500
            );
        }
    }

    /**
     * Obtaining teacher-groups through a university subject id.
     * @param int $universitySubjectId
     * @param Request $request
     * @return Response
     */
    public function teachersBySubject(int $universitySubjectId, Request $request): Response
    {
        try {
            return response()->json(
                $this->teacherSubjectService->getTeachersBySubjectId(
                    $universitySubjectId
                ), 
                200
            );
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Hubo un error en el servidor',
                    'error' => $e -> getMessage()
                ],
                500
            );
        }
    }

    /**
     * Retrieve all teacher subjects by academic period 
     * @param int $academicPeriodId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getAllTeacherSubjectsByAcademicPeriod(int $academicPeriodId): Response 
    {
        try {
            return response()->json(
                $this->teacherSubjectService->formatByAcademicPeriod(
                    $this->teacherSubjectService->getTeacherSubjectByParams(
                        [
                            'academic_period_id' => $academicPeriodId,
                        ]
                        ),
                        $academicPeriodId                    
                ), 
                200
            );
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Hubo un error en el servidor',
                    'error' => $e -> getMessage()
                ],
                500
            );
        }
    }    

    /**
     * Retrieve a list of all teacher subject by person and faculty, for a simple user its necesary only a token and for a admin its necesary specify which user and which faculty.
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getAllTeacherSubjectsByPersonAndFaculty(Request $request): Response 
    {
        try {
            $personId = $request['session_id'];
            $facultyId = \JWTAuth::parseToken($request->bearerToken())->getClaim('faculty_id'); 
            if ($request->has('person_id')) {
                $personId = $request->input('person_id');
            }
            if ($request->has('faculty_id')) {
                $facultyId = $request['faculty_id'];
            }
            if ($facultyId == -1) {
                return response()->json([
                    'message' => 'No existe una facultad seleccionada, por favor intente iniciar sesion nuevamente',
                ], 400);
            }
            return response()->json(
                $this->teacherSubjectService->formatByAcademicPeriod(
                    $this->teacherSubjectService->getTeacherSubjectByParams(
                        [
                            'person_id' => $personId,
                            'faculty_id' => $facultyId,
                        ]
                    ),
                    $this->academicPeriodService->getActualAcademicPeriodByFaculty($facultyId)['academic_period_id']
                ), 
                200
            );
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Hubo un error en el servidor',
                    'error' => $e -> getMessage()
                ],
                500
            );
        }
    }

    /**
     * Create a request data to a new group.
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function saveGroup(Request $request): Response
    {
        try {
            $validator = $this->validateSaveGroupData($request);

            if ($validator->fails()) {
                return response()->json(
                    ['message' => (implode(',', $validator->errors()->all()))],
                    400
                );
            }
        
            $data = $validator->validated();

            $teacherSubjects = $this->teacherSubjectService->getTeacherSubjectByParams([
                'university_subject_id' => $data['university_subject_id'], 
                'group_number' => $data['group_number'],
            ]);
            if (!empty($teacherSubjects)) {
                return response()->json([
                    'message' => 'El grupo ya existe, por favor intente con otro no existente',
                ], 400);
            }

            return response()->json([
                $this->teacherSubjectService->saveGroup($data),
                200
            ]);
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Hubo un error en el servidor',
                    'error' => $e -> getMessage()
                ],
                500
            );
        } 
    }

    /**
     * Validate save group requests
     * @param \Illuminate\Http\Request $request
     * @return mixed
     */
    private function validateSaveGroupData(Request $request): mixed
    {
        return Validator::make($request->all(), [
            'university_subject_id' => 'required|exists:university_subjects,id',
            'person_id' => 'required|exists:people,id',
            'group_number' => 'required|integer',
            'academic_period_id' => 'required|exists:academic_periods,id',
            'study_plan_ids' => 'array',
            'study_plan_ids.*' => 'required|exists:study_plans,id',
            'class_schedules' => ['required','array'],
            'class_schedules.*.day' => 'required|integer|min:0|max:6', 
            'class_schedules.*.time_slot_ids' => 'required|array',
            'class_schedules.*.time_slot_ids.*' => 'required|integer|exists:time_slots,id',
            'class_schedules.*.classroom_id' => 'required|integer|exists:classrooms,id',
        ], [
            'university_subject_id.required' => 'El campo materia es obligatorio',
            'university_subject_id.exists' => 'El campo materia debe existir en la base de datos',

            'person_id.required' => 'El campo de docente es obligatorio',
            'person_id.exists' => 'El campo de docente debe existir en la base de datos',

            'group_number.required' => 'El campo de numero de grupo es obligatorio',
            'group_number.integer' => 'El campo de nuemro de grupo debe ser un número entero',

            'academic_period_id.required' => 'El periodo academico es obligatorio',
            'academic_period_id.exists' => 'El periodo academico debe existir en la base de datos',

            'study_plan_ids.array' => 'Las carreras designadas deben estar en un arreglo',
            'study_plan_ids.*.required' => 'Debe seleccionar almenos una carrera designada',
            'study_plan_ids.*.exists' => 'Cada carrera designada debe existir en la base de datos.',

            'class_schedules.required' => 'El campo de horario de clases es obligatorio.',
            'class_schedules.array' => 'El campo de horario de clases debe ser un arreglo.',
        ]);
    }
}