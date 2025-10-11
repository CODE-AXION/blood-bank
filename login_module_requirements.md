
### Initial Steps for Building the Login Module:

1.  **Modify User Registration to Assign Roles and Create Donor Records:**

    *   **Goal:** When a new user registers through the public-facing registration page, the system needs to:
        *   Assign an appropriate `role` (e.g., 'donor' or 'patient') to the new `User` record.
        *   If the registration is for a donor, create a corresponding `Donor` record and link it to the `User`.
        *   Set the initial `status` of the `Donor` record to 'pending' for administrator verification, as per your `flow.md` and `requirements.md`.
    *   **Details:**
        *   The `store` method in `RegisteredUserController` currently creates a `User` with `name`, `email`, and `password`. You'll need to extend this.
        *   You'll need to determine how the registration form indicates if the user is registering as a donor. This might involve an additional field in the registration form or a separate registration route/view for donors.
        *   If the user is registering as a donor, after `User::create()`, you'll need to create a new `Donor` record (`Donor::create([...])`), passing relevant details from the registration request and setting the `user_id` to the newly created user's ID. Crucially, set the `status` field in the `Donor` record to 'pending'.
        *   The registration form (which currently is `resources/views/auth/register.blade.php`) will need additional fields for donor-specific information (e.g., mobile number, gender, DOB, address, blood group, city, state) that will be used to populate the `Donor` model.
        *   Instead of immediately logging in the user and redirecting to `RouteServiceProvider::HOME`, if a donor registers, they should be redirected to a "waiting for verification" or "account pending" page.

2.  **Implement Role-Based Redirection After Login:**

    *   **Goal:** After a user successfully logs in, the system should check their `role` (from the `users` table) and redirect them to their specific dashboard: Admin to Admin Panel, Donor to Donor Panel, and general users to a general user dashboard (e.g., the home page or a basic user profile).
    *   **Affected File:** `tag/app/Http/Controllers/Auth/AuthenticatedSessionController.php` and potentially `tag/app/Providers/RouteServiceProvider.php`
    *   **Details:**
        *   In the `store` method of `AuthenticatedSessionController`, after `$request->authenticate()` and `$request->session()->regenerate()`, you'll access the authenticated user object (`Auth::user()`).
        *   Use the `isAdmin()`, `isDonor()`, or `isGeneralUser()` methods (or directly check the `role` attribute) on the `User` model to determine the user's role.
        *   Based on the role, use `redirect()->intended(...)` or `redirect()->route(...)` to send them to the appropriate named route for their dashboard. For example, an admin might go to `/admin/dashboard`, a donor to `/donor/dashboard`, and other users to `RouteServiceProvider::HOME` or a public dashboard.
        *   You might need to define new named routes in `tag/routes/web.php` for these role-specific dashboards.

3.  **Define Basic Admin and Donor Dashboard Routes and Views:**

    *   **Goal:** Create the basic structure for the different user dashboards that the role-based redirection will point to. These can be minimal initially, just displaying a "Welcome" message.
    *   **Affected Files:** `tag/routes/web.php` and new `.blade.php` files in `tag/resources/views/`.
    *   **Details:**
        *   In `tag/routes/web.php`, within the `middleware('auth')` group, define new routes for the admin and donor dashboards.
        *   Example:
            ```php
            // ... existing code ...

            Route::middleware(['auth', 'role:admin'])->group(function () {
                Route::get('/admin/dashboard', function () {
                    return view('admin.dashboard');
                })->name('admin.dashboard');
            });

            Route::middleware(['auth', 'role:donor'])->group(function () {
                Route::get('/donor/dashboard', function () {
                    return view('donor.dashboard');
                })->name('donor.dashboard');
            });

            // ... existing code ...
            ```
            *(Note: The `role:admin` and `role:donor` middleware would need to be created/configured to enforce role-based access control, but for the initial redirection, defining the routes is the first step.)*
        *   Create corresponding blade view files, such as `tag/resources/views/admin/dashboard.blade.php` and `tag/resources/views/donor/dashboard.blade.php`.