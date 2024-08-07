<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClassroomStatus extends Model
{
    use HasFactory;
    protected $table = 'classroom_statuses';
    public function classrooms() 
    {
        return $this->hasMany(Classroom::class);
    }
}
