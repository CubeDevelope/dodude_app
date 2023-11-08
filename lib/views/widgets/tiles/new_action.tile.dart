import 'package:app/models/action_type.model.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewActionTile extends StatelessWidget {
  final ActionType actionType;
  final Function()? onTap;
  final TextDirection direction;

  const NewActionTile(
      {super.key,
      required this.actionType,
      this.onTap,
      this.direction = TextDirection.ltr});

  @override
  Widget build(BuildContext context) {
    double iconSize = 70;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          child: InkWell(
            onTap: onTap,
            child: Stack(
              children: [
                Container(),
                Positioned(
                  width: constraints.maxWidth - iconSize / 2,
                  bottom: 0,
                  top: 0,
                  left: direction == TextDirection.ltr ? 0 : iconSize / 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Row(
                    textDirection: direction,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          actionType.actionTitle,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      )),
                      Visibility(
                          child: SvgPicture.asset(
                        ActionIcons.fire.toAssetPath,
                        width: iconSize,
                        height: iconSize,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
