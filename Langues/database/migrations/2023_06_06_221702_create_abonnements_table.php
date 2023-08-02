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
        Schema::create('abonnements', function (Blueprint $table) {
            $table->bigIncrements('abonnement_id');
           
            $table->date('abonnement_date')->default(now());
            $table->timestamps();


            $table->unsignedBigInteger('paiement_id')->require();
            $table->foreign('paiement_id')->references('paiement_id')->on('paiements')->onDelete('cascade');



            $table->unsignedBigInteger('module_id')->require();
            $table->foreign('module_id')->references('module_id')->on('modules')->onDelete('cascade');
            
             //eleve foreign key 

             $table->unsignedBigInteger('user_id');
             $table->foreign('user_id')->references('user_id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('abonnements');
    }
};
