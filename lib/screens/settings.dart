import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notification_status = false;
  
  @override
  Widget build(BuildContext context) {
	return Scaffold(
    appBar: AppBar(
      title: Row(
        children: [
          Text('การตั้งค่า'),          
        ],
      ),
    ),
    body: Container(
      color: Colors.white,
      child: SettingsList(
        backgroundColor: Colors.blue[200],
        contentPadding: EdgeInsets.only(top: 20),
        sections: [
          SettingsSection(
            tiles: [
                SettingsTile(
                  title: 'ชื่อ',
                  leading: Icon(Icons.account_box),
                  trailing: Text('ไม่ระบุ'),
                  onPressed: (BuildContext context) {
                  },
                ),
                SettingsTile(
                  title: 'เพศ',
                  leading: Icon(Icons.wc),
                  trailing: Text('ไม่ระบุ'),
                  onPressed: (BuildContext context) {
                  },
                ),
                SettingsTile(
                  title: 'น้ำหนัก',
                  leading: Icon(Icons.accessibility),
                  trailing: Text('0 kg'),
                  onPressed: (BuildContext context) {
                  },
                ),
                SettingsTile(
                  title: 'ส่วนสูง',
                  leading: Icon(Icons.height),
                  trailing: Text('0 cm'),
                  onPressed: (BuildContext context) {
                  },
                ),
                SettingsTile(
                  title: 'เป้าหมาย',
                  leading: Icon(Icons.local_drink),
                  trailing: Text('0 ml'),
                  onPressed: (BuildContext context) {
                  },
                ),
            ],
          ),
        ],
      )
    ),
	);
  }
}