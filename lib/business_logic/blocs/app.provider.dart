import 'package:app/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProvider {
  static final AppProvider _instance = AppProvider._();
  static get instance => _instance;

  UserModel currentUser = UserModel();

  AppProvider._();

}
