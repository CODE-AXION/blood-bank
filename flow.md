### **Overall System Flow for Blood Bank Management System**

The system primarily caters to three main user types: **Super Admin**, **Admin/Staff** , **Donor**, and **Patient**. Each interacts with different facets of the system, with the Admin having full control and oversight.

---

#### **I. Patient Flow / Donor Flow (Public-Facing & Requesting & Registering)**

This is the entry point for anyone accessing the website without logging in.

1.  **Website Access:**
    *   A user navigates to the Blood Bank Management System website.
    *   **Module:** Main Page Module (Public-Facing)
    *   **Features:**
        *   **Home Page (7.1):** Displays general project information, a gallery of camps, and highlights of the system.

2.  **Blood Request & Patient Registration:**
    *   A patient needs blood and visits the "Request For Blood" page.
    *   **Module:** Blood Requests Module (part of Main Page Module for input) this also acts as a patient registration as well so we need to make sure we properly label so that the form looks like its doing both the things patient registration and blood_requests 
    *   **Features:**
        *   **Request For Blood Page/Registration (7.3):** User fills in their personal details (name, email, contact, blood group needed, units, urgency, required by date) and patient details (if applicable).
        *   **Data Submission:** The request is submitted to the system.
    *   **System Action Flow:** The request is recorded in the `blood_requests` table with a 'pending' status. A new `user` with the 'patient' role and a corresponding `patients` record are created. An email is sent to the patient with a link to set their password, granting them access to their Patient Panel where they can track the request status. The request now enters the admin review queue.

3.  **Blood Search (Public View - Limited Info):**
    *   A user wants to check general availability of a blood group.
    *   **Module:** Search Module
    *   **Features:**
        *   **Search Page (7.6):** User selects a blood group from a dropdown and clicks "Submit".
        *   **Limited Display:** The system might show general availability (e.g., "Blood group O+ is currently available" or "Available units: X"), but not specific unit details for privacy/security reasons.

4.  **New Donor Registration:**
    *   An individual wishes to register as a blood donor.
    *   **Module:** Login Module (Account Creation/Registration)
    *   **Features:**
        *   **Registration Page (7.2):** User provides personal information (name, gender, DOB, mobile, email, address, city, state, blood group) and creates a password.
        *   **Submission & Verification (3.7):** Upon submission, the system records this as a new `user` with the 'donor' role and creates an entry in the `donors` table. The account status might initially be 'pending' for admin verification, or immediately 'active' based on system policy. "waiting for confirmation message as his data will be only added by administrator after verification."

---

#### **II. Donor Flow**

This flow is for registered and approved donors.

1.  **Donor Login:**
    *   A registered donor accesses the system.
    *   **Module:** Login Module
    *   **Features:**
        *   **Donor Login Form (7.5):** Donor enters their email/donor ID and password.
        *   **Authentication:** The system validates credentials against the `users` table. If successful, the donor is redirected to their Donor Panel.
        *   **Error Handling:** Invalid credentials display an error message.

2.  **Donor Panel Access:**
    *   Upon successful login, the donor lands on their personalized panel.
    *   **Module:** Donor Panel Module
    *   **Features:**
        *   **Welcome to Donor Panel (7.8):** A dashboard displaying relevant donor options.

3.  **Profile Management:**
    *   **Module:** Donor Panel Module
    *   **Features:**
        *   **Update Profile (7.10):** Donor views their stored personal information (name, gender, age, mobile number) and can modify it. Updates are saved to the `donors` table.
        *   **Change Password (7.9):** Donor can securely change their password by entering old and new passwords. Updates the `users` table.

4.  **Viewing Personal History:**
    *   **Module:** Donor Panel Module
    *   **Features:**
        *   **Blood Donated (7.11):** Donor views a list of their past blood donations, including date, camp (if applicable), and number of units. Data is pulled from the `blood_units` table.

5.  **Donating Blood (at a Camp or Blood Bank):**
    *   This is a real-world interaction but also has system integration.
    *   **Module:** Blood Camp Management / Donor Management / Blood Units Module
    *   **Features:**
        *   **Camp Registration:** Donor might register for a specific camp online or directly at the camp.
        *   **Collection:** Blood is collected.
        *   **System Entry (Admin/Staff):** An admin/staff member records the donation details in the system (see Admin Flow for details). The donor's `last_donation_date` and `eligible_to_donate_until` fields are updated in the `donors` table.

---

#### **III. Admin Flow**

The Admin has comprehensive control and oversight over all system functionalities.

