import 'package:mylib/mylib.dart';

import 'auth_field_types.dart';

ControllerMap useFormFieldControllers({required List<EditFormFields> fields}) {
  final editControllers = useRef<ControllerMap?>(null);

  useEffect(() {
    editControllers.value = {
      for (var item in fields) item: TextEditingController()
    };

    return () {
      for (var el in editControllers.value!.entries) {
        el.value.dispose();
      }
    };
  }, []);

  return editControllers.value!;
}

// 이메일 유효성 검사를 위한 정규 표현식
final RegExp emailRegExp = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
);
bool isEmailValid(String email) {
  // 이메일이 정규 표현식과 일치하는지 검사
  return emailRegExp.hasMatch(email);
}

// 비밀번호 유효성 검사를 위한 정규 표현식
final RegExp passwordRegExp = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z]).{6,12}$',
);

isPasswordValid(String password) {
  // 비밀번호가 정규 표현식과 일치하는지 검사
  return passwordRegExp.hasMatch(password);
}
