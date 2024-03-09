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
          isThreeLine: true,
          titleAlignment: ListTileTitleAlignment.center,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.network(
                  height: 52.0,
                  width: 64.0,
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
                ),
              ),
              const Gap(4),
              Text(convertDateTimeToMonthDayString(profile.updated)),
            ],
          ),
          title: Text(profile.name),
          subtitle: Text(
            profile.desc,
            maxLines: 3,
          ),
        ),
      ),
    );
  }
}
