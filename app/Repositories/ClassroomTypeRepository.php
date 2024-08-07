<?php
namespace App\Repositories;

use App\Models\{
    ClassroomType
}; 

use Illuminate\Database\Eloquent\Model; 

class ClassroomTypeRepository 
{
    protected $model; 
    public function __construct()
    {
        $this->model = ClassroomType::class;
    }

    /**
     * Rertieve a single classroom Type based on its id
     * @param int $id
     * @return array
     */
    public function getClassroomTypeById(int $id) {
        return $this->formatOutput($this->model::find($id)); 
    }
    
    /**
     * Retrieve a list of all classroom types
     * @param none
     * @return array
     */
    public function getAllClassroomTypes(): array
    {
        return $this->model::all()->map(
            function ($classroomType) 
            {
                return $this->formatOutput($classroomType);
            }
        )->toArray();
    }

    /**
     * Format ClassroomType to array
     * @param ClassroomType $classroomType
     * @return array
     */
    private function formatOutput(ClassroomType $classroomType): array
    {
        return [
            'classroom_type_id' => $classroomType->id, 
            'name' => $classroomType->description
        ];
    }
}