<?php
namespace App\Repositories; 

use App\Models\{
    NotificationType
};

use Illuminate\Database\Eloquent\Model;

class NotificationTypeRepository
{
    protected $model;
    
    public function __construct()
    {
        $this->model = NotificationType::class;
    }

    public static function informative(): int
    {
        return NotificationType::where('description', 'INFORMATIVO')
            ->get()->pop()
            ->id; 
    }
    public static function accepted(): int
    {
        return NotificationType::where('description', 'ACEPTADA')
            ->get()->pop()
            ->id; 
    }
    public static function rejected(): int
    {
        return NotificationType::where('description', 'RECHAZADA')
            ->get()->pop()
            ->id; 
    }
    public static function cancelled(): int
    {
        return NotificationType::where('description', 'CANCELADA')
            ->get()->pop()
            ->id; 
    }
    public static function warning(): int
    {
        return NotificationType::where('description', 'ADVERTENCIA')
            ->get()->pop()
            ->id; 
    }

    /**
     * Retrieve a single notification by ID
     * @param int $id
     * @return array
     */
    public function getNotificationType(int $id): array
    {
        return $this->formatOutput($this->model::find($id));
    }
    
    /**
     * Transform Notification Type to array
     * @param NotificationType $notificationType
     * @return array
     */
    private function formatOutput(NotificationType $notificationType): array
    {
        return [
            'notification_type_id' => $notificationType->id, 
            'name' => $notificationType->description 
        ];
    } 
}