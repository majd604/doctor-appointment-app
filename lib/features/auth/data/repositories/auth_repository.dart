import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //login method
  Future<UserCredential> login({required String email, required String password}) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  //register method
  Future<UserCredential> register({required String email, required String password, required String fullName}) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({'fullName': fullName, 'email': email});

    //send email verification
    await userCredential.user!.sendEmailVerification();
    return userCredential;
  }

  //logout method
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  //forget password method
  Future<void> forgotPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //google sign in method
  Future<UserCredential> signInWithGoogle() async {
    await _googleSignIn.signOut(); // Ensure previous sessions are cleared
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception('Google sign in was cancelled');
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);

    final User? user = userCredential.user;

    if (user == null) {
      throw Exception('Google sign in failed');
    }

    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      await userDoc.set({
        'fullName': user.displayName ?? '',
        'email': user.email ?? '',
        'imageUrl': user.photoURL ?? '',
        'publicId': '',
      });
    }

    return userCredential;
  }
}
