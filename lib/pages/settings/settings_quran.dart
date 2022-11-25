import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        // dark mode switch
        ListTile(
          title: Text('Dark Mode'),
          trailing: Switch(
            value: true,
            onChanged: null,
          ),
        ),
        Divider(),
        // font size
        ListTile(
          title: Text('Font Size'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        // font size
        ListTile(
          title: Text('Color Scheme'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        // translation
        ListTile(
          title: Text('Translation'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        // sheikh
        ListTile(
          title: Text('Sheikh'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        // share
        ListTile(
          title: Text('Share'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        // rate
        ListTile(
          title: Text('Rate'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        // about
        ListTile(
          title: Text('About'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        // privacy policy
        ListTile(
          title: Text('Privacy Policy'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        // terms and conditions
        ListTile(
          title: Text('Terms and Conditions'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        // contact us
        ListTile(
          title: Text('Contact Us'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        // exit
        ListTile(
          title: Text('Exit'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
