import "package:flutter/material.dart";
import 'payment.dart';
import "user_dashboard.dart";
import "my_drawer_header.dart";
import "globals.dart" as globals;
import "add_property.dart";
import "login.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import 'about_us.dart';
import 'contact_us.dart';

class promotepage extends StatefulWidget {
  const promotepage({Key? key}) : super(key: key);

  @override
  State<promotepage> createState() => _promotepageState();
}

class _promotepageState extends State<promotepage> {
  int val = -1;
  int _currentIndex = 0;
  var currentPage = DrawerSections.dashboard;
  String onem = "";
  String threem = "";
  String sixm = "";

  Future getdata() async {
    Uri url = Uri.parse(globals.baseUrl + "readprice.php");
    var response = await http.get(url);
    var data = json.decode(response.body);
    setState(() {
      onem = data[0][1];
      threem = data[1][1];
      sixm = data[2][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = userdashboard();
    } else if (currentPage == DrawerSections.contacts) {
      container = contact_us();
    } else if (currentPage == DrawerSections.about_us) {
      container = about_us();
    }

    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[1200],
        title: Text(
          "Hamro Property",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
              margin: EdgeInsets.only(left: 30, top: 50),
              child: Text(
                "Select Duration",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )),
          Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 30),
              child: Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value as int;
                        });
                      }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1 Month",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text("Amount ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 131, 54, 54),
                                  fontSize: 25)),
                          Text("Rs." + onem,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 250, 102, 3),
                                  fontSize: 25))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 30),
              child: Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value as int;
                        });
                      }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "3 Months",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text("Amount ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 131, 54, 54),
                                  fontSize: 25)),
                          Text("Rs. " + threem,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 250, 102, 3),
                                  fontSize: 25)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 30),
              child: Row(
                children: [
                  Radio(
                      value: 3,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value as int;
                        });
                      }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "6 Months",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text("Amount ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 131, 54, 54),
                                  fontSize: 25)),
                          Text("Rs. " + sixm,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 250, 102, 3),
                                  fontSize: 25)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 120, right: 120, top: 20),
            child: MaterialButton(
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Color.fromARGB(255, 155, 48, 40)),
              ),
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                startpayment();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.indigo, shape: BoxShape.circle),
                    // padding: EdgeInsets.all(14),
                    child: IconButton(
                      iconSize: 50,
                      onPressed: () {
                        globals.username.isNotEmpty
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => addProperty()))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                        //SystemNavigator.pop();
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                ),
                // icon: IconButton(
                //     iconSize: 50,
                //     onPressed: () {
                //       //Register();
                //     },
                //     icon: Icon(Icons.add_box_outlined)),

                label: '',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: 'Property',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Promote',
                backgroundColor: Colors.black),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }

  startpayment() {
    if (val == -1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: Text('Please select any one of above package')));
      return;
    }
    if (val == 1) {
      globals.amount = onem;
    } else if (val == 2) {
      globals.amount = threem;
    } else if (val == 3) {
      globals.amount = sixm;
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => paymentpage()));
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Contacts", Icons.people_alt_outlined,
              currentPage == DrawerSections.contacts ? true : false),
          menuItem(3, "About Us", Icons.event,
              currentPage == DrawerSections.about_us ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      //color: selected ? Colors.grey[300] : Colors.transparent,
      color: Colors.grey[300],
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => userdashboard()));
            } else if (id == 2) {
              currentPage = DrawerSections.contacts;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => contact_us()));
            } else if (id == 3) {
              currentPage = DrawerSections.about_us;
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => about_us()));
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  contacts,
  about_us,
}
