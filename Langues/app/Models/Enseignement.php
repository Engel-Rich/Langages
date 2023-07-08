<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Enseignement extends Model
{
    use HasFactory;

    // Database configuration 

    protected $primarykey ='enseignement_id';

    protected $fillable=['prof_id','langue_id'];

    // Relationsheep
    
}
