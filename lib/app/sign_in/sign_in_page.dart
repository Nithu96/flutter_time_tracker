import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/sign_in/social_sign.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class SignInPage extends StatelessWidget {
 SignInPage({@required this.auth});
 final AuthBase auth;

  Future<void> _signInAnonymously() async{
    try {
      await auth.signInAnonymously();
      // onSignIn(user);
    } catch (e){
      print(e.toString());
    }
  }

 Future<void> _signInWithGoogle() async{
   try {
     await auth.signInWithGoogle();
     // onSignIn(user);
   } catch (e){
     print(e.toString());
   }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Container _buildContent() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height:48.0),
          SocialSignInButton(
            text: 'Sign in with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: _signInWithGoogle,
            assetName: 'images/google-logo.png',
          ),
          SizedBox(height:8.0),
          SocialSignInButton(
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: () {},
            assetName: 'images/facebook-logo.png',
          ),
          SizedBox(height:8.0),
          SignInButton(
            text: 'Sign in with email',
            textColor: Colors.white,
            color:Color(0xFF016559),
            onPressed: () {},
          ),
          SizedBox(height:8.0),
          Text(
            'or',
            style: TextStyle(fontSize: 14.0,color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(height:8.0),
          SignInButton(
            text: 'Go anonymous',
            textColor: Colors.black,
            color:Color(0xFFF3FF74),
            onPressed: _signInAnonymously,
          ),
        ],
      ),
    );
  }
}
