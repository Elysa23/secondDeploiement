<?php

namespace App\Services;

use App\Models\Quiz;
use App\Models\QuizAnswer;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class QuizStatsService
{
    // Note moyenne globale sur tous les quizz
    public function globalAverage(): float
    {
        return round(QuizAnswer::avg('score'), 2);
    }

    // Note moyenne par formateur (sur ses quizz)
    public function averageByTrainer(): array
    {
        $trainers = User::where('role', 'formateur')->get();
        $result = [];
        foreach ($trainers as $trainer) {
            $quizIds = Quiz::whereHas('course', function($q) use ($trainer) {
                $q->where('user_id', $trainer->id);
            })->pluck('id');
            if ($quizIds->isEmpty()) continue;
            $avg = QuizAnswer::whereIn('quiz_id', $quizIds)->avg('score');
            $result[] = [
                'name' => $trainer->name,
                'average' => $avg ? round($avg, 2) : null,
            ];
        }
        return $result;
    }

    // Note moyenne par quizz
    public function averageByQuiz(): array
    {
        return Quiz::with('results')
            ->get()
            ->map(function($quiz) {
                return [
                    'quiz_id' => $quiz->id,
                    'quiz_title' => $quiz->title,
                    'average' => $quiz->results->avg('score') ? round($quiz->results->avg('score'), 2) : null,
                ];
            })->toArray();
    }

    // Note moyenne par apprenant
    public function averageByStudent(): array
    {
        $students = User::where('role', 'apprenant')->get();
        $result = [];
        foreach ($students as $student) {
            $avg = QuizAnswer::where('user_id', $student->id)->avg('score');
            $result[] = [
                'name' => $student->name,
                'average' => $avg ? round($avg, 2) : null,
            ];
        }
        return $result;
    }

    // Taux de réussite global
    public function globalSuccessRate(): float
    {
        $total = QuizAnswer::count();
        if ($total === 0) return 0;

        $success = QuizAnswer::whereHas('quiz', function($q) {
            $q->whereColumn('quiz_results.score', '>=', 'quizzes.passing_score');
        })->count();

        return round(($success / $total) * 100, 2);
    }

    // Taux de réussite par quizz
    public function successRateByQuiz(): array
    {
        return Quiz::with('results')->get()->map(function($quiz) {
            $total = $quiz->results->count();
            if ($total === 0) return [
                'quiz_id' => $quiz->id,
                'quiz_title' => $quiz->title,
                'success_rate' => null,
            ];
            $success = $quiz->results->where('score', '>=', $quiz->passing_score)->count();
            return [
                'quiz_id' => $quiz->id,
                'quiz_title' => $quiz->title,
                'success_rate' => round(($success / $total) * 100, 2),
            ];
        })->toArray();
    }

    // Statistiques pour un apprenant (score par quizz + benchmark)
    public function statsForStudent($userId): array
    {
        $results = QuizAnswer::where('user_id', $userId)->with('quiz')->get();
        $benchmarks = [];
        foreach ($results as $result) {
            $quiz = $result->quiz;
            $allScores = QuizAnswer::where('quiz_id', $quiz->id)->pluck('score');
            $rank = $allScores->filter(fn($s) => $s > $result->score)->count() + 1;
            $benchmarks[] = [
                'quiz_title' => $quiz->title,
                'score' => $result->score,
                'rank' => $rank,
                'total' => $allScores->count(),
                'top_score' => $allScores->max(),
                'min_score' => $allScores->min(),
                'average' => round($allScores->avg(), 2),
            ];
        }
        return $benchmarks;
    }
}