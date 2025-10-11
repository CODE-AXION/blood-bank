<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class BloodRequest extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'patient_id',
        'requester_user_id',
        'blood_group_id',
        'units_requested',
        'urgency_level',
        'request_date',
        'required_by_date',
        'status',
        'description',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'request_date' => 'date',
        'required_by_date' => 'date',
    ];

    /**
     * Get the patient that made the blood request.
     */
    public function patient(): BelongsTo
    {
        return $this->belongsTo(Patient::class);
    }

    /**
     * Get the user that made the blood request.
     */
    public function requesterUser(): BelongsTo
    {
        return $this->belongsTo(User::class, 'requester_user_id');
    }

    /**
     * Get the blood group for the blood request.
     */
    public function bloodGroup(): BelongsTo
    {
        return $this->belongsTo(BloodGroup::class);
    }

    /**
     * Get the blood issues for the blood request.
     */
    public function bloodIssues(): HasMany
    {
        return $this->hasMany(BloodIssue::class);
    }
}
