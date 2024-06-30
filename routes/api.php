<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\{
    TeacherSubjectController,
    TimeSlotController,
    BlockController,
    ClassroomController,
    ClassroomTypeController,
    NotificationController,
    ReservationController,
    ReservationReasonController,
    ClassroomStatusController,
    ReservationStatusController,
    PersonController,
    AuthController,
    UniversitySubjectController
};

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

/**
 * Permisos
 * request_reserve => solicitud de reserva (docente)
 * reservation_handling => atender solicitudes (administrador)
 * availability => ver disponibilidad (all) Mejor lo quitamos no tiene sentido protegerlo
 * classrooms_statistics => ver estadisticas de ambientes (all)
 * notify => notificaciones solo se protege el post del controlador (ENCARGADO) 
 * report => generar reportes de uso de ambiente (Administrador) 
 * environment_register => registrar ambiente (ENCARGADO) 
 * environment_update => editar ambiente (ENCARGADO) 
 * environment_remove => eliminar ambiente (ENCARGADO)
 * reservation_cancel => cancelar solicitues de reserva (DOCENTE)
 * history => Obtener el historia de solicitudes (DOCENTE)
 */

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
 
Route::controller(AuthController::class)->group(function() {
    Route::get('/token/status','tokenStatus');
    Route::get('/token/refresh','tokenRefresh');

    Route::group(['middleware' => ['sanitize:api']], function () {
        Route::post('/login', 'login');
        Route::post('/register', 'register');

        Route::group(['middleware' => ['jwt.verify']], function () {
            Route::post('/logout', 'logout');
            Route::post('/get-user', 'getUser'); 
        });
    });
});

Route::controller(ReservationReasonController::class)->group(function() {
    Route::group(['middleware' => ['jwt.verify','permissions:request_reserve']], function () {
        Route::get('/reservations/reasons', 'list');
    });
});

Route::controller(ReservationStatusController::class)->group(function() {
    Route::group(['middleware' => ['jwt.verify','permissions:report']], function () {
        Route::get('/reservations/statuses', 'list'); 
    });
});

Route::controller(ReservationController::class)->group(function() { 
    Route::group(['middleware' => ['jwt.verify']], function () {
        Route::get('/reservations', 'list');
        Route::get('/reservations/special', 'getActiveSpecialReservations');
        Route::middleware('permissions:reservation_handling')->get('/reservations/pending', 'getPendingRequests');
        Route::get('/reservations/teacher/{teacherId}/open', 'listRequestsByTeacher');
        Route::middleware('permissions:reservation_cancel')->get('/reservations/teacher/{teacherId}', 'listAllRequestsByTeacher');
        Route::middleware('permissions:history')->get('/reservations/history', 'getAllRequestsExceptPending'); // Obsoleto
        Route::middleware('permissions:history')->get('/reservations/history/teacher/{teacherId}', 'getAllRequestsExceptPendingByTeacher');
        Route::middleware('permissions:report')->get('/reservations/reports', 'getReports');
        Route::get('/reservations/{reservationId}', 'show');
        Route::middleware('permissions:reservation_handling')->get('/reservations/{reservationId}/conflicts', 'getConflicts');
        Route::middleware('permissions:environment_remove')->get('/reservations/classroom/{classroomId}','getAllReservationsByClassroom');
    });

    Route::group(['middleware' => ['sanitize:api','jwt.verify']], function () {
        Route::middleware('permissions:reservation_handling')->patch('/reservations/{reservationId}/reject', 'rejectReservation');
        Route::middleware('permissions:reservation_handling')->patch('/reservations/{reservationId}/assign', 'assign');
        Route::middleware('permissions:reservation_cancel')->patch('/reservations/{reservationId}/cancel', 'cancelRequest');
        Route::middleware('permissions:special_reservation')->patch('/reservations/{reservationId}/special/cancel','specialCancel');

        Route::middleware('permissions:request_reserve')->post('/reservations', 'store');
        Route::post('/reservations/special', 'storeSpecialRequest');
    }); 
});

