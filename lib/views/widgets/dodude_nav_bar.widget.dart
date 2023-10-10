import 'package:app/utils/constants.dart';
import 'package:app/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DodudeNavBar extends StatefulWidget {
  const DodudeNavBar({super.key});

  @override
  State<DodudeNavBar> createState() => _DodudeNavBarState();
}

class _DodudeNavBarState extends State<DodudeNavBar> {
  int currentPage = 0;

  changePage(int pageIndex) {
    if (pageIndex != currentPage) {
      setState(() {
        currentPage = pageIndex;
      });
    }
  }

  getColorOfIcon(int pageIndex) {
    Color color = Colors.transparent;
    if (pageIndex == currentPage) {
      color = AppColors.accentColor;
    }

    return color;
  }

  navigateTo(String pageName) {
    Keys.internalNavigator.currentState?.pushReplacementNamed(pageName);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 150),
                left: (constraints.maxWidth / 5) * currentPage,
                width: constraints.maxWidth / 5,
                height: AppBar().preferredSize.height,
                child: Container(
                  color: AppColors.accentColor,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    navigateTo(PagesEnum.discovery.toPath);
                    setState(() {
                      currentPage = 0;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppIcons.earth.toAssetPath,
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                  ),
                )),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentPage = 1;
                      });
                      navigateTo(PagesEnum.friends.toPath);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AppIcons.friends.toAssetPath,
                        width: 22,
                        color: Colors.white,
                        height: 22,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPage = 0;
                    });
                    navigateTo(PagesEnum.discovery.toPath);
                    Keys.masterNavigator.currentState
                        ?.pushNamed(MasterPages.newAction.toPath);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "D",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: AppColors.accentColor),
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPage = 3;
                    });
                    navigateTo(PagesEnum.notifications.toPath);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppIcons.bell.toAssetPath,
                      width: 22,
                      color: Colors.white,
                      height: 22,
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPage = 4;
                    });
                    navigateTo(PagesEnum.profile.toPath);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.account_circle_outlined,
                    ),
                  ),
                )),
              ]),
            ],
          );
        },
      ),
    );
  }
}
