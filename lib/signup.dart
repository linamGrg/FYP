import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'globals.dart' as globals;
import "login.dart";

class Signup extends StatefulWidget {
  // const Register({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();

  //@override
  void initState() {
    _passwordVisible = false;
    _passwordVisible2 = false;
    isChecked = false;
  }

  Future register() async {
    Uri url = Uri.parse(globals.baseUrl + "signup.php");
    var response = await http.post(url, body: {
      "username": username.text,
      "email": email.text,
      "phone": phone.text,
      "password": password.text,
    });

    var data = json.decode(response.body);

    if (data.toString() == "Success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            duration: const Duration(seconds: 4),
            content: Text('Successfully Registered')),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Register()));
    } else if (data.toString() == "Already") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 4),
            content: Text('Email or Phone Number already registered')),
      );
    } else if (data.toString() == "Failed") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 4),
            content: Text('Email or Phone Number already registered')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('SignUp')),
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
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: username,
                                decoration: InputDecoration(
                                    labelText: 'Full Name',
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
                                controller: phone,
                                decoration: InputDecoration(
                                    labelText: 'Contact Number',
                                    prefixIcon: Icon(Icons.phone),
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
                                controller: email,
                                decoration: InputDecoration(
                                    labelText: 'Email Address',
                                    prefixIcon: Icon(Icons.email),
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
                                        color: Colors.grey,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (value != password.text) {
                                    return 'Not Match';
                                  }
                                  return null;
                                },
                                controller: repassword,
                                obscureText: !_passwordVisible2,
                                decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    prefixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible2
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible2 =
                                              !_passwordVisible2;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                            ),
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('I accept the terms & conditions'),
                              )
                            ]),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    //padding: const EdgeInsets.only(right: 60),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: MaterialButton(
                                      onPressed: () {
                                        register();
                                        if (_formKey.currentState?.validate() ==
                                                true &&
                                            isChecked == true) {
                                        } else if (isChecked == false) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                duration:
                                                    const Duration(seconds: 4),
                                                content: Text(
                                                    'Please agree to terms and conditions')),
                                          );
                                        }
                                      },
                                      color: Colors.blue[200],
                                      child: Text(
                                        'Signup',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            )
                          ],
                        )))
              ],
            )));
  }
}
