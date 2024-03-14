part of '../component.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.profile});

  final User profile;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: (12.0, 4.0).insets,
      child: InkWell(
        onTap: () {
          context.go('/users/detail', extra: profile);
        },
        child: ListTile(
          title: Text(profile.name),
          subtitle: Text(profile.desc, maxLines: 3),
          isThreeLine: true,
          titleAlignment: ListTileTitleAlignment.center,
          minVerticalPadding: 0.0,
          contentPadding: EdgeInsets.zero,
          leading: SizedBox(
            width: 80.0,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  height: 52.0,
                  fit: BoxFit.cover,
                  'http://spsms.dyndns.org:3100/images/${getStringBeforeFirstDigit(profile.pic)}/${profile.pic}',
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;

                    // final ratio = loadingProgress.expectedTotalBytes != null
                    //     ? loadingProgress.cumulativeBytesLoaded /
                    //         loadingProgress.expectedTotalBytes!
                    //     : 0.0;

                    return SizedBox.square(
                      dimension: 24.0,
                      child: buildRefrechIndicator(),
                    );
                  },
                ), //.measured(outlined: true),
                AlignPositioned(
                  alignment: Alignment.bottomRight,
                  dx: -4.0,
                  dy: -4.0,
                  child: Container(
                      padding: 4.0.allInsets,
                      decoration: const BoxDecoration(
                        // border: Border.all(color: Colors.red, width: 2.5),
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child:
                          Text(profile.no.toString(), style: 10.0.sizedFont)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
