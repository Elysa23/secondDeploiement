<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class QuizController@submitAnswers extends Controller
{
    public function submitAnswers(Request $request, Quiz $quiz)
{
    $request->validate([
        'answers' => 'required|array',
    ]);

    // Récupère les bonnes réponses (selon la logique de parsing)
    $questions = parseQuizMarkdown($quiz->content); // ou autre méthode
    $userAnswers = $request->input('answers');
    $score = 0;
    $total = 0;

    foreach ($questions as $index => $q) {
        if (isset($q['correct']) && isset($userAnswers[$index])) {
            $total++;
            if ($userAnswers[$index] == $q['correct']) {
                $score++;
            }
        }
    }

    $finalScore = $total > 0 ? round(($score / $total) * 100, 2) : 0;

    // Enregistre la réponse et la note
    \App\Models\QuizAnswer::updateOrCreate(
        [
            'user_id' => auth()->id(),
            'quiz_id' => $quiz->id,
        ],
        [
            'answers' => json_encode($userAnswers),
            'score' => $finalScore,
        ]
    );

    // Redirection ou affichage du résultat
    return redirect()->route('student.quiz.stats')->with('success', 'Quiz soumis !');

}
}
