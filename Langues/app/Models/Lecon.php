<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Lecon extends Model
{
    use HasFactory;

    // relations Sheep

    /**
     * Get the module that owns the Lecon
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function module(): BelongsTo
    {
        return $this->belongsTo(Module::class,'module_id','lecon_id');
    }

    // Database configuration 

    protected $primarykey = 'lecon_id';

    protected $fillable = ['lecon_title', 'lecon_text', 'lecon_voice', 'lecon_image', 'lecon_quiz', 'module_id'];

}
