<?php

namespace App\Filament\Donor\Pages;

use Filament\Pages\Page;
use App\Models\Donor;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class Dashboard extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    protected static string $view = 'filament.donor.pages.dashboard';

    public function getHeading(): string
    {
        return 'Welcome, ' . Auth::user()->name . ' !';
    }

    public function getLastDonationDate(): ?string
    {
        $donor = Donor::where('user_id', Auth::id())->first();
        return $donor?->last_donation_date?->format('F j, Y');
    }

    public function getNextEligibleDonationDate(): string
    {
        $donor = Donor::where('user_id', Auth::id())->first();

        if (!$donor || !$donor->last_donation_date) {
            return 'Please make your first donation!';
        }

        $nextEligibleDate = Carbon::parse($donor->last_donation_date)->addWeeks(12);

        if ($nextEligibleDate->isPast()) {
            return 'You are eligible to donate now!';
        }

        return $nextEligibleDate->format('F j, Y');
    }
}
