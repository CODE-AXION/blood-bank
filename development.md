Note: This project will be built entirely on FilamentV3. So make sure to use filament components wherver possible !

### Guidelines for Writing Logic in Laravel

1. **Validation**
   Always use `$request->validate()` directly within the controller method for validations. Avoid using separate Form Request classes.

2. **Error Handling**
   Implement proper error handling, especially when dealing with complex logic. Use `try-catch` blocks where appropriate, and return clear error responses.

3. **Code Comments**
   Add clear and concise comments within your functions to explain the logic and flow. This helps in understanding what the code is doing and why.


4. **Code Structure**
   Keep your logic organized and readable. Avoid unnecessary abstraction—**prefer keeping the logic within a single method** unless splitting it out significantly improves **reusability** or **readability**. Only create separate methods when it genuinely adds clarity or avoids repetition. Do not over-engineer by creating small, isolated methods that don’t serve a clear purpose.

5. **Authorization Logic**
   Do **not use Gates or Policies** for handling authorization.
   Instead, write **explicit authorization checks** directly in the controller.
   Make use of reusable methods in the User model to check roles/permissions, such as for example:

   ```php
      auth()->user()->isAdmin()
      auth()->user()->isDonor()
      auth()->user()->isVolunteer()
   ```

6. **Styling and Frontend**
   Use **TailwindCSS** for all frontend styling.
   * Prefer utility-first CSS classes over writing custom CSS.
   * Keep your Blade templates clean and readable



