import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Configurações'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Section',
            tiles: [
              SettingsTile(
                title: 'Jornada de Trabalho',
                subtitle: '8 horas',
                leading: Icon(Icons.lock_clock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                  title: 'Notificar o Fim da Jornada',
                  leading: Icon(Icons.notifications),
                  switchValue: false,
                  onToggle: (bool value) {},
              )
            ],
          )
        ],
      ),
    );
  }
}