Route::controller(ClassroomStatusController::class)->group(function() {
    Route::group(['middleware' => ['jwt.verify']], function () {
        Route::get('/classrooms/statuses', 'list');
    });
});

Route::controller(ClassroomTypeController::class)->group(function() {
    Route::group(['middleware' => ['jwt.verify','permissions:environment_register,environment_update']], function () {
        Route::get('/classrooms/types', 'list');
    });
});

Route::controller(ClassroomController::class)->group(function() {
    Route::group(['middleware' => ['jwt.verify']], function () {
        Route::get('/classrooms', 'list');
        Route::get('/classrooms/block/{blockId}','classroomsByBlock'); 
        Route::get('/classrooms/block/{blockId}/available', 'availableClassroomsByBlock');
        Route::get('/classrooms/last-validated', 'retriveLastClassroom');
        Route::middleware('permissions:environment_remove')->get('/classrooms/statistics/list','getAllClassroomsWithStatistics');
    
        Route::middleware('permissions:environment_remove')->delete('/classrooms/delete/{classroomId}','destroy');
    });  

    Route::group(['middleware' => ['sanitize:api','jwt.verify']], function () {
        Route::middleware('permissions:request_reserve')->post('/classrooms/reservation/suggest', 'suggestClassrooms');
        Route::post('/classrooms/disponibility', 'getClassroomByDisponibility');
        Route::middleware('permissions:environment_register')->post('/classrooms', 'store');
        Route::post('/classrooms/stats', 'getClassroomStats');
        Route::post('/classrooms/disponible', 'getClassroomsByDisponibility');

        Route::middleware('permissions:environment_update')->put('/classrooms/{classroomId}', 'update');  
    });
});

Route::controller(TeacherSubjectController::class)->group(function() {
    Route::group(['middleware' => ['jwt.verify','permissions:request_reserve,report']], function () {
        Route::get('/teacher-subjects/teacher/{teacherId}', 'subjectsByTeacher');
        Route::get('/teacher-subjects/subject/{universitySubjectID}', 'teachersBySubject');
    });
});

Route::controller(NotificationController::class)->group(function() {
    Route::group(['middleware' => ['jwt.verify']], function () {
        Route::get('/notifications/inbox', 'list');
        Route::get('/notifications/inbox/{notificationId}', 'show');
    });   

    Route::group(['middleware' => ['sanitize:api','jwt.verify']], function () {
        Route::middleware('permissions:notify')->post('/notifications/sendNotification', 'store');
    });
});

Route::controller(BlockController::class)->group(function() {
    Route::group(['middleware' => ['jwt.verify']], function () {
        Route::get('/blocks', 'list');
        Route::get('/blocks/{block_id}', 'show'); 
        Route::middleware('permissions:block_remove')->get('/blocks/{block_id}/statistics', 'getBlockStatistics');
        
        Route::middleware('permissions:block_remove')->delete('/blocks/{block_id}', 'destroy'); 
    });

    Route::group(['middleware' => ['sanitize:api','jwt.verify']], function () {
        Route::middleware('permissions:block_register')->post('/blocks', 'store'); 

        Route::middleware('permissions:block_update')->put('/blocks/{block_id}', 'update');
        Route::post('/blocks/reservation/special', 'listBlocksForSpecial'); 
    });    
});

Route::controller(TimeSlotController::class)->group(function() {
    Route::group(['middleware' => ['jwt.verify']], function () {
        Route::get('/timeslots', 'list');
    });
});

Route::controller(PersonController::class)->group(function() {
    Route::get('/users/teachers', 'listTeachers');
    Route::get('/users', 'list');
    Route::get('/users/{personId}', 'show');
});

Route::controller(UniversitySubjectController::class)->group(function() {
    Route::group(['middleware' => ['jwt.verify']], function () {
        Route::middleware('permissions:report')->get('/university-subjects', 'list');
    });
});
