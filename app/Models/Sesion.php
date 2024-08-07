<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sesion extends Model
{
    use HasFactory;
    protected $table = 'sesions';

    public function sessionStatus()
    {
        return $this->belongsTo(SessionStatus::class);
    }

    public function person()
    {
        return $this->belongsTo(Person::class);
    }

    public function actions()
    {
        return $this->belongsToMany(Action::class);
    }
}
