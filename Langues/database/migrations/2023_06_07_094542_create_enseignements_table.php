<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('enseignements', function (Blueprint $table) {
            $table->bigIncrements('enseignement_id');           
            $table->timestamps();


            
            $table->unsignedBigInteger('langue_id');
            
            $table->foreign('langue_id')->references('langue_id')->on('langues')->onDelete('cascade');

            
            $table->unsignedBigInteger('prof_id');
            $table->foreign('prof_id')->references('prof_id')->on('professeurs')->onDelete('cascade');

            
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('enseignements');
    }
};
