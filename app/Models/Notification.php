<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    use HasFactory;
    protected $table = 'notifications';

    public function personTransmitter()
    {
        return $this->belongsTo(Person::class);
    }

    public function notificationType()
    {
        return $this->belongsTo(NotificationType::class);
    }

    public function personNotifications()
    {
        return $this->hasMany(NotificationPerson::class);
    }

    public function receptors() 
    {
        return $this->belongsToMany(Person::class, 'person_notification'); 
    }
}
