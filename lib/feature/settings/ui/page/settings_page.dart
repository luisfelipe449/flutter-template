import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_starter/core/ui/dialog/dialogs.dart';
import 'package:scalable_flutter_app_starter/feature/settings/ui/widget/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsTile(
            icon: Icons.logout_outlined,
            label: 'Sign Out',
            onTap: () => Dialogs.showLogOutConfirmationDialog(context),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
