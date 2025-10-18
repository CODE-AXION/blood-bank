<x-filament-panels::page>
    <x-filament::card>
        {{-- <h2 class="text-2xl font-bold tracking-tight text-gray-950 dark:text-white sm:text-3xl">
            {{ $this->getHeading() }}
        </h2> --}}

        <div class="mt-6 grid grid-cols-1 gap-y-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            <div class="flex flex-col items-center justify-center p-6 bg-gray-100 rounded-lg dark:bg-gray-800">
                <p class="text-lg font-semibold text-gray-700 dark:text-gray-300">Last Donation Date</p>
                <p class="text-xl font-bold text-primary-600 dark:text-primary-400 mt-2">{{ $this->getLastDonationDate() ?? 'N/A' }}</p>
            </div>

            <div class="flex flex-col items-center justify-center p-6 bg-gray-100 rounded-lg dark:bg-gray-800">
                <p class="text-lg font-semibold text-gray-700 dark:text-gray-300">Next Eligible Donation Date</p>
                <p class="text-xl font-bold text-primary-600 dark:text-primary-400 mt-2">{{ $this->getNextEligibleDonationDate() }}</p>
            </div>
        </div>
    </x-filament::card>
</x-filament-panels::page>
