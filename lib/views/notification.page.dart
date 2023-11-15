import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/business_logic/blocs/user.bloc.dart';
import 'package:app/enums/endpoint.dart';
import 'package:app/models/app_user.model.dart';
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

  final PageController _pageController = PageController();

  _buildMessagePage() {
    return ListView(
      children: const [
        ListTile(
          leading: CircleAvatar(),
          title: Text("lidiagi"),
          subtitle: Text(
              "Ciao, agniendis non poribus, volorae. Con nobitasped quiatem oluptate soloribero"),
        ),
        ListTile(
          leading: CircleAvatar(),
          title: Text("lidiagi"),
          subtitle: Text(
              "Ciao, agniendis non poribus, volorae. Con nobitasped quiatem oluptate soloribero"),
        ),
        ListTile(
          leading: CircleAvatar(),
          title: Text("lidiagi"),
          subtitle: Text(
              "Ciao, agniendis non poribus, volorae. Con nobitasped quiatem oluptate soloribero"),
        ),
      ].expand((element) => [element, const Divider()]).toList(),
    );
  }

  _buildNotificationPage() {
    return ListView(
      children: [
        NotificationTile(
            notificationModel: NotificationModel(
          notificationType: NotificationType.friendshipAccepted,
          notificationTitle:
              "lidiagi ha accettato la tua richiesta di amicizia",
          notificationDescription: "",
        )),
        NotificationTile(
            notificationModel: NotificationModel(
                notificationType: NotificationType.follow,
                notificationTitle: "foxi ti segue, visualizza il suo profilo!",
                notificationDescription: "")),
        NotificationTile(
            notificationModel: NotificationModel(
                notificationType: NotificationType.comment,
                notificationTitle:
                    "carly ha commentato il tuo post: “Bellissima idea!”",
                notificationDescription: "")),
        NotificationTile(
            notificationModel: NotificationModel(
                notificationType: NotificationType.earnPizza,
                notificationTitle: "+1 punto pizza guadagnato!",
                notificationDescription: "")),
        NotificationTile(
            notificationModel: NotificationModel(
                notificationType: NotificationType.pizzaRecap,
                notificationTitle:
                    "ieri hai guadagnato +9 punti pizza, dai il massimo anche oggi!",
                notificationDescription: "")),
        NotificationTile(
            notificationModel: NotificationModel(
                notificationType: NotificationType.earnRainbow,
                notificationTitle: "+1 punto karma guadagnato!",
                notificationDescription: "")),
        NotificationTile(
            notificationModel: NotificationModel(
                notificationType: NotificationType.rainbowRecap,
                notificationTitle:
                    "ieri hai guadagnato +9 punti karma, dai il massimo anche oggi!",
                notificationDescription: "")),
        NotificationTile(
            notificationModel: NotificationModel(
                notificationType: NotificationType.adv,
                notificationTitle:
                    "+5 punti karma extra con l’azione del giorno, eseguila ora!",
                notificationDescription: "")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextButton(
              onPressed: () {
                _pageController.animateToPage(0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn);
              },
              child: const Text("Notifiche"),
            )),
            Expanded(
                child: TextButton(
              onPressed: () {
                _pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn);
              },
              child: const Text("Messaggi"),
            )),
          ],
        ),
        Expanded(
            child: PageView(
          controller: _pageController,
          children: [_buildNotificationPage(), _buildMessagePage()],
        ))
      ],
    );
    return BlocBuilder<UserBloc, AppUser>(
      bloc: context.read<UserBloc>(),
      builder: (context, state) {
        return ListView(
          children: state.notifications.map((e) {
            return NotificationTile(
              notificationModel: e,
              onTap: () {
                switch (e.notificationType) {
                  case NotificationType.friendshipRequest:
                    Keys.masterNavigator.currentState
                        ?.pushNamed(MasterPages.friendshipRequest.toPath);
                    break;
                  case NotificationType.friendshipAccepted:
                    Keys.masterNavigator.currentState
                        ?.pushNamed(MasterPages.friendProfile.toPath);
                    break;
                  default:
                }
              },
              isActive: AppProvider.instance.currentUser.activeNotifications
                      ?.indexWhere((element) => element.id == e.uid) !=
                  -1,
            );
          }).toList(),
        );
      },
    );
  }
}
