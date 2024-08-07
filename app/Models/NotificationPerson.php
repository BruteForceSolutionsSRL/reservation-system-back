<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NotificationPerson extends Model
{
    use HasFactory;
    protected $table = 'person_notification';
    
    public function receptor()
    {
        return $this->belongsTo(Person::class); 
    }

    public function notification()
    {
        return $this->belongsTo(Notification::class);
    }
}
