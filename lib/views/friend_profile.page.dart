import 'dart:math';

import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/models/completed_action.model.dart';
import 'package:app/models/user.model.dart';
import 'package:app/utils/constants.dart';
import 'package:app/views/personal_profile.page.dart';
import 'package:app/views/widgets/tiles/profile_action.tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FriendProfilePage extends StatefulWidget {
  const FriendProfilePage({
    super.key,
    required this.friendRef,
  });

  final DocumentReference friendRef;

  @override
  State<FriendProfilePage> createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  UserModel? friend;
  List<CompletedAction> actions = [];

  bool isLoading = true;

  final Random random = Random();

  _buildPage() {
    if (friend == null) {
      if (isLoading) {
        return [
          const Center(
            child: CircularProgressIndicator(),
          )
        ];
      } else {
        return [
          const Center(
            child: Text("Questo account non esiste più"),
          )
        ];
      }
    }

    return [
      CachedNetworkImage(
        fit: BoxFit.cover,
        filterQuality: FilterQuality.low,
        height: 200,
        imageUrl:
            "https://images.unsplash.com/photo-1682687982360-3fbab65f9d50?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ),
      Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipPath(
                      clipper: ProfileImageClipper(),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.none,
                        imageUrl: friend!.photoUrl ?? "",
                        errorWidget: (context, url, error) {
                          return const Center(
                            child: Icon(
                              Icons.person_4,
                              size: 44,
                            ),
                          );
                        },
                        placeholder: (context, url) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  )),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SvgPicture.asset(
                          AppIcons.pizza.toAssetPath,
                        ),
                      ),
                      const Text(
                        "100",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SvgPicture.asset(
                          AppIcons.rainbow.toAssetPath,
                        ),
                      ),
                      const Text(
                        "300",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SvgPicture.asset(
                          AppIcons.handshake.toAssetPath,
                        ),
                      ),
                      Text(
                        friend?.friends?.length.toString() ?? "0",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  friend?.username ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              Text(friend?.bio ?? ""),
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: SvgPicture.asset(
                        AppIcons.gridUnselected.toAssetPath,
                        color: Theme.of(context).colorScheme.primary,
                        height: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AppIcons.tagUnselected.toAssetPath,
                        color: Theme.of(context).colorScheme.primary,
                        height: 24,
                      ),
                    ),
                  ),
                ],
              ),
              StaggeredGrid.count(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                axisDirection: AxisDirection.down,
                children: actions
                    .map(
                      (e) => ProfileActionTile(
                        action: e,
                        mainAxisCellCount: 3,
                      ),
                    )
                    .toList(),
              )
            ],
          )),
    ];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppProvider.instance.firestoreManager
          .getFriendActions(widget.friendRef)
          .then((value) {
        setState(() {
          actions = value;
        });
      });

      AppProvider.instance.firestoreManager
          .getFriendProfile(friendRef: widget.friendRef)
          .then((value) {
        setState(() {
          isLoading = false;
          friend = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: _buildPage(),
      ),
    );
  }
}
