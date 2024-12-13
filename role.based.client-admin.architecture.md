### 1. Conceptual Overview
- **Roles and Permissions:**

  - **Super Admin:** Manages admin accounts, assigns/removes admin roles, and can access everything.
  - **Admin:** Can perform certain actions on behalf of the super admin but cannot manage other admins.
  - **Client:** Regular users with no admin privileges.
- **Authentication:**

  - All users (clients, admins, super admins) are authenticated via Firebase Authentication.
  - **Roles and permissions** are managed separately in Firestore or Firebase Realtime Database.
- **Key Principle:**

  - **Firebase Authentication** is for **authenticating users**, not for managing roles. Use Firestore to manage user roles and permissions
  
### 2. Archetecture:
  **Step 1: Separate Authentication and Authorization**
  1. Firebase Authentication
    - Use createUserWithEmailAndPassword to create all users (admin, super admin).
    - Every user will have a UID in Firebase Auth.
  2. **Firestore for Role Management:**
      - Store roles and permissions in Firestore. For example:
        ```
        users: {
          "uid123": {
            "email": "admin@example.com",
            "role": "admin",
            "createdBy": "superAdminUid123",
            "status": "active"  // Or "inactive" for revoked accounts
          }
        }
        ```
      - Super Admins can modify the role and status fields for any user.

**Step 2: Role-Based Access Control (RBAC)**
  - Use Firestore Security Rules to enforce access control based on roles and permissions
    ```
      rules_version = '2';
      service cloud.firestore {
        match /databases/{database}/documents {
          match /users/{userId} {
            // Allow users to read/write their own data
            allow read, write: if request.auth.uid == userId;
          }
          match /adminData/{docId} {
            // Only allow admins and super admins to access admin-specific data
            allow read, write: if request.auth.token.role in ['admin', 'super_admin'];
          }
          match /superAdminData/{docId} {
            // Only allow super admins to access super admin data
            allow read, write: if request.auth.token.role == 'super_admin';
          }
        }
      }

    ```

**Step 3: Revoking Access**
  - Instead of deleting a user from Firebase Authentication, mark their status as inactive in Firestore:
    ```
      {
      "uid123": {
        "email": "admin@example.com",
        "role": "admin",
        "status": "inactive"
        }
      }
  
    ```
  - Prevent login for inactive users by adding a custom claim or checking their status during sign-in.

### 3. **Flow**
**Step 1: Super Admin Adds Admin**
  1. Super Admin adds the admin's email and details to Firestore.
  2. Call createUserWithEmailAndPassword in Firebase Auth to create the account.
  3. Add the user's uid and role (admin) to Firestore.
     
**Step 2:Admin Logs In**
  1. The admin logs in with their email and password using Firebase Auth.
  2. After successful login, check their role and status in Firestore:
      - If status is "inactive", log them out immediately.
      - If status is "active", allow access.
     
**Step 3: Revoking Admin Access**
  1. The Super Admin updates the status field in Firestore to "inactive" for the admin.
  2. Use **Firebase Functions** to:
      - Update custom claims for the user if needed (e.g., remove the admin role).
      - Force token refresh to revoke their current session(javascript):
      ```
      admin.auth().revokeRefreshTokens(uid);
      ```


**Step 4: Removing an Admin (Optional)**
  - Remove the user from Firebase Auth if required(javascript)
    ```
    admin.auth().deleteUser(uid);
    ```
  - This action should only be taken when you are sure the user account is no longer needed
### 4. Example Firestore Data Structure
```
{
  "users": {
    "uid123": {
      "email": "superadmin@example.com",
      "role": "super_admin",
      "status": "active"
    },
    "uid456": {
      "email": "admin@example.com",
      "role": "admin",
      "createdBy": "uid123",
      "status": "active"
    },
    "uid789": {
      "email": "client@example.com",
      "role": "client",
      "status": "active"
    }
  }
}

```
### 1. Optional Enhancements
1. **Custom Claims**:
    - Use custom claims in Firebase Auth to manage roles at the token level.
    - Example:
      ```
      admin.auth().setCustomUserClaims(uid, { role: 'admin' });
      ```
      
3. **Admin SDK for Automation:**
   - Use Firebase Admin SDK to automate tasks like revoking tokens, deleting accounts, and updating roles.
5. **Notifications:**
    - Notify admins when their role or status is updated using Firebase Cloud Messaging (FCM).








  
