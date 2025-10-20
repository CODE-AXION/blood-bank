Based on the modules and features outlined in the PDF, here is a comprehensive database design tailored for a Laravel project, including tables, columns, data types, and relationships. This design aims to cover all specified functionalities without missing any details.

---

### Database Design for Blood Bank Management System (Laravel)

**General Considerations for Laravel:**
*   All tables will implicitly have `id` (primary key, auto-incrementing `UNSIGNED BIGINT`) and `created_at`, `updated_at` (`TIMESTAMP`) columns due to Laravel's Eloquent ORM conventions, unless specified otherwise.
*   Foreign key columns will typically be `unsignedBigInteger`.
*   ENUM types are used for clear status and type definitions; these can be implemented as `ENUM` in MySQL or as `VARCHAR` with validation in Laravel if preferred for broader compatibility.

---

#### **1. `users` Table**
This table will store general user information and serve as the base for different roles (Admin, Donor, Patient).

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`name`**: `string` (e.g., 'John Doe' or 'Admin User')
*   **`email`**: `string` (Unique, for login)
*   **`email_verified_at`**: `timestamp` (Nullable)
*   **`password`**: `string`
*   **`role`**: `enum` ('admin', 'donor', 'patient') - *Crucial for distinguishing access levels.*
*   **`remember_token`**: `string` (Nullable)
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **2. `blood_groups` Table**
A lookup table for all possible blood types.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`group_name`**: `string` (Unique, e.g., 'A+', 'O-', 'AB+')
*   **`description`**: `text` (Nullable, e.g., compatibility info)
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **3. `states` Table**
For managing state information, used in addresses and camp locations.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`name`**: `string` (Unique, e.g., 'Gujarat', 'Maharashtra')
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **4. `cities` Table**
For managing city information, linked to states.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`state_id`**: `unsignedBigInteger` (Foreign Key to `states.id`)
*   **`name`**: `string`
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`
*   **Unique Constraint**: `(name, state_id)`

---

#### **5. `donors` Table**
Stores specific details for users registered as donors.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`user_id`**: `unsignedBigInteger` (Unique Foreign Key to `users.id`) - *Each donor is a user.*
*   **`first_name`**: `string`
*   **`last_name`**: `string`
*   **`mobile_number`**: `string` (Unique)
*   **`gender`**: `enum` ('male', 'female', 'other')
*   **`date_of_birth`**: `date`
*   **`address`**: `text` (Nullable)
*   **`city_id`**: `unsignedBigInteger` (Foreign Key to `cities.id`)
*   **`state_id`**: `unsignedBigInteger` (Foreign Key to `states.id`)
*   **`blood_group_id`**: `unsignedBigInteger` (Foreign Key to `blood_groups.id`)
*   **`last_donation_date`**: `date` (Nullable) - *Used for eligibility calculations.*
*   **`eligible_to_donate_until`**: `date` (Nullable) - *Calculated based on `last_donation_date` and donation type guidelines (e.g., 12 weeks).*
*   **`enrollment_number`**: `string` (Nullable, e.g., '200346620147') - *As seen on certificate.*
*   **`status`**: `enum` ('active', 'inactive', 'suspended') - *For donor eligibility.*
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **6. `camps` Table**
Manages information about blood donation camps.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`name`**: `string` (e.g., 'Ramgarhla Engg Collage Camp')
*   **`camp_date`**: `date`
*   **`start_time`**: `time` (Nullable)
*   **`end_time`**: `time` (Nullable)
*   **`address`**: `text`
*   **`city_id`**: `unsignedBigInteger` (Foreign Key to `cities.id`)
*   **`state_id`**: `unsignedBigInteger` (Foreign Key to `states.id`)
*   **`organizer`**: `string` (Nullable, e.g., 'Ramgarhla Council', 'Lion Club')
*   **`facilities_available`**: `text` (Nullable, JSON or comma-separated list)
*   **`description`**: `text` (Nullable)
*   **`status`**: `enum` ('upcoming', 'active', 'completed', 'cancelled')
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **7. `camp_staff` Table (Pivot Table)**
To manage staff allocation for camps.

*   **`camp_id`**: `unsignedBigInteger` (Foreign Key to `camps.id`)
*   **`user_id`**: `unsignedBigInteger` (Foreign Key to `users.id`) - *Assuming staff are 'admin' role users.*
*   **`role_in_camp`**: `string` (Nullable, e.g., 'Coordinator', 'Nurse', 'Medical Officer')
*   **Primary Key**: `(camp_id, user_id)`
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **8. `blood_units` Table**
Detailed information for each collected blood unit.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`unique_bag_id`**: `string` (Unique, for bar-coded entry)
*   **`donor_id`**: `unsignedBigInteger` (Foreign Key to `donors.id`)
*   **`blood_group_id`**: `unsignedBigInteger` (Foreign Key to `blood_groups.id`)
*   **`collection_date`**: `date`
*   **`expiry_date`**: `date`
*   **`component_type`**: `enum` ('whole_blood', 'plasma', 'platelet', 'red_blood_cells') - *As per "Types of Donation".*
*   **`volume_ml`**: `integer` (Nullable)
*   **`collection_camp_id`**: `unsignedBigInteger` (Nullable, Foreign Key to `camps.id`) - *If collected at a camp.*
*   **`status`**: `enum` ('collected', 'test_awaited', 'tested', 'ready_for_issue', 'issued', 'expired', 'discarded', 'quarantined') - *Crucial for inventory.*
*   **`serology_test_status`**: `enum` ('pending', 'passed', 'failed') - *Directly from the PDF.*
*   **`storage_location`**: `string` (Nullable, e.g., 'Fridge A, Shelf 3')
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **9. `serology_tests` Table**
Records the results of tests performed on each blood unit.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`blood_unit_id`**: `unsignedBigInteger` (Foreign Key to `blood_units.id`)
*   **`test_type`**: `string` (e.g., 'HIV', 'Hepatitis B', 'Syphilis')
*   **`result`**: `enum` ('positive', 'negative', 'indeterminate')
*   **`test_date`**: `date`
*   **`tested_by_user_id`**: `unsignedBigInteger` (Nullable, Foreign Key to `users.id`) - *Admin/staff who performed the test.*
*   **`notes`**: `text` (Nullable)
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **10. `patients` Table**
Stores personal information of blood recipients.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`user_id`**: `unsignedBigInteger` (Nullable)
*   **`first_name`**: `string`
*   **`last_name`**: `string`
*   **`mobile_number`**: `string` (Nullable)
*   **`email`**: `string` (Nullable, Unique if provided)
*   **`gender`**: `enum` ('male', 'female', 'other')
*   **`date_of_birth`**: `date`
*   **`address`**: `text` (Nullable)
*   **`hospital_name`**: `string` (Where blood is required)
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **11. `blood_requests` Table**
Records requests for blood, whether by a patient, general user, or clinic.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`patient_id`**: `unsignedBigInteger` (Nullable, Foreign Key to `patients.id`) - *patient requests.*
*   **`blood_group_id`**: `unsignedBigInteger` (Foreign Key to `blood_groups.id`)
*   **`units_requested`**: `integer`
*   **`urgency_level`**: `enum` ('routine', 'urgent', 'emergency')
*   **`request_date`**: `date`
*   **`required_by_date`**: `date` (Nullable)
*   **`status`**: `enum` ('pending', 'approved', 'fulfilled', 'rejected', 'canceled')
*   **`rejection_reason`**: `text` (Nullable) 
*   **`description`**: `text` (Nullable)
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **12. `blood_issues` Table**
Records every instance of blood being issued to a patient/hospital.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`blood_request_id`**: `unsignedBigInteger` (Nullable, Foreign Key to `blood_requests.id`) - *Links to the original request.*
*   **`patient_id`**: `unsignedBigInteger` (Foreign Key to `patients.id`)
*   **`blood_unit_id`**: `unsignedBigInteger` (Unique Foreign Key to `blood_units.id`) - *Each unit can only be issued once.*
*   **`issue_date`**: `datetime`
*   **`issued_by_user_id`**: `unsignedBigInteger` (Foreign Key to `users.id`) - *Admin/staff who issued it.*
*   **`cross_match_status`**: `enum` ('pending', 'passed', 'failed', 'not_performed') - *Crucial safety check.*
*   **`payment_status`**: `enum` ('pending', 'paid', 'waived')
*   **`total_amount`**: `decimal(10, 2)`
*   **`adjustment_details`**: `text` (Nullable, for concessions)
*   **`receipt_number`**: `string` (Unique, Nullable)
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **13. `reserved_units` Table**
Handles the 24-hour reservation feature for blood units.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`blood_unit_id`**: `unsignedBigInteger` (Unique Foreign Key to `blood_units.id`)
*   **`patient_id`**: `unsignedBigInteger` (Foreign Key to `patients.id`)
*   **`blood_request_id`**: `unsignedBigInteger` (Foreign Key to `blood_requests.id`)
*   **`reserved_by_user_id`**: `unsignedBigInteger` (Foreign Key to `users.id`) - *Staff who made the reservation.*
*   **`reservation_date`**: `datetime`
*   **`expiration_date`**: `datetime` - *Calculated 24 hours from `reservation_date`.*
*   **`status`**: `enum` ('active', 'fulfilled', 'expired', 'canceled')
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **14. `transfusion_reactions` Table**
Records any adverse reactions during or after a transfusion.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`patient_id`**: `unsignedBigInteger` (Foreign Key to `patients.id`)
*   **`blood_unit_id`**: `unsignedBigInteger` (Nullable, Foreign Key to `blood_units.id`) - *If linked to a specific unit.*
*   **`reaction_date`**: `datetime`
*   **`reaction_type`**: `string` (e.g., 'Febrile non-hemolytic', 'Allergic', 'Acute hemolytic')
*   **`severity`**: `enum` ('mild', 'moderate', 'severe', 'fatal')
*   **`description`**: `text`
*   **`reported_by_user_id`**: `unsignedBigInteger` (Nullable, Foreign Key to `users.id`) - *Staff who reported.*
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **15. `galleries` Table**
For storing images/media, potentially linked to camps.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`title`**: `string`
*   **`image_path`**: `string` (Path to the image file)
*   **`description`**: `text` (Nullable)
*   **`camp_id`**: `unsignedBigInteger` (Nullable, Foreign Key to `camps.id`) - *If the image is from a specific camp.*
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **16. `news` Table**
For publishing news articles or updates on the system.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`title`**: `string`
*   **`content`**: `text`
*   **`publication_date`**: `date`
*   **`author_user_id`**: `unsignedBigInteger` (Nullable, Foreign Key to `users.id`) - *Admin who published.*
*   **`is_published`**: `boolean` (Default: `false`)
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

#### **17. `advertisements` Table**
For managing advertisements displayed on the website.

*   **`id`**: `unsignedBigInteger` (Primary Key)
*   **`title`**: `string`
*   **`image_path`**: `string` (Nullable, path to ad image)
*   **`content`**: `text` (Nullable, for text-based ads)
*   **`start_date`**: `date`
*   **`end_date`**: `date` (Nullable)
*   **`is_active`**: `boolean` (Default: `true`)
*   **`created_at`**: `timestamp`
*   **`updated_at`**: `timestamp`

---

### **Relationships Summary:**

*   **`users`**:
    *   Has one `donor` (one-to-one)
    *   Has one `patient` (one-to-one)
    *   Has many `camp_staff` entries (one-to-many through `camp_staff` pivot)
    *   Has many `blood_requests` (as patient, one-to-many)
    *   Has many `blood_issues` (as issuer, one-to-many)
    *   Has many `reserved_units` (as reserver, one-to-many)
    *   Has many `transfusion_reactions` (as reporter, one-to-many)
    *   Has many `news` (as author, one-to-many)
*   **`donors`**:
    *   Belongs to `user` (one-to-one, inverse)
    *   Belongs to `blood_group` (many-to-one)
    *   Has many `blood_units` (one-to-many)
*   **`blood_groups`**:
    *   Has many `donors` (one-to-many)
    *   Has many `blood_units` (one-to-many)
    *   Has many `blood_requests` (one-to-many)
*   **`states`**:
    *   Has many `cities` (one-to-many)
    *   Has many `camps` (one-to-many)
*   **`cities`**:
    *   Belongs to `state` (many-to-one)
    *   Has many `camps` (one-to-many)
*   **`camps`**:
    *   Belongs to `city` (many-to-one)
    *   Belongs to `state` (many-to-one)
    *   Has many `camp_staff` entries (one-to-many through `camp_staff` pivot)
    *   Has many `blood_units` (one-to-many, for units collected at the camp)
    *   Has many `galleries` (one-to-many)
*   **`blood_units`**:
    *   Belongs to `donor` (many-to-one)
    *   Belongs to `blood_group` (many-to-one)
    *   Belongs to `camp` (many-to-one, nullable)
    *   Has many `serology_tests` (one-to-many)
    *   Has one `blood_issue` (one-to-one, inverse - once issued, it's done)
    *   Has one `reserved_unit` (one-to-one, inverse)
    *   Has many `transfusion_reactions` (one-to-many, nullable)
*   **`serology_tests`**:
    *   Belongs to `blood_unit` (many-to-one)
    *   Belongs to `user` (as tester, many-to-one)
*   **`patients`**:
    *   Belongs to `user` (one-to-one, inverse)
    *   Has many `blood_requests` (one-to-many)
    *   Has many `blood_issues` (one-to-many)
    *   Has many `reserved_units` (one-to-many)
    *   Has many `transfusion_reactions` (one-to-many)
*   **`blood_requests`**:
    *   Belongs to `patient` (many-to-one, nullable)
    *   Belongs to `user` (as requester, many-to-one, nullable)
    *   Belongs to `blood_group` (many-to-one)
    *   Has many `blood_issues` (one-to-many - a request might lead to multiple issues if units are supplied over time or partially)
*   **`blood_issues`**:
    *   Belongs to `blood_request` (many-to-one, nullable)
    *   Belongs to `patient` (many-to-one)
    *   Belongs to `blood_unit` (one-to-one)
    *   Belongs to `user` (as issuer, many-to-one)
*   **`reserved_units`**:
    *   Belongs to `blood_unit` (one-to-one)
    *   Belongs to `patient` (many-to-one)
    *   Belongs to `user` (as reserver, many-to-one)
    *   Belongs to `blood_request` (many-to-one, nullable)
*   **`transfusion_reactions`**:
    *   Belongs to `patient` (many-to-one)
    *   Belongs to `blood_unit` (many-to-one, nullable)
    *   Belongs to `user` (as reporter, many-to-one, nullable)
*   **`galleries`**:
    *   Belongs to `camp` (many-to-one, nullable)
*   **`news`**:
    *   Belongs to `user` (as author, many-to-one, nullable)

This detailed database schema provides the foundation for building the Blood Bank Management System in Laravel, accommodating all the features and modules identified in your PDF.