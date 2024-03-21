import 'package:mylib/mylib.dart';

enum EditFormFields {
  email,
  password,
  confirm;

  static get signup => const <EditFormFields>[email, password, confirm];
  static get login => const <EditFormFields>[email, password];
}

typedef ControllerMap = Map<EditFormFields, TextEditingController>;
typedef AuthInput = ({String email, String password});

extension ControllerMapExts on ControllerMap {
  AuthInput get authValue => (
        email: this[EditFormFields.email]!.text,
        password: this[EditFormFields.password]!.text,
      );
      
  get empty => const (email: '', password: '');
}
