<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    use HasFactory;
    protected $table = 'roles';

    public function permissions()
    {
        $this->belongsToMany(Permission::class);
    }

    public function people()
    {
        $this->belongsToMany(Person::class);
    }
}
