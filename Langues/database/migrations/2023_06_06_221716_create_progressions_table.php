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
        Schema::create('progressions', function (Blueprint $table) {
            $table->bigIncrements('progress_id');            
            $table->double('langue_progress_value')->max(100);
            $table->timestamps();

            $table->unsignedBigInteger('langue_id');
            $table->foreign('langue_id')->references('langue_id')->on('langues')->onDelete('cascade');

            $table->unsignedBigInteger('module_id');
            $table->foreign('module_id')->references('module_id')->on('modules')->onDelete('cascade');

            $table->unsignedBigInteger('eleve_id');
            $table->foreign('eleve_id')->references('eleve_id')->on('eleves')->onDelete('cascade');

            $table->unsignedBigInteger('lecon_id');
            $table->foreign('lecon_id')->references('lecon_id')->on('lecons')->onDelete('cascade');

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('progressions');
    }
};
