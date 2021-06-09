import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(),
    );
  }

  Container _buildContent() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.amberAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.orange,
            child: SizedBox(
              height: 100.0,
            ),
          ),
          Container(
            color: Colors.red,
            child: SizedBox(
              height: 100.0,
            ),
          ),
          Container(
            color: Colors.purple,
            child: SizedBox(
              height: 100.0,
            ),
          )
        ],
      ),
    );
  }
}
