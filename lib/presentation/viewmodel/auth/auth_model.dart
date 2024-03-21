part of 'auth.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

abstract interface class Auth {
  factory Auth.signedIn({
    required int id,
    required String displayName,
    required String email,
    required String token,
  }) =>
      SignedIn(
        id: id,
        displayName: displayName,
        email: email,
        token: token,
      );
  factory Auth.signedOut() => SignedOut();

  bool get isAuth;

  TResult map<TResult extends Object?>({
    required TResult Function(SignedIn value) signedIn,
    required TResult Function(SignedOut value) signedOut,
  });
}

class SignedIn implements Auth {
  final int id;
  final String displayName;
  final String email;
  final String token;

  SignedIn(
      {required this.id,
      required this.displayName,
      required this.email,
      required this.token});

  @override
  bool get isAuth => true;

  @override
  TResult map<TResult extends Object?>({
    required TResult Function(SignedIn value) signedIn,
    required TResult Function(SignedOut value) signedOut,
  }) =>
      signedIn(this);
}

class SignedOut implements Auth {
  @override
  bool get isAuth => false;

  @override
  TResult map<TResult extends Object?>({
    required TResult Function(SignedIn value) signedIn,
    required TResult Function(SignedOut value) signedOut,
  }) =>
      signedOut(this);
}

/// Simple mock of a 401 exception
class UnauthorizedException implements Exception {
  const UnauthorizedException(this.message);
  final String message;
}

/// Mock of the duration of a network request
final networkRoundTripTime = 2.secs;
