@extends('layouts.app')

@section('content')
<div class="container mx-auto py-8" x-data="{ open: null }">
    <h1 class="text-2xl font-bold mb-6 dark:text-white">Statistiques des cours</h1>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div @click="open = open === 'created' ? null : 'created'" class="cursor-pointer bg-blue-100 dark:bg-blue-900 rounded-lg shadow p-6 text-center hover:bg-blue-200 transition">
            <div class="text-3xl font-bold text-blue-700 dark:text-blue-300">{{ $total }}</div>
            <div class="text-lg text-blue-900 dark:text-blue-100 mt-2">Cours créés</div>
        </div>
        <div @click="open = open === 'draft' ? null : 'draft'" class="cursor-pointer bg-yellow-100 dark:bg-yellow-900 rounded-lg shadow p-6 text-center hover:bg-yellow-200 transition">
            <div class="text-3xl font-bold text-yellow-700 dark:text-yellow-300">{{ $draft }}</div>
            <div class="text-lg text-yellow-900 dark:text-yellow-100 mt-2">Brouillons</div>
        </div>
        <div @click="open = open === 'archived' ? null : 'archived'" class="cursor-pointer bg-gray-100 dark:bg-gray-800 rounded-lg shadow p-6 text-center hover:bg-gray-200 transition">
            <div class="text-3xl font-bold text-gray-700 dark:text-gray-300">{{ $archived }}</div>
            <div class="text-lg text-gray-900 dark:text-gray-100 mt-2">Cours archivés</div>
        </div>
    </div>

    <!-- Liste détaillée par formateur -->
    <div x-show="open === 'created'" class="mb-8" x-transition>
        <h2 class="text-xl font-semibold mb-4 dark:text-white">Cours créés par formateur</h2>
        <x-trainers-table :trainers="$byTrainer['created']" />
    </div>
    <div x-show="open === 'draft'" class="mb-8" x-transition>
        <h2 class="text-xl font-semibold mb-4 dark:text-white">Brouillons par formateur</h2>
        <x-trainers-table :trainers="$byTrainer['draft']" />
    </div>
    <div x-show="open === 'archived'" class="mb-8" x-transition>
        <h2 class="text-xl font-semibold mb-4 dark:text-white">Cours archivés par formateur</h2>
        <x-trainers-table :trainers="$byTrainer['archived']" />
    </div>
</div>
@endsection