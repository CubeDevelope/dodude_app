import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/router.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Account"),
            onTap: () {
              Keys.masterNavigator.currentState
                  ?.pushNamed(MasterPages.personalData.toPath);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Privacy"),
            onTap: () {
              Keys.masterNavigator.currentState
                  ?.pushNamed(MasterPages.privacy.toPath);
            },
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: const Text("Logout"),
            onTap: () {
              AppProvider.instance.settingBloc.logout();
              Keys.masterNavigator.currentState?.popUntil((route) => false);
              Keys.masterNavigator.currentState
                  ?.pushNamed(MasterPages.auth.toPath);
            },
          ),
        ],
      ),
    );
  }
}
