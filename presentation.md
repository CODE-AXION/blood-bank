# Blood Management System - Presentation Script

This document outlines the flow for presenting the Blood Management System. Follow these steps to demonstrate the complete lifecycle of blood management, from a patient's request to the final issuance of blood.

---

## **1. Patient: Requesting Blood (and Registration)**

**Goal:** Demonstrate how a new patient requests blood and is automatically registered in the system.

*   **Action:** Navigate to the **Home Page** (Public View).
*   **Narration:** "We start with the public-facing website. Here, anyone can access information about blood camps and general details."
*   **Action:** Click on **"Request Blood"** (or navigate to the Request Blood page).
*   **Narration:** "Let's say a patient needs blood. They don't need an account yet. They simply go to the Request Blood section."
*   **Action:** Fill out the form:
    *   **Patient Name:** (e.g., "John Doe")
    *   **Contact Info:** (Enter valid dummy data)
    *   **Blood Group Needed:** (e.g., "A+")
    *   **Urgency:** (Select an option)
    *   **Required Date:** (Select a date)
    *   **Submit the form.**
*   **Narration:** "As you can see, this form collects the necessary medical details. Behind the scenes, submitting this form does two things: it creates a **Blood Request** record and simultaneously registers 'John Doe' as a **Patient** in our system. He will receive an email to set his password and track this request."

---

## **2. Donor: Registration**

**Goal:** Show how a donor registers to become part of the blood bank.

*   **Action:** Navigate to the **"Register as Donor"** page.
*   **Narration:** "Now, let's look at the supply side. A volunteer wants to donate blood. They visit the registration page."
*   **Action:** Fill out the Donor Registration form:
    *   **Name:** (e.g., "Jane Smith")
    *   **Blood Group:** (e.g., "A+")
    *   **Contact/Address:** (Enter valid dummy data)
    *   **Submit the form.**
*   **Narration:** "Once Jane submits her details, she is registered as a donor. However, for safety, her account might require admin verification before she can fully participate or be recorded as an active donor."

---

## **3. Admin: Managing Blood Requests**

**Goal:** Switch to the Admin view to handle the patient's request.

*   **Action:** Log out and **Log in as Admin** (using credentials from `setup.md` if needed).
*   **Narration:** "Now, I am logging in as the **Super Admin**. This gives me full control over the system."
*   **Action:** Navigate to the **"Blood Requests"** module in the Admin Panel.
*   **Narration:** "Here in the Blood Requests module, we can see the request we just created for John Doe. It is currently marked as 'Pending'."
*   **Action:** Click to **View/Edit** the request.
*   **Narration:** "As an admin, I review the urgency and details. I can check our inventory to see if we have a matching blood unit. If valid, I can change the status to 'Approved' or 'In Progress'."
    *   *(Optional: Briefly show the status change).*

---

## **4. Admin: Blood Tests & Inventory Management**

**Goal:** Demonstrate how blood is collected, tested, and verified before being issued.

*   **Action:** Navigate to **"Blood Units"** or **"Inventory"**.
*   **Narration:** "Before we can fulfill the request, we need safe blood. Let's simulate processing a donation from our donor, Jane Smith."
*   **Action:** **Add a New Blood Unit**:
    *   **Select Donor:** "Jane Smith"
    *   **Bag ID:** (Enter a unique ID)
    *   **Status:** It starts as **"Test Awaited"**.
*   **Narration:** "When blood is collected, it enters the system as 'Test Awaited'. It cannot be issued yet."
*   **Action:** Navigate to **"Serology Tests"** (or the test section within the Blood Unit).
*   **Narration:** "We must perform mandatory serology tests (HIV, Hepatitis, etc.)."
*   **Action:** Enter **Negative** results for all tests for this unit.
*   **Narration:** "I am recording negative results for all safety tests. Watch what happens to the status."
*   **Action:** Save the results. Show that the Blood Unit status has automatically updated to **"Ready for Issue"**.
*   **Narration:** "The system automatically updates the unit to 'Ready for Issue' only after all tests are cleared. This ensures safety compliance."

---

## **5. Admin: Issuing Blood (Handover)**

**Goal:** Complete the cycle by issuing the tested blood to the patient.

*   **Action:** Go back to **"Blood Requests"** or **"Blood Issue"** module.
*   **Narration:** "Now we have a verified 'A+' unit from Jane, and a request from John."
*   **Action:** Select John Doe's approved request and choose **"Issue Blood"**.
*   **Action:** Select the specific **Blood Unit** (Jane's unit) we just tested.
*   **Narration:** "I am selecting the specific, tested blood bag to be issued to John Doe."
*   **Action:** Confirm the issue (and optionally generate a bill/invoice).
*   **Narration:** "The blood is now officially issued. The inventory is updated, the unit is marked as 'Issued', and the request is 'Fulfilled'. We can also generate a bill or gate pass for the physical handover."

---

## **Conclusion**

*   **Narration:** "That completes the full cycle: from a patient needing help, to a donor registering, and the rigorous admin process of testing and matching that ensures the right blood reaches the right person safely."
