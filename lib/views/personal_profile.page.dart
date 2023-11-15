import 'dart:math';

import 'package:app/business_logic/blocs/user.bloc.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/router.dart';
import 'package:app/views/widgets/tiles/profile_action.tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentPage = 0;

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    final state = context.read<UserBloc>().state;
    final user = state.user;

    return ListView(
      children: [
        CachedNetworkImage(
          fit: BoxFit.cover,
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
                          imageUrl: user!.photoUrl ?? "",
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
                              child: Icon(
                                Icons.person_2,
                                size: 44,
                              ),
                            );
                          },
                        ),
                      ),
                    )),
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        Keys.masterNavigator.currentState
                            ?.pushNamed(MasterPages.market.toPath);
                      },
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
                      ),
                    )),
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        Keys.masterNavigator.currentState
                            ?.pushNamed(MasterPages.market.toPath);
                      },
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
                            "100",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                    Expanded(
                        child: TextButton(
                      onPressed: () {},
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
                            context
                                    .read<UserBloc>()
                                    .state
                                    .user!
                                    .friends
                                    ?.length
                                    .toString() ??
                                "0",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                    IconButton(
                      onPressed: () {
                        Keys.masterNavigator.currentState
                            ?.pushNamed(MasterPages.settings.toPath);
                      },
                      icon: SvgPicture.asset(
                        AppIcons.settings.toAssetPath,
                        width: 24,
                        height: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ],
                ),
                Text(
                  user.username ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const Text(""),
              ],
            )),
        Row(
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    currentPage = 0;
                  });
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
                onPressed: () {
                  setState(() {
                    currentPage = 1;
                  });
                },
                icon: SvgPicture.asset(
                  AppIcons.pinUnselected.toAssetPath,
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
          mainAxisSpacing: 16,
          children: state.actions
              .map(
                (e) => ProfileActionTile(
                  action: e,
                  mainAxisCellCount: 3,
                ),
              )
              .toList(),
        )
      ],
    );
  }
}

/* StaggeredGrid.count(
                          crossAxisCount: 4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          children: [
                            StaggeredGridTile.count(
                              crossAxisCellCount: 2,
                              mainAxisCellCount: 3,
                              child: Container(
                                width: 200,
                                height: 300,
                                color: Colors.red,
                              ),
                            ),
                            StaggeredGridTile.count(
                              crossAxisCellCount: 2,
                              mainAxisCellCount: 1,
                              child: Container(
                                width: 200,
                                height: 100,
                                color: Colors.blue,
                              ),
                            ),
                            StaggeredGridTile.count(
                              crossAxisCellCount: 2,
                              mainAxisCellCount: 3,
                              child: Container(
                                width: 200,
                                height: 100,
                                color: Colors.green,
                              ),
                            ),
                            StaggeredGridTile.count(
                              crossAxisCellCount: 2,
                              mainAxisCellCount: 3,
                              child: Container(
                                width: 200,
                                height: 100,
                                color: Colors.green,
                              ),
                            ),
                            StaggeredGridTile.count(
                              crossAxisCellCount: 2,
                              mainAxisCellCount: 2,
                              child: Container(
                                width: 200,
                                height: 100,
                                color: Colors.green,
                              ),
                            ),
                            StaggeredGridTile.count(
                              crossAxisCellCount: 2,
                              mainAxisCellCount: 3,
                              child: Container(
                                width: 200,
                                height: 100,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        )*/

class ProfileImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height - 16);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 16, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 32);
    path.quadraticBezierTo(0, 0, 32, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
