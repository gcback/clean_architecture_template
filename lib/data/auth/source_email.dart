import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> signupWithEmail(String email, String password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  } on FirebaseAuthException catch (e) {
    final message = switch (e.code) {
      == 'weak-password' => 'The password provided is too weak.',
      == 'email-already-in-use' =>
        'The account[ ${e.email} ] already exists for that email.',
      _ => '',
    };

    print(message);

    return null;
  } catch (e) {
    print(e);
    return null;
  }
}
