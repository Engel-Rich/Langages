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
        Schema::create('lecons', function (Blueprint $table) {
            $table->bigIncrements('lecon_id');            
            // $table->bigInteger('module_id');            
            $table->string('lecon_title');            
            $table->string('lecon_voice');            
            $table->string('lecon_image')->nullable();            
            $table->mediumText('lecon_description')->nullable();            
            // $table->mediumText('lecon_quiz')->nullable();            
            $table->timestamps();

            $table->unsignedBigInteger('module_id');
            $table->foreign('module_id')->references('module_id')->on('modules')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lecons');
    }
};
