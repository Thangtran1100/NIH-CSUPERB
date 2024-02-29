import 'package:flutter/material.dart';
import 'package:senior_appv1/pages/about_app.dart';
import 'package:senior_appv1/pages/welcome_page.dart';

import 'consumer_sign_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                          fontSize: 16, color: Color.fromARGB(255, 92, 117, 166)),
                    ),
                    dense: true,
                  ),
                  ListTile(
                    leading: Icon(Icons.person_2_outlined),
                    title: Text('Edit Profile'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  //Divider(),
                  const SizedBox(height: 30),
                  const ListTile(
                    title: Text(
                      'Information',
                      style: TextStyle(
                        color: Color.fromARGB(255, 92, 117, 166),
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
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutApp()));
                    },
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
              },
              child: Container(
                //color: Colors.red,
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
      ),
    );
  }
}