import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.red),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned.fill(
              child: Column(
            children: [
              Container(
                height: 150,
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 8,
                            bottom: 8,
                          ),
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                bottomRight: Radius.circular(24),
                              )),
                          child:
                              AppProvider.instance.currentUser.photoUrl != null
                                  ? CachedNetworkImage(
                                      fit: BoxFit.fitHeight,
                                      imageUrl: AppProvider
                                          .instance.currentUser.photoUrl!,
                                    )
                                  : null,
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.pizza.toAssetPath,
                                  ),
                                  const Text('0'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.rainbow.toAssetPath,
                                  ),
                                  const Text('0'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.handshake.toAssetPath,
                                  ),
                                  const Text('0'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  AppProvider.instance.authCubit.logout();
                                },
                                icon: SvgPicture.asset(
                                  AppIcons.settings.toAssetPath,
                                  color: AppColors.accentColor,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                    Text(
                      AppProvider.instance.currentUser.username!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const Text(""),
                    Container(),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    currentPage = 0;
                                  });
                                  _pageController.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut);
                                },
                                icon: SvgPicture.asset(
                                  currentPage == 0
                                      ? AppIcons.gridSelected.toAssetPath
                                      : AppIcons.gridUnselected.toAssetPath,
                                  width: 24,
                                  color: AppColors.accentColor,
                                  height: 24,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    currentPage = 1;
                                  });
                                  _pageController.animateToPage(1,
                                      duration:
                                          const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut);
                                },
                                icon: SvgPicture.asset(
                                  currentPage == 1
                                      ? AppIcons.pinSelected.toAssetPath
                                      : AppIcons.pinUnselected.toAssetPath,
                                  width: 24,
                                  color: AppColors.accentColor,
                                  height: 24,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    currentPage = 2;
                                  });
                                  _pageController.animateToPage(2,
                                      duration:
                                          const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut);
                                },
                                icon: SvgPicture.asset(
                                  currentPage == 2
                                      ? AppIcons.tagSelected.toAssetPath
                                      : AppIcons.tagUnselected.toAssetPath,
                                  width: 24,
                                  color: AppColors.accentColor,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                              child: PageView(
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            children: [
                              ,
                              Container(
                                decoration:
                                    const BoxDecoration(color: Colors.green),
                              ),
                              Container(
                                decoration:
                                    const BoxDecoration(color: Colors.blue),
                              ),
                            ],
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              )),
            ],
          )),
        ],
      ),
    );
  }
}
