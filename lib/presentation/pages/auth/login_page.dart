import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm/presentation/viewmodel/auth/auth_controller.dart';
import 'package:mylib/mylib.dart';

import '../component/action_button.dart';

import 'auth_field_types.dart';
import 'auth_utils.dart';
import 'login_view.dart.bak';

class LogInPage extends HookConsumerWidget {
  const LogInPage({super.key});

  static const title = 'LogIn Page';

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllers = useFormFieldControllers(fields: EditFormFields.login);

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        actions: [
          ActionButton(
            onPressed: () async {
              context.goNamed('signup');
            },
            icon: const Icon(Icons.person_add_alt),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: 12.0.horiInsets,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              Expanded(
                flex: 2,
                child: Form(
                  key: formKey,
                  child:
                      LogInView(controllers: controllers, title: 'LogInView'),
                ),
              ),
              const Gap(24.0),
              Expanded(
                flex: 1,
                child: Center(
                  child: OutlinedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;

                      ref.read(authControllerProvider.notifier).login(
                            controllers.authValue.email,
                            controllers.authValue.password,
                          );
                    },
                    child: const Text('Press'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class LogInPage extends HookConsumerWidget {
//   const LogInPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     Future<void> login() => ref.read(authControllerProvider.notifier).login(
//           'myEmail',
//           'myPassword',
//         );

//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () async {
//                 // context.push('/login/signin');
//                 await const SignInRoute().push(context);
//                 // final willItExplode = await DetailsRoute(id, isNuke: isNuke)
//                 //         .push<bool>(context);
//               },
//               icon: Icons.how_to_reg.widget),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Login Page'),
//             ActionButton(
//               onPressed: login,
//               icon: const Icon(Icons.login),
//               // label: const Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
