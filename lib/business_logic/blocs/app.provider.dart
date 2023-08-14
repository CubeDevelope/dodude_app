import 'package:app/models/user.model.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class AppProvider {
  static final AppProvider _instance = AppProvider._();

  static get instance => _instance;

  UserModel currentUser = UserModel();
  bool? _cameraPermission;

  AppProvider._();

  List<CameraDescription> cameras = [];

  getCameras() async {
    cameras = await availableCameras();
  }

  Future<bool> get cameraPermission async {
    _cameraPermission ??= await _checkPermission(Permission.camera);
    return _cameraPermission!;
  }

  Future<PermissionStatus> _createRequest(Permission permission) async {
    return await permission.request();
  }

  Future<bool> _checkPermission(Permission permission) async {
    PermissionStatus permissionStatus = await permission.status;

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _createRequest(permission);
    }

    switch (permissionStatus) {
      case PermissionStatus.permanentlyDenied || PermissionStatus.restricted:
        return false;

      default:
        return true;
    }
  }
}
