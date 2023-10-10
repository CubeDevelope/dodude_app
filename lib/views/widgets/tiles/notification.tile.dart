import 'package:app/models/notification.model.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile(
      {super.key, this.isActive = false, this.notificationModel, this.onTap});

  final bool isActive;
  final NotificationModel? notificationModel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(Icons.notifications),
      title: Text(notificationModel!.notificationTitle),
      subtitle: Text(
        notificationModel!.notificationDescription,
        softWrap: true,
        maxLines: 1,
      ),
      trailing: isActive
          ? Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
            )
          : null,
    );
  }
}
