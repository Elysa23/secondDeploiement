<?php

namespace App\Services;

use App\Models\Course;
use Illuminate\Support\Facades\DB;
use App\Models\User;

class CourseDeploymentService
{
    /**
     * Retourne le taux de déploiement des cours publiés.
     * @return float
     */
        public function getDeploymentRate(): float
    {
        // Nombre total de cours publiés
        $totalPublished = Course::where('status', 'published')->count();

        if ($totalPublished === 0) {
            return 0;
        }

        // Nombre de cours publiés qui ont été commencés par au moins un apprenant
        $startedPublished = Course::where('status', 'published')
            ->whereExists(function ($query) {
                $query->select(DB::raw(1))
                    ->from('course_progress')
                    ->whereColumn('course_progress.course_id', 'courses.id')
                    ->whereNotNull('course_progress.started_at');
            })
            ->count();

        // Taux de déploiement (en pourcentage)
        return round(($startedPublished / $totalPublished) * 100, 2);
    }

        
        public function totalPublished(): int
    {
        return Course::where('status', 'published')->count();
    }

    /**
     * Nombre de cours publiés commencés par au moins un apprenant.
     */
        public function startedPublished(): int
    {
        return Course::where('status', 'published')
            ->whereExists(function ($query) {
                $query->select(DB::raw(1))
                    ->from('course_progress')
                    ->whereColumn('course_progress.course_id', 'courses.id')
                    ->whereNotNull('course_progress.started_at');
            })
            ->count();
    }

    /**
     * Taux de déploiement (en %)
     */
        public function deploymentRate(): float
    {
        $total = $this->totalPublished();
        if ($total === 0) return 0;
        return round(($this->startedPublished() / $total) * 100, 2);
    }

    /**
     * Moyenne de progression par formateur/admin (pour les cours publiés et commencés)
     * Retourne un tableau [nom => moyenne]
     */
        public function averageProgressionByTrainer(): array
    {
        // On suppose que la table course_progress a un champ 'progress_percent' (0-100)
        // Sinon, adapte selon ta logique de progression
        $trainers = User::whereIn('role', ['formateur', 'admin'])
            ->whereHas('courses', function($q){
                $q->where('status', 'published');
            })
            ->get();

        $result = [];
        foreach ($trainers as $trainer) {
            // Cours publiés de ce formateur
            $courses = $trainer->courses()->where('status', 'published')->pluck('id');
            if ($courses->isEmpty()) continue;

            // Progressions sur ces cours
            $avg = DB::table('course_progress')
                ->whereIn('course_id', $courses)
                ->whereNotNull('started_at')
                ->avg('progress_percent'); // à adapter si tu utilises un autre champ

            if ($avg !== null) {
                $result[] = [
                    'name' => $trainer->name,
                    'average' => round($avg, 2),
                ];
            }
        }
        return $result;
    }
}

