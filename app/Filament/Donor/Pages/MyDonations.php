<?php

namespace App\Filament\Donor\Pages;

use Filament\Pages\Page;
use App\Models\BloodUnit;
use Illuminate\Support\Facades\Auth;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Concerns\InteractsWithTable;
use Filament\Tables\Contracts\HasTable;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class MyDonations extends Page implements HasTable
{
    use InteractsWithTable;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';

    protected static string $view = 'filament.donor.pages.my-donations';

    protected static ?string $title = 'My Donations';

    public function table(Table $table): Table
    {
        return $table
            ->query(
                BloodUnit::query()
                    ->whereHas('donor.user', function (Builder $query) {
                        $query->where('id', Auth::id());
                    })
                    ->with('camp')
            )
            ->columns([
                TextColumn::make('collection_date')
                    ->date()
                    ->label('Donation Date'),
                TextColumn::make('camp.name')
                    ->default('Main Blood Bank')
                    ->label('Location'),
                TextColumn::make('component_type')
                    ->label('Component Type'),
                TextColumn::make('unique_bag_id')
                    ->label('Bag ID'),
            ]);
    }
}
