@extends('layouts.app')

@section('content')

<div class="container mx-auto py-8" x-data="{ modal: null, selected: null }">
    <h1 class="text-2xl font-bold mb-6 dark:text-white">Mes statistiques de quizz</h1>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        @forelse($benchmarks as $quiz)
            <div @click="modal = true; selected = {{ json_encode($quiz) }}" class="cursor-pointer bg-gradient-to-br from-blue-200 via-blue-100 to-blue-50 dark:from-blue-900 dark:via-blue-800 dark:to-blue-700 rounded-lg shadow-lg p-6 text-center hover:scale-105 transition transform duration-200">
                <div class="text-lg font-semibold text-blue-900 dark:text-blue-100 mb-2">{{ $quiz['quiz_title'] }}</div>
                <div class="text-4xl font-bold text-blue-700 dark:text-blue-300 mb-2">{{ $quiz['score'] }}</div>
                <div class="text-sm text-gray-600 dark:text-gray-300">Votre score</div>
                <div class="mt-2">
                    <span class="inline-block bg-green-100 text-green-800 text-xs px-2 py-1 rounded-full">
                        Moyenne : {{ $quiz['average'] }}
                    </span>
                    <span class="inline-block bg-yellow-100 text-yellow-800 text-xs px-2 py-1 rounded-full ml-2">
                        Top : {{ $quiz['top_score'] }}
                    </span>
                </div>
                <div class="mt-2 text-xs text-gray-500 dark:text-gray-400">
                    Classement : {{ $quiz['rank'] }} / {{ $quiz['total'] }}
                </div>
            </div>
        @empty
            <div class="col-span-3 text-center text-gray-500 dark:text-gray-400">
                Aucun quiz passé pour le moment.
            </div>
        @endforelse
    </div>

    <!-- Modale de détail -->
    <div x-show="modal" class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50" x-cloak>
        <div class="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-8 w-full max-w-lg relative">
            <button @click="modal = false" class="absolute top-2 right-2 text-gray-500 hover:text-red-600 text-2xl">&times;</button>
            <template x-if="selected">
                <div>
                    <h2 class="text-xl font-bold mb-4 dark:text-white" x-text="selected.quiz_title"></h2>
                    <div class="mb-4">
                        <div class="text-2xl font-bold text-blue-700 dark:text-blue-300 mb-2">
                            Votre score : <span x-text="selected.score"></span>
                        </div>
                        <div class="flex flex-wrap gap-2 mb-2">
                            <span class="inline-block bg-green-100 text-green-800 text-xs px-2 py-1 rounded-full">
                                Moyenne : <span x-text="selected.average"></span>
                            </span>
                            <span class="inline-block bg-yellow-100 text-yellow-800 text-xs px-2 py-1 rounded-full">
                                Top : <span x-text="selected.top_score"></span>
                            </span>
                            <span class="inline-block bg-gray-100 text-gray-800 text-xs px-2 py-1 rounded-full">
                                Min : <span x-text="selected.min_score"></span>
                            </span>
                        </div>
                        <div class="text-sm text-gray-600 dark:text-gray-300">
                            Classement : <span x-text="selected.rank"></span> / <span x-text="selected.total"></span>
                        </div>
                        <div class="mt-4">
                            <div class="w-full bg-gray-200 rounded-full h-4 dark:bg-gray-700">
                                <div class="bg-blue-600 h-4 rounded-full transition-all duration-300"
                                     :style="'width: ' + (selected.score / selected.top_score * 100) + '%'"></div>
                            </div>
                            <div class="flex justify-between text-xs mt-1 text-gray-500 dark:text-gray-400">
                                <span>0</span>
                                <span x-text="selected.top_score"></span>
                            </div>
                        </div>
                        <div class="mt-4 text-xs text-gray-500 dark:text-gray-400">
                            <em>Comparaison anonyme : vous êtes {{ $benchmarks[0]['rank'] === 1 ? 'dans le top !' : 'dans la moyenne' }}.</em>
                        </div>
                    </div>
                </div>
            </template>
        </div>
    </div>
</div>
@endsection