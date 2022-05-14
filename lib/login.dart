import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:real_estate/home_page.dart';
import 'globals.dart' as globals;
import "signup.dart";

class Register extends StatefulWidget {
  // const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  //@override
  void initState() {
    _passwordVisible = false;
  }

  Future register() async {
    Uri url = Uri.parse(globals.baseUrl + "login.php");
    var response = await http.post(url, body: {
      "email": email.text,
      "password": password.text,
    });

    var data = json.decode(response.body);

    if (data.toString().length > 7) {
      globals.username = data.toString().substring(7, data.toString().length);
      globals.email = email.text;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            duration: const Duration(seconds: 4),
            content: Text('Successfully Logged In')),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 4),
            content:
                Text('Login Failed. Please check your Username or Password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('SignIn')),
        body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                        color: Colors.blue[50],
                        elevation: 5,
                        child: Column(
                          verticalDirection: VerticalDirection.down,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: email,
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: password,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    padding: const EdgeInsets.only(right: 60),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: MaterialButton(
                                      color: Colors.blue[200],
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState?.validate() ==
                                            true) {
                                          register();
                                        }
                                      },
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: MaterialButton(
                                      color: Colors.blue[200],
                                      child: Text(
                                        'Signup',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Signup()));
                                      },
                                    ))
                              ],
                            )
                          ],
                        )))
              ],
            )));
  }
}
