import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'adminpromote.dart';
import "user_dashboard.dart";
import "my_drawer_header.dart";
import "globals.dart" as globals;
import "add_property.dart";
import "login.dart";
import "dart:convert";
import "package:http/http.dart" as http;
import 'about_us.dart';
import 'contact_us.dart';

class adminpanel extends StatefulWidget {
  const adminpanel({Key? key}) : super(key: key);

  @override
  State<adminpanel> createState() => _adminpanelState();
}

class _adminpanelState extends State<adminpanel> {
  bool _value = false;
  int val = -1;
  int _currentIndex = 0;
  var currentPage = DrawerSections.dashboard;
  var u = "";
  var p = "";
  var pp = "";
  var a = "";
  TextEditingController pid = TextEditingController();

  Future getdata() async {
    Uri url = Uri.parse(globals.baseUrl + "adminpanel.php");
    var response = await http.post(url);
    var data = json.decode(response.body);

    setState(() {
      u = data[0].toString();
      p = data[1].toString();
      pp = data[2].toString();
      a = data[3].toString();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  width: 180,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.teal[500],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )),
                  child: Text(
                    "Admin Panel",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Divider(
              color: Colors.black,
              height: 2,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[100],
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )),
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(top: 20),
                      width: 180,
                      //color: Colors.blue[100],
                      child: Text(
                        "Total Users",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[500],
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )),
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      width: 180,
                      height: 150,
                      //color: Colors.blue[500],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/users.png'),
                          Text(
                            u.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.purple[100],
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )),
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(top: 20),
                      width: 180,
                      //color: Colors.blue[100],
                      child: Text(
                        "Total Ads",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.purple[500],
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )),
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      width: 180,
                      height: 150,
                      //color: Colors.blue[500],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/ads.png'),
                          Text(
                            p.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.teal[100],
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )),
                      padding: EdgeInsets.only(left: 10, top: 5),
                      margin: EdgeInsets.only(top: 20),
                      width: 180,
                      //color: Colors.blue[100],
                      child: Text(
                        "Total Promoted Ads",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.teal[300],
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )),
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      width: 180,
                      height: 150,
                      //color: Colors.blue[500],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/pads.png'),
                          Text(
                            pp.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orange[100],
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )),
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(top: 20),
                      width: 180,
                      //color: Colors.blue[100],
                      child: Text(
                        "Total Amount",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orange[500],
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )),
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      width: 180,
                      height: 150,
                      //color: Colors.blue[500],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/amount.png'),
                          Text(
                            a.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Colors.black,
              height: 2,
              thickness: 1,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  color: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Color.fromARGB(255, 155, 48, 40)),
                  ),
                  child: Text(
                    "Remove Ad",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () {
                    showAlert(context);
                  },
                ),
                MaterialButton(
                  color: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Color.fromARGB(255, 155, 48, 40)),
                  ),
                  child: Text(
                    "Update Package",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => adminpromotepage()));
                  },
                ),
              ],
            )
          ],
        ),
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

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.yellow[100],
          title: Text(
            'Remove Property',
            style: TextStyle(color: Colors.red),
          ),
          //content: Text("Are You Sure Want To Delete this Property?"),
          content: SingleChildScrollView(
            child: Container(
              width: 250,
              height: 120,
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: pid,
                      decoration: InputDecoration(
                          labelText: 'Enter Property Id',
                          prefixIcon: Icon(Icons.roofing_rounded),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(
                                color: Color.fromARGB(255, 155, 48, 40)),
                          ),
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (pid.text == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: const Duration(seconds: 4),
                                      content: Text(
                                          'Please type valid Property Id')));
                            } else {
                              deleteproperty();
                              //Navigator.of(context).pop();
                            }
                          }),
                      MaterialButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                              color: Color.fromARGB(255, 155, 48, 40)),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future deleteproperty() async {
    Uri url = Uri.parse(globals.baseUrl + "deleteproperty.php");
    var response = await http.post(url, body: {
      "pid": pid.text,
    });
    var data = json.decode(response.body);

    if (data == "Success") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: const Duration(seconds: 4),
          content: Text('Property Deleted Succesfully')));
    } else if (data == "NA") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: const Duration(seconds: 4),
          content: Text('Property Not Found')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: const Duration(seconds: 4),
          content: Text('Property could not be deleted')));
    }
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