1.  **Admin Login:**
    *   An administrator accesses the system.
    *   **Module:** Login Module
    *   **Features:**
        *   **Admin Login Form (6.4.1, 7.12):** Admin enters username and password.
        *   **Authentication:** System validates credentials against the `users` table (where `role` = 'admin').
        *   **Error Handling:** Invalid credentials redirect back to the login page.

2.  **Admin Panel Access:**
    *   Upon successful login, the admin is redirected to the Admin Panel.
    *   **Module:** Admin Panel Module
    *   **Features:**
        *   **Welcome to Admin Panel (7.12):** A dashboard with links to all management functionalities.

3.  **User Management:**
    *   **Module:** Admin Panel Module
    *   **Features:**
        *   **Add User (4.1.1):** Admin can create new user accounts (e.g., other admins, staff members) by entering their details.
        *   **Delete User:** Remove user accounts.
        *   **Donor Account Verification (6.4.1):** Admin verifies details of new donor registrations and activates their accounts.

4.  **Location Management (States & Cities):**
    *   **Module:** Admin Panel Module
    *   **Features:**
        *   **Add State/City:** Add new geographical locations to the `states` and `cities` tables.
        *   **Update State/City:** Modify existing state/city details.
        *   **Delete State/City:** Remove locations (with appropriate checks for dependencies).
        *   **View City/State:** Browse existing locations.

5.  **Blood Group Management:**
    *   **Module:** Admin Panel Module
    *   **Features:**
        *   **Add/Update/Delete Blood Group:** Manage the list of accepted blood groups (`blood_groups` table).

6.  **Blood Camp Management:**
    *   **Module:** Blood Camp Management and Reporting
    *   **Features:**
        *   **Add Camp (1.5.1):** Admin creates new blood donation camps, entering details like name, date, time, address, city, state, organizer, facilities. Records in the `camps` table.
        *   **Update Camp:** Modify existing camp details.
        *   **Delete Camp:** Remove camp records.
        *   **Assign Staff:** Allocate staff members (users with 'admin' role) to specific camps (`camp_staff` pivot table).

7.  **Donor Management (Detailed):**
    *   **Module:** Donor Management
    *   **Features:**
        *   **View Donors:** Access a comprehensive list of all registered donors from the `donors` table.
        *   **Edit Donor Details:** Modify any donor's profile information.
        *   **Filter Reports (1.5.1):** Generate detailed reports on donors based on various factors (blood group, gender, area, camp, date of donation, donor type) with Excel download capability.

8.  **Blood Units Inventory Management:**
    *   **Module:** Blood Components Management
    *   **Features:**
        *   **Add Blood Unit (from Donation):** When a donation occurs, admin records it:
            *   **Bar-coded Blood Bag Entry (1.5.1):** Enters unique bag ID.
            *   **Collection Details:** Records donor, blood group, collection date, volume, and collection camp (`blood_units` table).
            *   **Automatic Expiry Date (1.5.1):** System automatically calculates and sets expiry date based on collection date.
            *   **Initial Status:** Sets `status` to 'collected' or 'test_awaited'.
        *   **Update Blood Unit:** Modify details of an existing blood unit.

9.  **Serology Test Results Management:**
    *   **Module:** Donor Test Results Management and Adverse Reaction Data Management, Blood Components Management
    *   **Features:**
        *   **Record Test Results (1.5.1):** Admin enters serology test results for blood units (e.g., HIV, Hepatitis B). Records in `serology_tests` table.
        *   **Automatic Status Update (1.5.1):** Based on test results, the system automatically updates the `serology_test_status` and the main `status` of the blood unit (e.g., from 'test_awaited' to 'ready_for_issue' or 'discarded').
        *   **Filterable Selections (1.5.3):** View and filter test results.

10. **Patient Management:**
    *   **Module:** Patient Management System
    *   **Features:**
        *   **Add/Delete Patient Info (1.5.3):** Admin captures and manages patient personal information and the hospital requiring blood. Records in `patients` table.
        *   **View Patients:** Access a list of all registered patients.

11. **Managing Blood Requests:**
    *   **Module:** Blood Requests Module (Admin View)
    *   **Features:**
        *   **View Requests:** Admin reviews all pending blood requests (from `blood_requests` table).
        *   **Approve/Reject Requests:** Change the `status` of a blood request.
        *   **Match Requests:** Identify suitable blood units based on blood group and availability.
        *   **View Pending Requests:** Admin reviews a dashboard or dedicated page listing all blood requests with a 'pending' status.
        *   **Approve/Reject Requests:** Admin reviews the details of a request and can either approve it (changing status to 'approved') or reject it (changing status to 'rejected' and adding a reason). The patient is notified via email.
        *   **Issue Blood:** Admin selects a specific blood unit to issue. This action creates a `blood_issue` record, updates the `blood_unit` status to 'issued', and updates the `blood_request` status to 'fulfilled'.

