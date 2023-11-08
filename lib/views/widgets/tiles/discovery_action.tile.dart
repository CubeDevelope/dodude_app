import 'dart:ui';

import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/models/completed_action.model.dart';
import 'package:app/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiscoveryActionTile extends StatefulWidget {
  const DiscoveryActionTile(
      {super.key, required this.completedAction, this.onVoted});

  final CompletedAction completedAction;
  final Function(bool vote)? onVoted;

  @override
  State<DiscoveryActionTile> createState() => _DiscoveryActionTileState();
}

class _DiscoveryActionTileState extends State<DiscoveryActionTile> {
  bool isReadingDescription = false;

  bool isPositiveVoted = false;
  bool isNegativeVoted = false;

  int totalVotes = 0;
  late CompletedAction action;

  @override
  void initState() {
    action = widget.completedAction;
    super.initState();
  }

  int _getMaxVotedState() {
    int positiveLength = (action.angelsPositive?.length ?? 0);
    int negativeLength = (action.angelsNegative?.length ?? 0);

    if (positiveLength == negativeLength) return 0;
    if (positiveLength < negativeLength) return -1;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    isPositiveVoted = action.angelsPositive
            ?.contains(AppProvider.instance.userDocReference) ??
        false;
    isNegativeVoted = action.angelsNegative
            ?.contains(AppProvider.instance.userDocReference) ??
        false;

    totalVotes = (action.angelsPositive?.length ?? 0) +
        (action.angelsNegative?.length ?? 0);

    if (totalVotes == 0) totalVotes = 1;

    if (!isPositiveVoted && !isNegativeVoted) {
      AppProvider.instance.firestoreManager
          .getCompletedActionSnapshot(widget.completedAction)
          .listen((event) {
        final updateAction = CompletedAction.fromDocument(event);

        if ((action.angelsPositive?.length) !=
                updateAction.angelsPositive?.length ||
            (action.angelsNegative?.length) !=
                updateAction.angelsNegative?.length) {
          setState(() {
            action = updateAction;
          });
        }
      });
    }

    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
                sigmaX: 20, sigmaY: 20, tileMode: TileMode.mirror),
            child: CachedNetworkImage(
              imageUrl: widget.completedAction.creatorImage,
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.fill,
              filterQuality: FilterQuality.low,
              errorWidget: (context, url, error) {
                return Container(
                  alignment: Alignment.center,
                  child: const Text("Errore nel download dell'immagine"),
                );
              },
              progressIndicatorBuilder: (context, url, progress) {
                return Container();
              },
            ),
          ),
        ),
        Positioned.fill(
            child: CachedNetworkImage(
          imageUrl: widget.completedAction.creatorImage,
          width: double.maxFinite,
          height: double.maxFinite,
          filterQuality: FilterQuality.low,
          fit: BoxFit.fitWidth,
          errorWidget: (context, url, error) {
            return Container(
              alignment: Alignment.center,
              child: const Text("Errore nel download dell'immagine"),
            );
          },
          progressIndicatorBuilder: (context, url, progress) {
            return Container();
          },
        )),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          top: 0,
          left: 0,
          right: 0,
          height: isReadingDescription
              ? MediaQuery.of(context).size.height * .4
              : MediaQuery.of(context).size.height * .3,
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.transparent,
              Colors.black,
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
        ),
        Positioned(
          top: 24,
          left: 8,
          right: 0,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.only(bottom: 8),
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.red,
                            border: Border.all(width: 2, color: Colors.white)),
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.add,
                            size: 10.0,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AppIcons.chat.toAssetPath,
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AppIcons.pin.toAssetPath,
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AppIcons.send.toAssetPath,
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AppIcons.settings.toAssetPath,
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(widget.completedAction.creatorUsername,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white)),
                        Text(
                          widget.completedAction.actionDescription,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ]
                          .expand<Widget>((element) => [
                                element,
                                const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4))
                              ])
                          .toList(),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
        Positioned(
            left: 50,
            right: 50,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(isPositiveVoted ? 16 : 8),
                    gradient: LinearGradient(
                      colors: [Colors.black.withAlpha(100), Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: isPositiveVoted || isNegativeVoted,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "${((action.angelsPositive?.length ?? 0) * 100 / totalVotes).ceil()}%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,

                                fontSize: _getMaxVotedState() == 1 ? 29 : 20),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        /*color: isPositiveVoted
                            ? AppColors.accentColor
                            : Theme.of(context).scaffoldBackgroundColor,*/
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            if (!isPositiveVoted && !isNegativeVoted) {
                              widget.onVoted?.call(true);
                            }
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 250),
                            width: _getMaxVotedState() == 1 &&
                                    (isPositiveVoted || isNegativeVoted)
                                ? 60 * 1.5
                                : 60,
                            height: _getMaxVotedState() == 1 &&
                                    (isPositiveVoted || isNegativeVoted)
                                ? 60 * 1.5
                                : 60,
                            decoration: BoxDecoration(
                                border: Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(16)),
                            child: Text(
                              "👌",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: _getMaxVotedState() == 1 &&
                                          (isPositiveVoted || isNegativeVoted)
                                      ? 40
                                      : 25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(isNegativeVoted ? 16 : 8),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withAlpha(100),
                          Colors.transparent
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                      )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: isPositiveVoted || isNegativeVoted,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "${((action.angelsNegative?.length ?? 0) * 100 / totalVotes).ceil()}%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: _getMaxVotedState() == -1 ? 29 : 20),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        /*color: isNegativeVoted
                            ? AppColors.accentColor
                            : Theme.of(context).scaffoldBackgroundColor,*/
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            if (!isPositiveVoted && !isNegativeVoted) {
                              widget.onVoted?.call(false);
                            }
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 250),
                            width: _getMaxVotedState() == -1 &&
                                    (isPositiveVoted || isNegativeVoted)
                                ? 60 * 1.5
                                : 60,
                            height: _getMaxVotedState() == -1 &&
                                    (isPositiveVoted || isNegativeVoted)
                                ? 60 * 1.5
                                : 60,
                            decoration: BoxDecoration(
                                border: Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(16)),
                            child: Text(
                              "🤌",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: _getMaxVotedState() == -1 &&
                                          (isPositiveVoted || isNegativeVoted)
                                      ? 40
                                      : 25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
