
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 50),
                const ListTile(
                  title: Text(
                    'Account',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 2, 80, 168)),
                  ),
                  dense: true,
                ),
                ListTile(
                  leading: Icon(Icons.person_2_outlined),
                  title: Text('Edit Profile'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                const SizedBox(height: 30),
                const ListTile(
                  title: Text(
                    'Information',
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 80, 168),
                      fontSize: 16,
                    ),
                  ),
                  dense: true,
                ),
                ListTile(
                  leading: Icon(Icons.menu_book),
                  title: Text('Tutorial'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('About App'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.security),
                  title: Text('Privacy Statement'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.data_exploration_sharp),
                  title: Text('Request My Data'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: const Center(
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: 'Settings', icon: Icon(Icons.settings))
        ],
      ),
    );
  }
}
