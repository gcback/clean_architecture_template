part of 'auth.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

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

    throw UnauthorizedException('Cannot create an account: $message');
  }
}

Future<UserCredential> signinWithEmail(String email, String password) async {
  try {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  } catch (e) {
    throw UnauthorizedException('Cannot create an account: ${e.toString()}}');
  }
}
