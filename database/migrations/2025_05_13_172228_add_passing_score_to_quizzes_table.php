<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
{
    Schema::table('quizzes', function (Blueprint $table) {
        $table->float('passing_score')->default(50)->after('course_id'); 

    });
    \App\Models\Quiz::whereNull('passing_score')->update(['passing_score' => 50]);
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('quizzes', function (Blueprint $table) {
            //
        });
    }
};
