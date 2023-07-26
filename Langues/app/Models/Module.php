<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Module extends Model
{
    use HasFactory;

    // relationsheep 

    public function langue():BelongsTo
    {
        return $this->belongsTo(Langue::class,'langue_id','module_id');
    }


    public function lecons():HasMany
    {
        return $this->hasMany(Lecon::class, 'lecon_id', 'module_id');
    }


    // Database Configuration 

    protected $primarykey = 'module_id';
    

    protected $fillable = ['langue_id','module_title','module_image','module_prix'];

}
