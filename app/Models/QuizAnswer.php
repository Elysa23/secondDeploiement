<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class QuizAnswer extends Model
{
    // Champs autorisés à l'écriture en masse
    protected $fillable = [
        'quiz_id',
        'user_id',
        'answers',
        'time_spent',
        'score',
    ];

    // Casts automatiques pour les attributs
    protected $casts = [
        'answers' => 'array',
        'score' => 'float',
        'time_spent' => 'integer',
    ];

    /**
     * Relation : cette réponse appartient à un quiz
     */
    public function quiz()
    {
        return $this->belongsTo(Quiz::class);
    }

    /**
     * Relation : cette réponse appartient à un utilisateur (apprenant)
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}