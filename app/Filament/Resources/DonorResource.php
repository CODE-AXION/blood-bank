<?php

namespace App\Filament\Resources;

use App\Filament\Resources\DonorResource\Pages;
use App\Filament\Resources\DonorResource\RelationManagers;
use App\Models\Donor;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Actions\Action;
use App\Mail\DonorAccountApproved;
use Illuminate\Support\Facades\Mail;
use Filament\Tables\Filters\TernaryFilter;
use Filament\Resources\Pages\ViewRecord;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;

class DonorResource extends Resource
{
    protected static ?string $model = Donor::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    
    public static function shouldRegisterNavigation(): bool
    {
        $user = auth()->user();
        return $user && $user->isSuperAdmin();
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                TextInput::make('user.name')
                    ->label('Name')
                    ->disabled(),
                TextInput::make('user.email')
                    ->label('Email')
                    ->disabled(),
                TextInput::make('first_name')
                    ->label('First Name')
                    ->disabled(),
                TextInput::make('last_name')
                    ->label('Last Name')
                    ->disabled(),
                TextInput::make('mobile_number')
                    ->label('Mobile Number')
                    ->disabled(),
                Select::make('gender')
                    ->options([
                        'male' => 'Male',
                        'female' => 'Female',
                        'other' => 'Other',
                    ])
                    ->disabled(),
                DatePicker::make('date_of_birth')
                    ->label('Date of Birth')
                    ->disabled(),
                Textarea::make('address')
                    ->label('Address')
                    ->disabled(),
                Select::make('city_id')
                    ->relationship('city', 'name')
                    ->label('City')
                    ->disabled(),
                Select::make('state_id')
                    ->relationship('state', 'name')
                    ->label('State')
                    ->disabled(),
                Select::make('blood_group_id')
                    ->relationship('bloodGroup', 'group_name')
                    ->label('Blood Group')
                    ->disabled(),
                DatePicker::make('last_donation_date')
                    ->label('Last Donation Date')
                    ->disabled(),
                DatePicker::make('eligible_to_donate_until')
                    ->label('Eligible to Donate Until')
                    ->disabled(),
                TextInput::make('enrollment_number')
                    ->label('Enrollment Number')
                    ->disabled(),
                Select::make('status')
                    ->options([
                        'pending_verification' => 'Pending Verification',
                        'active' => 'Active',
                        'inactive' => 'Inactive',
                        'suspended' => 'Suspended',
                    ])
                    ->disabled(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('user.name')
                    ->label('Name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('user.email')
                    ->label('Email')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('bloodGroup.group_name')
                    ->label('Blood Group')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('city.name')
                    ->label('City')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'pending_verification' => 'warning',
                        'active' => 'success',
                        'inactive' => 'danger',
                        'suspended' => 'gray',
                    })
                    ->searchable()
                    ->sortable(),
            ])
            ->filters([
                SelectFilter::make('blood_group')
                    ->relationship('bloodGroup', 'group_name')
                    ->label('Blood Group'),
                SelectFilter::make('city')
                    ->relationship('city', 'name')
                    ->label('City'),
                SelectFilter::make('status')
                    ->options([
                        'pending_verification' => 'Pending Verification',
                        'active' => 'Active',
                        'inactive' => 'Inactive',
                        'suspended' => 'Suspended',
                    ])
                    ->label('Status'),
                TernaryFilter::make('pending_verification')
                    ->label('Pending Verification')
                    ->queries(
                        true: fn (Builder $query): Builder => $query->where('status', 'pending_verification'),
                        false: fn (Builder $query): Builder => $query->where('status', '!=', 'pending_verification'),
                        blank: fn (Builder $query): Builder => $query,
                    ),
            ])
            ->actions([
                Action::make('approve')
                    ->action(function (Donor $record) {
                        $record->status = 'active';
                        $record->save();
                        Mail::to($record->user->email)->send(new DonorAccountApproved($record));
                    })
                    ->label('Approve')
                    ->visible(fn (Donor $record): bool => $record->status === 'pending_verification')
                    ->color('success')
                    ->icon('heroicon-o-check-circle'),
                Action::make('suspend')
                    ->action(function (Donor $record) {
                        $record->status = 'suspended';
                        $record->save();
                    })
                    ->label('Suspend')
                    ->visible(fn (Donor $record): bool => $record->status !== 'suspended')
                    ->color('warning')
                    ->icon('heroicon-o-pause-circle'),
                Action::make('deactivate')
                    ->action(function (Donor $record) {
                        $record->status = 'inactive';
                        $record->save();
                    })
                    ->label('Deactivate')
                    ->visible(fn (Donor $record): bool => $record->status !== 'inactive')
                    ->color('danger')
                    ->icon('heroicon-o-x-circle'),
                Tables\Actions\ViewAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListDonors::route('/'),
            // 'create' => Pages\CreateDonor::route('/create'), // Removing create page
            // 'edit' => Pages\EditDonor::route('/{record}/edit'), // Removing edit page
            'view' => Pages\ViewDonor::route('/{record}'),
        ];
    }
}
