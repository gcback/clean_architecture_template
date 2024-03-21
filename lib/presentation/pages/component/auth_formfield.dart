import 'package:mylib/mylib.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    super.key,
    required this.controller,
    this.label = '',
    this.hint = '',
    this.obscureText = false,
    required this.validator,
    required this.onChanged,
    this.helper = '',
  });

  final TextEditingController controller;
  final String label, hint, helper;
  final bool obscureText;
  final String? Function(String? value)? validator;
  final void Function(String)? onChanged;

  static InputDecoration inputDecoration = InputDecoration(
    labelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
    hintStyle: TextStyle(color: Colors.grey.shade400),
    border: const OutlineInputBorder(borderSide: BorderSide(width: 0.35)),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 1.0, color: Colors.red),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 14.0),
      decoration: inputDecoration.copyWith(
        contentPadding: const EdgeInsets.only(
          top: 18.0,
          bottom: 18.0,
          left: 8.0,
          right: 8.0,
        ),
        labelText: label,
        hintText: hint,
        helperText: helper,
        suffixIconConstraints: BoxConstraints.tight(const Size(18.0, 18.0)),
        suffix: GestureDetector(
          onTap: controller.clear,
          child: const Icon(Icons.clear, size: 18.0),
        ),
      ),
      validator: validator,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
    );
  }
}
