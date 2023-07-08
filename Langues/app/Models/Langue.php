<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Langue extends Model
{
    use HasFactory;

    // Relationsheep


   /**
     * Get all of the modules for the Langue
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function modules(): HasMany
    {
        return $this->hasMany(Module::class, 'module_id', 'langue_id');
    }

    /**
     * The professeurs that belong to the Langue
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function professeurs(): BelongsToMany
    {
        return $this->belongsToMany(Professeur::class, 'enseignements', 'langue_id', 'prof_id');
    }

    /**
     * Get all of the langues for the Langue
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function abonnements(): HasMany
    {
        return $this->hasMany(Abonnement::class, 'abonnement_id', 'langue_id');
    }
    // Database Configurations 

    protected $primaryKey='langue_id' ;
    
    protected $fillable = ['langue_prix','langue_image', 'langue_origine'];
}
