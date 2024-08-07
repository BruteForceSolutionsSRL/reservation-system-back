<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Block extends Model
{
    use HasFactory;
    protected $table = 'blocks';

    public function classrooms()
    {
        return $this->hasMany(Classroom::class);
    }
    public function blockStatus()
    {
        return $this->belongsTo(BlockStatus::class);
    }

    public function faculty()
    {
        return $this->belongsTo(Faculty::class);
    }
}
