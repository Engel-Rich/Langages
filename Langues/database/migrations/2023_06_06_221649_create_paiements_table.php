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
        Schema::create('paiements', function (Blueprint $table) {
            $table->bigIncrements('paiement_id');
            $table->integer('paiement_amount');
            $table->string('paiement_ref')->unique();
            $table->boolean('paiement_status')->default(false);
            $table->boolean('has_code_send')->default(false);
            $table->string('paiement_motif')->default('paiement pour une langue');            
            $table->timestamps();

            // cle etrangere pour le modue 

            $table->unsignedBigInteger('module_id');
            $table->foreign('module_id')->references('module_id')->on('modules')->onDelete('cascade');

            // cle etrangere pour le user
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('user_id')->on('users')->onDelete('cascade');

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('paiements');
    }
};
