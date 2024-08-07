<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClassroomType extends Model
{
    use HasFactory;
    protected $table = 'classroom_types';

    public function classrooms()
    {
        return $this->hasMany(Classroom::class);
    }
}
