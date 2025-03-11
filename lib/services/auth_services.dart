import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        print("User canceled Google Sign-In");
        return null; // Handle when user cancels sign-in
      }

      // Obtain the authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      // Refresh user data
      await userCredential.user?.reload();

      return userCredential;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  /// Sign out from both Google and Firebase
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print("Sign Out Error: $e");
    }
  }

  /// Get the currently signed-in user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Check if a user is currently signed in
  bool isUserSignedIn() {
    return _auth.currentUser != null;
  }

  /// Delete user account from Firebase
  Future<bool> deleteUserAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return false;

      await user.delete();
      return true;
    } catch (e) {
      print("Delete User Error: $e");
      return false;
    }
  }
}