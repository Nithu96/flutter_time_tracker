import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/home_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage ({@required this.auth});
  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User1 _user;

  @override
  void initState(){
    super.initState();
    _checkCurrentUser();
    widget.auth.onAuthStateChanged.listen((user) {
      print('user: ${user?.uid}');
    });
  }
  Future<void> _checkCurrentUser() async {
    User1 user = await widget.auth.currentUser();
    _updateUser(user);
  }
  void _updateUser(User1 user) {
   setState(() {
     _user = user;
   });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User1>(
        stream: widget.auth.onAuthStateChanged,
        builder: (context,snapshot){
          if(snapshot.hasData){
            User1 user = snapshot.data;
            if(_user == null) {
              return SignInPage(
                auth:widget.auth,
                onSignIn: _updateUser,
              );
            }
            return HomePage(
              auth:widget.auth,
              onSignOut: () => _updateUser(null),
            ); // temporary placeholder for HomePage
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
        );
  }
}
