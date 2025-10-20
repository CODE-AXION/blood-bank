<?php

namespace App\Filament\Resources;

use App\Filament\Resources\BloodRequestResource\Pages;
use App\Filament\Resources\BloodRequestResource\RelationManagers;
use App\Models\BloodGroup;
use App\Models\BloodRequest;
use App\Models\Patient;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;

class BloodRequestResource extends Resource
{
    protected static ?string $model = BloodRequest::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Select::make('patient_id')
                    ->label('Patient')
                    ->options(Patient::all()->pluck('first_name', 'id'))
                    ->searchable()
                    ->required(),
                Select::make('blood_group_id')
                    ->label('Blood Group')
                    ->options(BloodGroup::all()->pluck('group_name', 'id'))
                    ->searchable()
                    ->required(),
                TextInput::make('units_requested')
                    ->numeric()
                    ->suffix('units')
                    ->required(),
                Select::make('urgency_level')
                    ->options([
                        'routine' => 'Routine',
                        'urgent' => 'Urgent',
                        'emergency' => 'Emergency',
                    ])
                    ->required(),
                DatePicker::make('request_date')
                    ->native(false)
                    ->required(),
                DatePicker::make('required_by_date')
                    ->native(false)
                    ->nullable(),
                Textarea::make('description')
                    ->nullable()
                    ->columnSpan('full'),
                Select::make('status')
                    ->options([
                        'pending' => 'Pending',
                        'approved' => 'Approved',
                        'fulfilled' => 'Fulfilled',
                        'rejected' => 'Rejected',
                        'canceled' => 'Canceled',
                    ])
                    ->required(),
                Textarea::make('rejection_reason')
                    ->nullable()
                    ->columnSpan('full'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('patient.first_name')
                    ->label('Patient Name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('bloodGroup.group_name')
                    ->label('Blood Group')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('units_requested')
                    ->label('Units')
                    ->sortable(),
                TextColumn::make('urgency_level')
                    ->label('Urgency')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'routine' => 'gray',
                        'urgent' => 'warning',
                        'emergency' => 'danger',
                    })
                    ->sortable(),
                TextColumn::make('request_date')
                    ->date()
                    ->sortable(),
                TextColumn::make('required_by_date')
                    ->date()
                    ->sortable(),
                TextColumn::make('status')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'pending' => 'warning',
                        'approved' => 'success',
                        'fulfilled' => 'info',
                        'rejected' => 'danger',
                        'canceled' => 'gray',
                    })
                    ->searchable()
                    ->sortable(),
            ])
            ->filters([
                SelectFilter::make('status')
                    ->options([
                        'pending' => 'Pending',
                        'approved' => 'Approved',
                        'fulfilled' => 'Fulfilled',
                        'rejected' => 'Rejected',
                        'canceled' => 'Canceled',
                    ])
                    ->label('Filter by Status'),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\Action::make('approve')
                    ->action(function (BloodRequest $record) {
                        $record->status = 'approved';
                        $record->save();
                    })
                    ->requiresConfirmation()
                    ->color('success')
                    ->icon('heroicon-o-check-circle')
                    ->hidden(fn (BloodRequest $record): bool => $record->status !== 'pending'),
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
            'index' => Pages\ListBloodRequests::route('/'),
            'create' => Pages\CreateBloodRequest::route('/create'),
            'edit' => Pages\EditBloodRequest::route('/{record}/edit'),
        ];
    }
}
