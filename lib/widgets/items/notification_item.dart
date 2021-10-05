import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_show_more/flutter_show_more.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/modules/shared/notification_tab/modes/notifications.dart';

class NotificationItem extends StatelessWidget {
  final int index;
  final ConfirmDismissCallback? confirmDismiss;
  final DismissDirectionCallback? onDismissed;
  final NotificationModel notification;
  const NotificationItem({
    Key? key,
    required this.index,
    this.confirmDismiss,
    this.onDismissed,
    required this.notification,
  })  : assert(index >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.09,
      width: size.width * 0.95,
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      child: Container(
        height: size.height * 0.09,
        width: size.width * 0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0.2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            dense: false,
            title: Text(
              notification.title,
              style: const TextStyle(
                color: AppColors.lightBlack,
                fontSize: 11,
              ),
            ),
            subtitle: ShowMoreText(
              notification.data,
              maxLength: 30,
              showMoreText: '',
              style: const TextStyle(
                color: AppColors.darkBlue,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),

            // trailing:  Text(
            //   '${notification!.createdAt!.day}-${notification!.createdAt!.month}-${notification!.createdAt!.year}',
            //   style: const TextStyle(
            //     color: AppColors.darkGreen,
            //     fontSize: 8,
            //     fontWeight: FontWeight.bold,
            //   ),
            // )
          ),
        ),
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyeshDarkGreen,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
