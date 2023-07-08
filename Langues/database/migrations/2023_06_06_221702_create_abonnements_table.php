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


            $table->unsignedBigInteger('paiement_id');
            $table->foreign('paiement_id')->references('paiement_id')->on('paiements')->onDelete('cascade');

            //langue foreign key 

            $table->unsignedBigInteger('langue_id');
            $table->foreign('langue_id')->references('langue_id')->on('langues')->onDelete('cascade');

             //eleve foreign key 

             $table->unsignedBigInteger('eleve_id');
             $table->foreign('eleve_id')->references('eleve_id')->on('eleves')->onDelete('cascade');
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