12. **Blood Unit Reservation:**
    *   **Module:** Patient Management System
    *   **Features:**
        *   **Reserve Unit (1.5.3):** Admin can reserve a specific blood unit for a patient for 24 hours. This creates an entry in `reserved_units` with `reservation_date` and `expiration_date`.
        *   **Manage Reservations:** View, update, or cancel reservations.

13. **Blood Issue and Billing:**
    *   **Module:** Blood Issue and Billing
    *   **Features:**
        *   **Issue Blood (1.5.3):** Admin processes the issuance of a blood unit to a patient based on a request or direct need. Records in `blood_issues` table.
        *   **Cross-Match Check (1.5.3):** System prevents issue if cross-match is not done or fails.
        *   **Serology Check (1.5.3):** System ensures only serology-tested and 'ready_for_issue' units can be issued.
        *   **Payment Processing:** Records payment status and amount.
        *   **Adjustments (1.5.3):** Apply concessions or adjustments to the bill.


#### **IV. Patient Flow (Post-Registration)**

This flow is for users who have submitted a blood request and now have a patient account.

1.  **Patient Login:**
    *   A registered patient uses the link from their email to set their password for the first time, then logs in.
    *   **Module:** Login Module
    *   **Authentication:** System validates credentials against the `users` table (where `role` = 'patient').

2.  **Patient Panel Access:**
    *   Upon successful login, the patient is taken to their personal dashboard.
    *   **Module:** Patient Management System (Patient Panel)

3.  **Request Status Tracking:**
    *   The primary feature is a page listing all their past and present blood requests.
    *   They can see the current **status** (e.g., Pending, Approved, Fulfilled, Rejected) of each request in real-time.

4.  **Profile Management:**
    *   Patients can view and update their personal information (address, mobile number) and change their account password.

5.  **Submitting Additional Requests:**
    *   The panel provides an easy way to submit a new blood request. The form will be pre-populated with their existing personal details, simplifying the process.


---

#### **V. Donor & Donation Lifecycle Flow**

This section details the end-to-end process from a new donor registering to their blood becoming available in the inventory.

**A. Donor-Initiated Actions (Frontend)**

1.  **Registration:** A prospective donor fills out the registration form on the public website. A `user` and `donor` record are created with a `pending_verification` status.
2.  **Login & Panel Access:** Once approved by an admin, the donor can log in to their personal panel.
3.  **Self-Service:** In their panel, the donor can update their profile information and view their past donation history.

**B. Admin-Managed Actions (Backend)**

1.  **Account Verification:** An admin sees the new `pending_verification` donor in the Filament panel. After reviewing the details, the admin uses an "Approve" action to activate the account. The donor is notified via email.
2.  **Recording a Donation (Inventory Creation):**
    *   When an active donor donates blood, an admin opens the `BloodUnitResource` in Filament.
    *   The admin selects the donor, enters the unique bag ID, collection date, and other details.
    *   Upon saving, a new `blood_unit` is created with a status of `'test_awaited'`, and the donor's `last_donation_date` is updated.
3.  **Serology Testing:** The admin navigates to the newly created blood unit's record and uses a Relation Manager to enter the results of various serology tests (e.g., HIV, Hepatitis).
4.  **Inventory Activation (Automation):** Once all required tests are logged with 'negative' results, the system automatically changes the `blood_unit`'s status from `'test_awaited'` to **`'ready_for_issue'`**.

At the conclusion of this flow, a new, safe, and tested unit of blood is officially available in the system's inventory, ready to be allocated to a patient via the Blood Request Module.

---

### **Inter-Module Workflows / Background Processes**

*   **Blood Collection to Inventory:** When blood is collected (e.g., at a camp), an admin creates a `blood_unit` entry, automatically setting expiry and initial status.
*   **Serology Test Workflow:** A `blood_unit` moves from 'collected' to 'test_awaited'. After `serology_tests` are recorded, the `blood_unit`'s status automatically updates to 'ready_for_issue' or 'discarded'.
*   **Blood Request to Issue Workflow:** A `blood_request` is created (by user/patient). An admin reviews it, finds available 'ready_for_issue' `blood_units`, possibly reserves one (`reserved_units`), performs cross-matching, and then records a `blood_issue`, updating the `blood_unit` status to 'issued'.
*   **Donor Eligibility:** The system uses `last_donation_date` to automatically calculate `eligible_to_donate_until` for donors, helping to manage donor outreach and camp assignments.