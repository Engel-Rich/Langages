<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Professeur extends Model
{
    use HasFactory;

    // Databases Configurations 

    protected $primarykey= 'prof_id';

    protected $fillable = [
     'user_id'
    ];

    // relation sheep 

    public function user():BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function langues():BelongsToMany{
        return $this->belongsToMany(Langue::class,'enseignements', 'prof_id', 'langue_id');
    }
}
