<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Faculty extends Model
{
    use HasFactory;
    protected $table = 'faculties';

    public function academicPeriods() 
    {
        return $this->hasMany(AcademicPeriod::class);
    }

    public function blocks()
    {
        return $this->hasMany(Block::class);
    }
}
