<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Abonnement extends Model
{
    use HasFactory;

    // Database configuration 

    protected $primarykey = 'abonnement_id';

    protected $fillable = ['user_id', 'paiement_id',  'abonnement_date'];


    // relation sheep

    public function paiement():HasOne
    {
       return $this->hasOne(Paiement::class, 'paiement_id','abonnement_id');
    }

    public function eleve(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'abonnement_id');
    }

    // public function langue(): BelongsTo
    // {
    //     return $this->belongsTo(Langue::class, 'langue_id', 'abonnement_id');
    // }
}
