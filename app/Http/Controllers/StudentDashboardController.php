<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\QuizStatsService;


class StudentDashboardController extends Controller
{

    public function dashboard()
    {
        return view('student.dashboard');
    }

    
    public function quizStats(QuizStatsService $statsService)
{
    $benchmarks = $statsService->statsForStudent(auth()->id());
    return view('student.quiz-stats', compact('benchmarks'));
}
}
