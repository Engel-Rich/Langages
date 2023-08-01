<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Paiement extends Model
{
    use HasFactory;

    // Relationsheep 

    /**
     * Get the user that owns the Paiement
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'paiement_id');
    }


    public function abaonnement():BelongsTo
    {
       return $this->belongsTo(Abonnement::class, 'abonnement_id', 'paiement_id');
    }

    
    // Database Configuration 

    protected $primarykey = 'paiement_id';

    protected $fillable = ['paiement_amount', 'paiement_ref', 'paiement_status','paiement_motif','module_id', 'user_id'];
}
