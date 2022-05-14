import 'package:flutter/material.dart';
import 'home_page.dart';
import 'globals.dart' as globals;
import 'login.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  void logout() {
    setState(() {
      globals.username = "";
      globals.email = "";
      globals.userproperties = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: double.infinity,
      height: 150,
      padding: EdgeInsets.only(top: 20.0),
      child: globals.username.length > 0
          ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                //margin: EdgeInsets.all(10),
                height: 80,
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 50,
                  child: Text(
                    globals.username.substring(0, 1),
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    globals.username,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    globals.email,
                    style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 14,
                    ),
                  ),
                  MaterialButton(
                    color: Colors.red[200],
                    height: 25,
                    child: Text(
                      'LogOut',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    onPressed: () {
                      logout();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Homepage()));
                    },
                  )
                ],
              ),
            ])
          : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                //margin: EdgeInsets.all(10),
                height: 80,
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 50,
                  child: Text(
                    'H',
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hamro Property',
                    style: TextStyle(color: Colors.amber, fontSize: 20),
                  ),
                  Text(
                    'Reaching people',
                    style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 14,
                    ),
                  ),
                  MaterialButton(
                    color: Colors.red[200],
                    height: 25,
                    child: Text(
                      'LogIn',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                  )
                ],
              ),
            ]),
    );
  }
}
