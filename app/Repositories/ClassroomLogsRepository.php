<?php

namespace App\Repositories;

use App\Models\{
    ClassroomLogs,
};

class ClassroomLogsRepository
{
    protected $model;
    function __construct()
    {
        $this->model = ClassroomLogs::class;
    }
    /**
     * Function to retrieve the last matching classroom
     * @param array $data
     * @return array
     */
    public function retriveLastClassroom(array $data): array
    {
        $classroomLog = $this->model::where('classroom_id', $data['classroom_id'])
            ->where('created_at', '<=', $data['date'])
            ->orderBy('created_at', 'desc')
            ->first();
        
        if(!$classroomLog) {
            return [];
        }

        return $this->formatOutput($classroomLog);
    }

    /**
     * Function to format a classroom into an array
     * @param ClassroomLogs $classroomLogs
     * @return array
     */
    private function formatOutput(ClassroomLogs $classroomLogs): array
    {
        return [
            'classroom_id' => $classroomLogs->classroom_id,
            'name' => $classroomLogs->name,
            'capacity' => $classroomLogs->capacity,
            'floor' => $classroomLogs->floor,
            'block_name' => $classroomLogs->block_name,
            'classroom_type_name' => $classroomLogs->classroom_type_name,
            'classroom_status_name' => $classroomLogs->classroom_status_name,
            'created_at' => $classroomLogs->created_at,
        ];
    }
}
