import 'package:app/enums/endpoint.dart';
import 'package:app/models/notification.model.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile(
      {super.key,
      this.isActive = false,
      required this.notificationModel,
      this.onTap});

  final bool isActive;
  final NotificationModel notificationModel;
  final Function()? onTap;

  _buildTrailingIcon() {
    switch (notificationModel.notificationType) {
      case NotificationType.comment:
        return const Icon(Icons.comment);
      case NotificationType.earnPizza:
        return Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(color: Colors.red),
        );
      case NotificationType.pizzaRecap:
        return Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(color: Colors.red),
        );
      default:
        return null;
    }
  }

  _buildLeadingIcon() {
    switch (notificationModel.notificationType) {
      case NotificationType.pizzaRecap:
        return SvgPicture.asset(
          AppIcons.pizza.toAssetPath,
          width: 32,
          height: 32,
        );
      case NotificationType.earnPizza:
        return SvgPicture.asset(
          AppIcons.pizza.toAssetPath,
          width: 32,
          height: 32,
        );
      case NotificationType.earnRainbow:
        return SvgPicture.asset(
          AppIcons.rainbow.toAssetPath,
          width: 32,
          height: 32,
        );
      case NotificationType.rainbowRecap:
        return SvgPicture.asset(
          AppIcons.rainbow.toAssetPath,
          width: 32,
          height: 32,
        );
      case NotificationType.adv:
        return Text(
          "D",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.accentColor,
          ),
        );
      default:
        return const CircleAvatar(
          radius: 16,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: _buildLeadingIcon(),
      title: Text(notificationModel.notificationTitle),
      subtitle: notificationModel.notificationDescription.isNotEmpty
          ? Text(
              notificationModel.notificationDescription,
              softWrap: true,
              maxLines: 1,
            )
          : null,
      trailing: _buildTrailingIcon(),
    );
  }
}
