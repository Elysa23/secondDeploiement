<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Middleware\IsAdmin;
use App\Http\Controllers\CourseController;
use App\Http\Controllers\CoursePageController;
use App\Http\Controllers\AdminDashboardController;
use App\Http\Controllers\StudentDashboardController;



Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::put('/profile/password', [ProfileController::class, 'updatePassword'])->name('profile.updatePassword');
    Route::post('/profile/photo', [ProfileController::class, 'updatePhoto'])->name('profile.updatePhoto'); // POST pour l'upload de fichier
});

require __DIR__.'/auth.php';


use App\Models\User;
use Illuminate\Http\Request;



// Création de la route POST pour enregistrer l'utilisateur 28/04

use Illuminate\Support\Facades\Hash;

Route::post('/utilisateurs', function (Request $request) {
    // Valider les données
    $request->validate([
        'name' => 'required',
        'email' => 'required|email|unique:users,email',
        'password' => 'required|min:8',
        'role' => 'required|in:apprenant,formateur,admin',
    ]);

    // Créer l'utilisateur
    User::create([
        'name' => $request->name,
        'email' => $request->email,
        'password' => Hash::make($request->password),
        'role' => $request->role,
    ]);

    return redirect('/utilisateurs')->with('success', 'Utilisateur ajouté avec succès.');
})->middleware(['auth', IsAdmin::class]);


// 29/04 : Route pour l'accès refusé de la page ajouter-utilisateur 

Route::get('/access-denied', function () {
    return view('access-denied');
})->name('access.denied');

// 29/04 : Route pour la liste des utilisateurs

Route::get('/utilisateurs', [App\Http\Controllers\UserController::class, 'index'])
    ->middleware('is_admin');


// 29/04 : Route pour formulaire d'édition de la liste des utilisateurs

// Afficher le formulaire d’édition
Route::get('/utilisateurs/{user}/edit', [App\Http\Controllers\UserController::class, 'edit'])
    ->middleware('is_admin')
    ->name('users.edit');

// Enregistrer la modification
Route::put('/utilisateurs/{user}', [App\Http\Controllers\UserController::class, 'update'])
    ->middleware('is_admin')
    ->name('users.update');

// 30/04 : Suppression d'un utilisateur
Route::delete('/utilisateurs/{user}', [App\Http\Controllers\UserController::class, 'destroy'])
    ->middleware('is_admin')
    ->name('users.destroy');

// Route pour supprimer la miniature d'un cours
Route::delete('courses/{course}/remove-thumbnail', [App\Http\Controllers\CourseController::class, 'removeThumbnail'])->name('courses.remove-thumbnail');

// 01/05 : Routes pour les cours

Route::resource('courses', App\Http\Controllers\CourseController::class)->middleware('auth');

// 02/05 : Suppression image dans thumbnail

Route::delete('courses/{course}/remove-thumbnail', [CourseController::class, 'removeThumbnail'])->name('courses.remove-thumbnail');

// Affichage cours côté apprenant

Route::get('apprenant/cours', [App\Http\Controllers\CourseController::class, 'publishedForStudents'])
    ->name('courses.published');

// 05/05 Affichage pages des cours 
Route::get('apprenant/cours/{course}/{page?}', [App\Http\Controllers\CourseController::class, 'showPage'])
    ->name('courses.page');


// 05/05 Gestion des pages des cours

Route::get('courses/{course}/pages', [App\Http\Controllers\CoursePageController::class, 'manage'])->name('courses.pages.manage');
Route::get('courses/{course}/pages/create', [App\Http\Controllers\CoursePageController::class, 'create'])->name('courses.pages.create');
Route::post('courses/{course}/pages', [App\Http\Controllers\CoursePageController::class, 'store'])->name('courses.pages.store');
Route::get('courses/{course}/pages/{page}/edit', [App\Http\Controllers\CoursePageController::class, 'edit'])->name('courses.pages.edit');
Route::put('courses/{course}/pages/{page}', [App\Http\Controllers\CoursePageController::class, 'update'])->name('courses.pages.update');
Route::delete('courses/{course}/pages/{page}', [App\Http\Controllers\CoursePageController::class, 'destroy'])->name('courses.pages.destroy');
Route::get('apprenant/cours/{course}/{page?}', [App\Http\Controllers\CoursePageController::class, 'showPage'])
    ->name('courses.page');

// 05/05 Cours publiés
Route::get('apprenant/cours', [App\Http\Controllers\CourseController::class, 'published'])->name('courses.published');

use App\Http\Controllers\QuizController;

// 06/05 Liste des quiz, création, affichage, édition, suppression
Route::resource('quizzes', App\Http\Controllers\QuizController::class);

// Route spécifique pour la génération via IA (AJAX ou POST)
Route::post('quizzes/generate', [App\Http\Controllers\QuizController::class, 'generate'])->name('quizzes.generate');

// Route API quizz

Route::post('/quiz/generate', [QuizController::class, 'generate'])->name('quiz.generate');

// 08/05 : Affichage du quiz à l’apprenant
Route::get('quizzes/{quiz}/answer', [QuizController::class, 'answer'])->name('quizzes.answer');

// Soumission des réponses
Route::post('quizzes/{quiz}/submit', [QuizController::class, 'submitAnswers'])->name('quizzes.submit');

// 09/05 Affichage quizz côté admin et formateur
Route::get('quizzes/{quiz}', [QuizController::class, 'show'])->name('quizzes.show');

// 12/05 Affichage dashboard admin


Route::get('/admin/courses-stats', [AdminDashboardController::class, 'coursesStats'])->name('admin.courses.stats');
Route::get('/admin/dashboard', [AdminDashboardController::class, 'dashboard'])->name('dashboard');

// 13/05 dashboard quizz

Route::get('/admin/quiz-stats', [AdminDashboardController::class, 'quizStats'])->name('admin.quiz.stats');
Route::get('/student/quiz-stats', [StudentDashboardController::class, 'quizStats'])
    ->middleware(['auth', 'role:apprenant']) // si tu as un middleware de rôle
    ->name('student.quiz.stats');

// 13/05 dashboard apprenant

Route::get('/student/dashboard', [StudentDashboardController::class, 'dashboard'])
    ->middleware(['auth', 'role:apprenant'])
    ->name('student.dashboard');