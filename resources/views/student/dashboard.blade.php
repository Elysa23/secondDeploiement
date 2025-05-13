@extends('layouts.app')

@section('content')
<div class="container mx-auto py-8">
    <h1 class="text-2xl font-bold mb-6 dark:text-white">Dashboard apprenant</h1>
    <a href="{{ route('student.quiz.stats') }}" class="bg-blue-600 hover:bg-blue-800 text-white px-4 py-2 rounded">
        Voir mes statistiques de quizz
    </a>
</div>
@endsection