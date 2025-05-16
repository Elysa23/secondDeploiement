<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Course;
use App\Services\CourseDeploymentService;
use App\Services\QuizStatsService;


class AdminDashboardController extends Controller
{
    public function coursesStats()
{
    // Statistiques globales
    $total = \App\Models\Course::count();
    $draft = \App\Models\Course::where('status', 'draft')->count();
    $archived = \App\Models\Course::where('status', 'archived')->count();

    // Statistiques par formateur et par statut
    $byTrainer = [
        'created' => \App\Models\User::whereHas('courses', function($q){ $q->where('status', 'created'); })
            ->withCount(['courses as courses_count' => function($q){ $q->where('status', 'created'); }])->get(),
        'draft' => \App\Models\User::whereHas('courses', function($q){ $q->where('status', 'draft'); })
            ->withCount(['courses as courses_count' => function($q){ $q->where('status', 'draft'); }])->get(),
        'archived' => \App\Models\User::whereHas('courses', function($q){ $q->where('status', 'archived'); })
            ->withCount(['courses as courses_count' => function($q){ $q->where('status', 'archived'); }])->get(),
    ];

    return view('admin.courses-stats', compact('total', 'draft', 'archived', 'byTrainer'));
}


        public function dashboard(CourseDeploymentService $deploymentService, QuizStatsService $quizStatsService)
{
    $total = $deploymentService->totalPublished();
    $started = $deploymentService->startedPublished();
    $deploymentRate = $deploymentService->deploymentRate();
    $progressByTrainer = $deploymentService->averageProgressionByTrainer();
    $globalAvg = $quizStatsService->globalAverage();
    $globalSuccess = $quizStatsService->globalSuccessRate();
    $avgByTrainer = $quizStatsService->averageByTrainer();
    $successByQuiz = $quizStatsService->successRateByQuiz();
    $avgByQuiz = $quizStatsService->averageByQuiz();


    $draft = \App\Models\Course::where('status', 'draft')->count();
    $archived = \App\Models\Course::where('status', 'archived')->count();

    $byTrainer = [
        'created' => \App\Models\User::whereHas('courses', function($q){ $q->where('status', 'created'); })
            ->withCount(['courses as courses_count' => function($q){ $q->where('status', 'created'); }])->get(),
        'draft' => \App\Models\User::whereHas('courses', function($q){ $q->where('status', 'draft'); })
            ->withCount(['courses as courses_count' => function($q){ $q->where('status', 'draft'); }])->get(),
        'archived' => \App\Models\User::whereHas('courses', function($q){ $q->where('status', 'archived'); })
            ->withCount(['courses as courses_count' => function($q){ $q->where('status', 'archived'); }])->get(),
    ];

    return view('admin.dashboard', [
        'total' => $total,
        'started' => $started,
        'deploymentRate' => $deploymentRate,
        'progressByTrainer' => $progressByTrainer,
        'draft' => $draft,
        'archived'=>$archived,
        'byTrainer'=>$byTrainer,
        'globalAvg' => $globalAvg,
        'globalSuccess' => $globalSuccess,
        'avgByTrainer' => $avgByTrainer,
        'successByQuiz' => $successByQuiz,
        'avgByQuiz' => $avgByQuiz,
    ]);
}

            public function quizStats(QuizStatsService $statsService)
{
    
    $globalAvg = $statsService->globalAverage();
    $avgByTrainer = $statsService->averageByTrainer();
    $avgByQuiz = $statsService->averageByQuiz();
    $avgByStudent = $statsService->averageByStudent();
    $globalSuccess = $statsService->globalSuccessRate();
    $successByQuiz = $statsService->successRateByQuiz();

    
    return view('admin.quiz-stats', compact(
        'globalAvg', 'avgByTrainer', 'avgByQuiz', 'avgByStudent', 'globalSuccess', 'successByQuiz'
    ));
    
}
}
