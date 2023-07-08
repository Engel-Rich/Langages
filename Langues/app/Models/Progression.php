<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Progression extends Model
{
    use HasFactory;

    // Database config 

    protected $primarykey = 'progress_id';

    protected $fillable = [
      'module_id', 'user_id', 'lecon_id','langue_id', 'langue_progress_value'
    ];
}
