<?php
namespace App\Repositories;

use App\Models\ClassroomStatus; 

use Illuminate\Cache\Repository;

use Illuminate\Database\Eloquent\Model; 

class ClassroomStatusRepository extends Repository
{
     
    protected $model; 
    function __construct() 
    {
        $this->model = ClassroomStatus::class;
    }

    public static function available() 
    {   
        return ClassroomStatus::where('name', 'HABILITADO')
            ->orWhere('name', 'ENABLED')
            ->first()->id; 
    }
    public static function disabled() 
    {
        return ClassroomStatus::where('name', 'DESHABILITADO')
            ->orWhere('name', 'DISABLED')
            ->first()->id; 
    } 
    public static function deleted() 
    {
        return ClassroomStatus::where('name', 'ELIMINADO')
            ->orWhere('name', 'DELETED')
            ->first()->id; 
    }

    /**
     * Retrieve a single classroom status based on its ID
     * @param int $id
     * @return array
     */
    public function getClassroomStatusById(int $id) 
    {
        return $this->formatOutput($this->model::find($id));
    }

    /**
     * Retrieve a list of all statuses for classroom except delete 
     * @param none
     * @return array
     */
    public function getStatuses(): array
    {
        return $this->model::where('id', '!=', $this->deleted())
            ->get()
            ->map(
                function ($classroomStatus) 
                {
                    return $this->formatOutput($classroomStatus); 
                }
            )->toArray();
    }

    
    /**
     * Transform 'ClassroomStatus' name into an array of IDs
     * @param string $status
     * @return array
     */
    public function getStatusesIdByName(string $status): array
    {
        if($status === 'ENABLED') {
            return [
                $this->available() 
            ];
        } else if ($status === 'DISABLED') {
            return [
                $this->disabled() 
            ];
        } else if ($status === 'ALL'){
            return [
                $this->available(),
                $this->disabled() 
            ];
        } else return [$this->available()];
    }
    
    /**
     * Transform ClassroomStatus to array
     * @param ClassroomStatus $classroomStatus
     * @return array
     */
    private function formatOutput(ClassroomStatus $classroomStatus): array
    {
        if ($classroomStatus == null) return [];
        return [
            'classroom_status_id' => $classroomStatus->id,
            'name' => $classroomStatus->name, 
        ];
    }
}