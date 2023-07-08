<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Eleve extends Model
{
    use HasFactory;


    // Database Configuration 
    
    protected $primarykey = 'eleve_id';
    protected $fillable = [
        "user_id",
    ];

    // relationsheep 

    public function user():BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'eleve_id');
    }

    public function abonnements():HasMany
    {
        return $this->hasMany(Abonnement::class, 'abonnement_id', 'eleve_id');
    }
}
