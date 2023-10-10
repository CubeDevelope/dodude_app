import 'package:app/models/action_type.model.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';

class NewActionTile extends StatelessWidget {
  final ActionType actionType;
  final Function()? onTap;

  const NewActionTile({super.key, required this.actionType, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            height: 100,
            width: double.maxFinite,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.accentColor),
              borderRadius: BorderRadius.circular(16),
              color: Colors.black26,
            ),
            child: Text(
              actionType.actionTitle,
              maxLines: 3,
              softWrap: true,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
