<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PersonReservation extends Model
{
    use HasFactory;
    protected $table = 'person_reservation';
    
    public function teacherSubjects() 
    {
        return $this->belongsToMany(TeacherSubject::class);
    }

    public function personReservationTeacherSubjects()
    {
        return $this->hasMany(PersonReservationTeacherSubject::class);
    }

    public function person()
    {
        return $this->belongsTo(Person::class);
    }

    public function reservation() 
    {
        return $this->belongsTo(Reservation::class);
    }
}
