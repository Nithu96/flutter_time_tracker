import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class HomePage extends StatelessWidget {
  // const HomePage({Key? key}) : super(key: key);

  HomePage({@required this.auth});
  // final VoidCallback onSignOut;
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      // onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed:_signOut,
          ),
        ],
      ),
    );
  }
}
