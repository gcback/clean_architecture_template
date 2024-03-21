import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth.dart';
import 'auth_storage.dart';
import 'auth_storage_shared_preference.dart';

part 'auth_controller.g.dart';

/// A mock of an Authenticated User
final _dummyUser = Auth.signedIn(
  id: -1,
  displayName: '으라차차',
  email: 'gcback@gmail.com',
  token: 'some-updated-secret-auth-token',
);

////////
abstract class AuthIface {
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> signup(String email, String password);
}

@riverpod
class AuthController extends _$AuthController implements AuthIface {
  static const _sharedPrefsKey = 'token';
  late AuthPersistance _persistance;

  @override
  Future<Auth> build() async {
    _persistance =
        await ref.watch(sharedPreferencePersistanceProvider.notifier);

    _persistenceRefreshLogic();

    return _loginRecoveryAttempt();
  }

  void _persistenceRefreshLogic() {
    ref.listenSelf((_, next) {
      if (next.isLoading) return;
      if (next.hasError) {
        _persistance.remove(_sharedPrefsKey);
        return;
      }

      next.requireValue.map<void>(
        signedIn: (signedIn) =>
            _persistance.set(_sharedPrefsKey, signedIn.token),
        signedOut: (signedOut) {
          _persistance.remove(_sharedPrefsKey);
        },
      );
    });
  }

  Future<Auth> _loginRecoveryAttempt() {
    try {
      if (_persistance.get(_sharedPrefsKey) case var savedToken?) {
        return _loginWithToken(savedToken);
      }

      throw const UnauthorizedException('No auth token found');
    } catch (_, __) {
      _persistance.remove(_sharedPrefsKey).ignore();

      return Future.value(Auth.signedOut());
    }
  }

  Future<Auth> _loginWithToken(String token) async {
    final logInAttempt = await Future.delayed(
      networkRoundTripTime,
      () => true, // edit this if you wanna play around
    );

    if (logInAttempt) return _dummyUser;

    throw const UnauthorizedException('401 Unauthorized or something');
  }

  ///
  ///
  @override
  Future<void> login(String email, String password) async {
    try {
      final userCredential = await signinWithEmail(email, password);

      if (userCredential.user case var user?) {
        state = AsyncData(
          Auth.signedIn(
            id: user.hashCode,
            email: user.email ?? '',
            token: (await user.getIdToken()) ?? '',
            displayName: user.displayName ?? '',
          ),
        );
      }
    } catch (e) {
      print('cannot create an User > email:$email, password:$password');
    }
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(networkRoundTripTime);

    state = AsyncData(Auth.signedOut());
  }

  @override
  Future<void> signup(String email, String password) async {
    final userCredential = await signupWithEmail(email, password);

    if (userCredential?.user case var user?) {
      state = AsyncData(
        Auth.signedIn(
          id: user.hashCode,
          email: user.email ?? '',
          token: (await user.getIdToken()) ?? '',
          displayName: user.displayName ?? '',
        ),
      );
    }
  }
}
