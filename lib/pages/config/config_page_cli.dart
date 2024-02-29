import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:farmacia/widgets/appbar_cli.dart';
import 'package:farmacia/widgets/loading_screen.dart';

class ConfigPageCli extends StatefulWidget {
  const ConfigPageCli({Key? key}) : super(key: key);

  @override
  ConfigPageState createState() => ConfigPageState();
}

class ConfigPageState extends State<ConfigPageCli> {
  bool _notifications = false;
  bool _darkMode = false;
  late Future<void> _loadConfigFuture;

  @override
  void initState() {
    super.initState();
    _loadConfigFuture = loadConfig();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadConfigFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return _buildScaffold();
        }
      },
    );
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      appBar: const AppBarCli(
        title: 'Configuración',
      ),
      body: ListView(
        children: <Widget>[
          _buildSwitchListTile(
            title: 'Notificaciones',
            value: _notifications,
            onChanged: (bool value) {
              setState(() {
                _notifications = value;
                saveConfig();
              });
            },
          ),
          _buildSwitchListTile(
            title: 'Dark Mode',
            value: _darkMode,
            onChanged: (bool value) {
              setState(() {
                _darkMode = value;
                saveConfig();
              });
            },
          ),
        ],
      ),
    );
  }

  ListTile _buildSwitchListTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: (bool newValue) {
          onChanged(newValue);
          if (title == 'Dark Mode') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Dark mode settings will apply after restart.'),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> loadConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notifications = prefs.getBool('notifications') ?? false;
      _darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  void saveConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifications', _notifications);
    prefs.setBool('darkMode', _darkMode);
  }
}
