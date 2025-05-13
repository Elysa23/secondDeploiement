<div class="overflow-x-auto">
    <table class="min-w-full bg-white dark:bg-gray-900 rounded-lg shadow">
        <thead>
            <tr>
                <th class="px-4 py-2 text-left dark:text-white">Formateur</th>
                <th class="px-4 py-2 text-left dark:text-white">Nombre de cours</th>
            </tr>
        </thead>
        <tbody>
            @forelse($trainers as $trainer)
                <tr>
                    <td class="border-t px-4 py-2 dark:text-gray-200">{{ $trainer->name }}</td>
                    <td class="border-t px-4 py-2 dark:text-gray-200">{{ $trainer->courses_count }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="2" class="border-t px-4 py-2 text-center text-gray-500 dark:text-gray-400">Aucun formateur</td>
                </tr>
            @endforelse
        </tbody>
    </table>
</div>