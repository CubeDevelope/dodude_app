import 'dart:io';

import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/enums/endpoint.dart';
import 'package:app/models/completed_action.model.dart';
import 'package:app/views/widgets/doduce_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateActionPage extends StatefulWidget {
  const CreateActionPage({super.key});

  @override
  State<CreateActionPage> createState() => _CreateActionPageState();
}

class _CreateActionPageState extends State<CreateActionPage> {
  File? uploadedImage;

  final imagePicker = ImagePicker();

  _buildPageForPickImage() {
    return Column(
      children: [
        Expanded(child: Container()),
        FloatingActionButton(
          mini: true,
          onPressed: () async {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return CupertinoActionSheet(
                  title: const Text("Pick your source"),
                  message: const Text("Decidi da dove caricare l'immagine"),
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () {},
                    child: const Text("Cancella"),
                  ),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () async {
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.camera);

                        setState(() {
                          uploadedImage = File(file!.path);
                        });
                      },
                      child: const Text(
                        "Camera",
                      ),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () async {
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          uploadedImage = File(file!.path);
                        });
                      },
                      child: const Text(
                        "Galleria",
                      ),
                    ),
                  ],
                );
              },
            );

            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 50,
          child: Text(
              AppProvider.instance.actionCubit.actionTypeSelected!.actionTitle),
        )
      ],
    );
  }

  _buildPageForUploadImage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DodudeButton(
              title: "Pubblica",
              onTap: () {
                CompletedAction action = CompletedAction();
                action.createdBy = AppProvider.instance.userDocReference;
                action.action = AppProvider.instance.firestoreRepository
                    .getDocumentReference(
                  AppProvider.instance.actionCubit.actionTypeSelected!.uid,
                  collectionsEndpoint: FirestoreCollectionsNames.actionType,
                );
                action.createdAt = Timestamp.now();
                AppProvider.instance.actionCubit
                    .loadImageInStorage(uploadedImage!);
              },
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ],
        ),
        Expanded(
            child: uploadedImage != null
                ? Image.file(uploadedImage!)
                : Container()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: uploadedImage == null
              ? _buildPageForPickImage()
              : _buildPageForUploadImage()),
    );
  }
}
