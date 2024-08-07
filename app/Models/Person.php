<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Tymon\JWTAuth\Contracts\JWTSubject;

class Person extends Authenticatable implements JWTSubject
{
    use HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 
        'last_name',
        'user_name',
        'email', 
        'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 
        'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }

    public function personNotifications()
    {
        return $this->hasMany(NotificationPerson::class);
    }

    public function notifications()
    {
        return $this->belongsToMany(Notification::class, 'person_notification');
    }

    public function roles()
    {
        return $this->belongsToMany(Role::class);
    }

    public function reservations()
    {
        return $this->belongsToMany(Reservation::class);
    }

    public function personReservations()
    {
        return $this->hasMany(PersonReservation::class);
    }

    public function teacherSubjects()
    {
        return $this->hasMany(TeacherSubject::class);
    }
}
