import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylib/mylib.dart';

import '../common/utils.dart';
import '../domain/user.dart';

class UserDetail extends HookConsumerWidget {
  const UserDetail(this.user, {super.key});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updated = useState(false);

    return PopScope(
      /// 보통은 true로 하고 pop전에 확인할 사항이 있을때 false로 하면 중간 단계를 거치게 한다.
      ///    : 변동 사항이 있어서 확인이 필요하면 여기에 false를 변동이 없어 그냥 pop을 하려면 true로 한다.
      canPop: updated.value ? false : true,
      onPopInvoked: (didPop) {
        onPopInvoked(context, ref, didPop);
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(user.name, style: const TextStyle(fontSize: 14.0)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 4,
                  child: Image.network(
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    'http://spsms.dyndns.org:3100/images/${getStringBeforeFirstDigit(user.pic)}/${user.pic}',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: updated.value,
                        onChanged: (value) => updated.value = value!),
                    const Text('수정됨'),
                  ],
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: 16.0.allInsets,
                    child: Text(user.desc),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPopInvoked(BuildContext context, WidgetRef ref, bool didPop) async {
// popup dialog를 닫고난 후 결과를 확인해서 실제 Navigator.of(context).pop할지 최종 결정한다.
    // 즉, false 였으면 pop이 발생하지 않으며, true면 pop(이전 화면으로 돌아간다.)
    if (didPop) {
      return;
    }
    final NavigatorState navigator = Navigator.of(context);
    final bool? shouldPop = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('저장할까요?'),
            content: const Text(
              'A dialog is a type of modal window that\n'
              'appears in front of app content to\n'
              'provide critical information, or prompt\n'
              'for a decision to be made.',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('취소'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('저장'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });

    if (shouldPop ?? false) {
      if (navigator.canPop()) {
        navigator.pop();
      } else {
        navigator.pop();
      }
    }
  }
}
