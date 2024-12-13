### 1. Conceptual Overview
- **Roles and Permissions:**

  - **Super Admin:** Manages admin accounts, assigns/removes admin roles, and can access everything.
  - **Admin:** Can perform certain actions on behalf of the super admin but cannot manage other admins.
  - **Client:** Regular users with no admin privileges.
- **Authentication:**

  - Admins,and Super admins are authenticated via Firebase Authentication
  - Users are register anonymously when they first come to the app. It should be mentioned in the privacy policy. 
  - **Roles and permissions** are managed separately in Firestore or Firebase Realtime Database.
- **Key Principle:**

  - **Firebase Authentication** is for **authenticating users**, not for managing roles. Use Firestore to manage user roles and permissions
  
### 2. Archetecture:
  **Step 1: Separate Authentication and Authorization**
  1. Firebase Authentication
    - Use createUserWithEmailAndPassword to create all users (admin, super admin).
    - User anonymous sign in for users. Link the id if they wants to create an account later.  
    - Every user will have a UID in Firebase Auth.
  3. **Firestore for Role Management:**
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
**Step 4: Use Anonymous sign in to register new user**
    - Every time while the app starts check the user type. if new register user anonymously.

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
### 7. Optional Enhancements
1. **Custom Claims**:
    - Use custom claims in Firebase Auth to manage roles at the token level.
    - Example:
      ```
      admin.auth().setCustomUserClaims(uid, { role: 'admin' });
      ```
      
3. **Admin SDK for Automation:**
   - Use Firebase Admin SDK to automate tasks like revoking tokens, deleting accounts, and updating roles.
5. **Notifications:**
    - Notify admins when their role or status is updated using Firebase Cloud Messaging (FCM).6

### 8. User Management
Steps to Check if the User is Already Registered Anonymously  
1. When the app initializes, check if there is already a signed-in user (anonymous or registered). Firebase Authentication stores this information locally, so you can retrieve it even after app restarts (as long as app data hasn't been cleared or the app hasn't been reinstalled).
  ```
    import 'package:firebase_auth/firebase_auth.dart';
    
    void initializeApp() async {
      User? currentUser = FirebaseAuth.instance.currentUser;
    
      if (currentUser == null) {
        // No user is signed in, sign in anonymously
        await signInAnonymously();
      } else {
        // User already signed in (could be anonymous or registered)
        print("User already signed in with UID: ${currentUser.uid}");
      }
    }
    
    Future<void> signInAnonymously() async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
        print("Signed in anonymously with UID: ${userCredential.user?.uid}");
      } catch (e) {
        print("Error signing in anonymously: $e");
      }
    }
  ```
2. Check for Anonymous User
    - If the user is already signed in, check if the account is anonymous using the isAnonymous property of the User object.
        ```
          void checkIfAnonymousUser() {
          User? currentUser = FirebaseAuth.instance.currentUser;
        
          if (currentUser != null && currentUser.isAnonymous) {
            print("User is signed in anonymously with UID: ${currentUser.uid}");
          } else if (currentUser != null) {
            print("User is signed in with a registered account: ${currentUser.uid}");
          } else {
            print("No user is signed in.");
          }
        }

        ```
    - If currentUser exists, use the UID to fetch associated data from Firestore or other services.
      ```
        users: {
        "UID_Anonymous123": {
          "preferences": {...},
          "progress": {...}
        },
        "UID_Registered456": {
          "preferences": {...},
          "progress": {...}
          }
        }
      ```

3. If the user decides to register, you can link their anonymous account to a registered account (email/password, Google, etc.) without creating a new UID:
    ```
    final credential = EmailAuthProvider.credential(email: email, password: password);
    await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);

    ```








  
