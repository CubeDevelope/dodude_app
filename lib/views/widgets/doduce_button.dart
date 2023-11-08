import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DodudeButton extends StatelessWidget {
  const DodudeButton({
    super.key,
    this.icon,
    this.onTap,
    this.margin,
    this.process = 0,
    this.hasProcess = false,
    this.title,
  }) : assert(icon != null || (title != null && title != ""));

  final AppIcons? icon;
  final String? title;
  final Function()? onTap;
  final EdgeInsets? margin;
  final int? process;
  final bool hasProcess;

  _buildProcess() {
    List<Widget> progressBar = [];
    for (int i = 0; i < process! + 1; i++) {
      progressBar.add(Container(
        width: 48 / 3,
        margin: const EdgeInsets.all(1),
        height: 10,
        color: Colors.white,
      ));
    }
    return progressBar;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        children: [
          Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Container(
                constraints: const BoxConstraints(minWidth: 54),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (icon != null
                        ? SvgPicture.asset(
                            icon!.toAssetPath,
                            width: 30,
                            color: Colors.white,
                            height: 30,
                          )
                        : Container()),
                    title != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Text(
                              title!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 10,
            width: 54,
            margin: const EdgeInsets.only(top: 4),
            color: hasProcess
                ? Theme.of(context).colorScheme.secondary
                : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _buildProcess(),
            ),
          )
        ],
      ),
    );
  }
}
