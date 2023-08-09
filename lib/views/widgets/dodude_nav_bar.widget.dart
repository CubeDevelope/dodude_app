import 'package:app/utils/constants.dart';
import 'package:app/utils/router.dart';
import 'package:app/views/widgets/painters/hexagon_painter.dart';
import 'package:flutter/material.dart';

class DodudeNavBar extends StatefulWidget {
  const DodudeNavBar({super.key});

  @override
  State<DodudeNavBar> createState() => _DodudeNavBarState();
}

class _DodudeNavBarState extends State<DodudeNavBar> {
  int currentPage = 0;

  List<IconData?> icons = [
    Icons.public,
    Icons.groups_2_outlined,
    null,
    Icons.notifications_none,
    Icons.account_circle_outlined
  ];

  changePage(int pageIndex) {
    if (pageIndex != currentPage) {
      setState(() {
        currentPage = pageIndex;
      });
    }
  }

  getColorOfIcon(int pageIndex) {
    Color color = Colors.white;
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
      height: AppBar().preferredSize.height * 1.3,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: AppBar().preferredSize.height,
            child: Material(
              child: Row(
                children: icons.map((e) {
                  if (e == null) {
                    return const Spacer();
                  }

                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        navigateTo(PagesEnum.values[icons.indexOf(e)].toPath);
                        changePage(icons.indexOf(e));
                      },
                      child: Center(
                        child: Icon(
                          e,
                          color: getColorOfIcon(icons.indexOf(e)),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  shape: const HexagonPainter(factorScale: 1.15),
                  backgroundColor:
                      currentPage == 2 ? AppColors.accentColor : Colors.white,
                  child: const Icon(Icons.local_fire_department_outlined),
                  onPressed: () {
                    navigateTo(PagesEnum.values[2].toPath);
                    changePage(2);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
