import 'package:mylib/mylib.dart';

import 'auth_field_types.dart';
import 'auth_utils.dart';
import '../component/auth_formfield.dart';

class LogInView extends HookWidget {
  const LogInView({super.key, required this.controllers, required this.title});

  final String title;
  final Map<EditFormFields, TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthFormField(
            controller: controllers[EditFormFields.email]!,
            label: '이메일',
            hint: 'abc@example.com',
            validator: (value) {
              if (value case var value? when isEmailValid(value)) return null;

              return 'Invalid email';
            },
            onChanged: (value) {},
          ),
          const Gap(16.0),
          AuthFormField(
            controller: controllers[EditFormFields.password]!,
            label: '비밀번호',
            hint: '영대소문자, 6~12자리',
            obscureText: true,
            validator: (value) {
              if (value case var value? when isPasswordValid(value)) {
                return null;
              }

              return 'Invalid password';
            },
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
