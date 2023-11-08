import 'dart:io';

import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({super.key});

  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  late CameraController controller;

  bool isCameraFront = true;
  FlashMode? flashMode;
  String photoTacked = "";

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      AppProvider.instance.cameras.first,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _getFlashIcon() {
    switch (flashMode) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.auto:
        return Icons.flash_auto;
      default:
    }
  }

  _buildBody(AsyncSnapshot snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (photoTacked.isNotEmpty) {
      return Image.file(
        File(photoTacked),
      );
    }

    return CameraPreview(controller);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            flashMode == null) {
          controller.setFlashMode(FlashMode.off);
          flashMode = FlashMode.off;
        }
        return Scaffold(
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                visible: photoTacked.isEmpty,
                child: IconButton(
                  onPressed: () {
                    FlashMode mode = flashMode ?? FlashMode.auto;
                    switch (mode) {
                      case FlashMode.off:
                        mode = FlashMode.always;
                        break;
                      case FlashMode.always:
                        mode = FlashMode.auto;
                        break;
                      case FlashMode.auto:
                        mode = FlashMode.off;
                        break;
                      default:
                    }
                    controller.setFlashMode(mode);
                    setState(() {
                      flashMode = mode;
                    });
                  },
                  icon: Icon(
                    _getFlashIcon(),
                  ),
                ),
              ),
              Visibility(
                visible: photoTacked.isEmpty,
                child: FloatingActionButton(
                  onPressed: () async {
                    try {
                      //AppProvider.instance.actionCubit.loadImageInStorage();
                      XFile file = await controller.takePicture();
                      if (!mounted) return;
                      setState(() {
                        photoTacked = file.path;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  if (photoTacked.isEmpty) {
                    controller.setDescription(
                      AppProvider.instance.cameras.firstWhere(
                        (element) =>
                            element.lensDirection ==
                            (isCameraFront
                                ? CameraLensDirection.back
                                : CameraLensDirection.front),
                      ),
                    );
                    isCameraFront = !isCameraFront;
                  } else {
                    
                  }
                },
                icon:
                    Icon(photoTacked.isEmpty ? Icons.cameraswitch : Icons.save),
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(),
          body: _buildBody(snapshot),
        );
      },
    );
  }
}
