import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    // and get a GoogleSignInAccount
    final googleUser = await GoogleSignIn(scopes: scopes).signIn();

    // Obtain the auth details( GoogleSignInAuthentication? ) from the request
    final googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await auth.signInWithCredential(credential);
  } catch (e) {
    print(e.toString());
  }
  return null;
}
