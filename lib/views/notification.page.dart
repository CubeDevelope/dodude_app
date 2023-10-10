import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/business_logic/blocs/pages_bloc/notification.bloc.dart';
import 'package:app/models/notification.model.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/router.dart';
import 'package:app/views/widgets/tiles/notification.tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final currentUser = AppProvider.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: BlocBuilder<NotificationCubit, List<NotificationModel>>(
        bloc: AppProvider.instance.notificationCubit,
        builder: (context, state) {
          return ListView(
            children: state
                .map((e) => NotificationTile(
                      notificationModel: e,
                      onTap: () {
                        switch (e.notificationType) {
                          case 0:
                            Keys.masterNavigator.currentState
                                ?.pushNamed(MasterPages.friendshipRequest.toPath);
                            break;
                          case 1:
                            Keys.masterNavigator.currentState
                                ?.pushNamed(MasterPages.friendProfile.toPath);
                            break;
                        }
                      },
                      isActive: AppProvider
                              .instance.currentUser.activeNotifications
                              ?.indexWhere((element) => element.id == e.uid) !=
                          -1,
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
