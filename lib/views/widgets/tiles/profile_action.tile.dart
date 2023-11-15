import 'package:app/models/completed_action.model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProfileActionTile extends StatelessWidget {
  const ProfileActionTile({
    super.key,
    required this.action,
    this.crossAxisCellCount = 2,
    this.mainAxisCellCount = 2,
  });

  final CompletedAction action;
  final int crossAxisCellCount;
  final num mainAxisCellCount;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: crossAxisCellCount,
      mainAxisCellCount: mainAxisCellCount,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: CachedNetworkImage(
                filterQuality: FilterQuality.none,
                errorWidget: (context, url, error) {
                  return const SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_amber,
                          size: 32,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text("Immagine non trovata")
                      ],
                    ),
                  );
                },
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                imageUrl: action.actionImage,
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              action.actionTitle,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
