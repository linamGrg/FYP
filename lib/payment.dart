import "package:flutter/material.dart";
import "user_dashboard.dart";
import "my_drawer_header.dart";
import "globals.dart" as globals;
import "add_property.dart";
import "login.dart";
import 'package:khalti_flutter/khalti_flutter.dart';
import "dart:convert";
import "package:http/http.dart" as http;
import 'about_us.dart';
import 'contact_us.dart';

class paymentpage extends StatefulWidget {
  const paymentpage({Key? key}) : super(key: key);

  @override
  State<paymentpage> createState() => _paymentpageState();
}

class _paymentpageState extends State<paymentpage> {
  int val = -1;
  int _currentIndex = 0;
  var currentPage = DrawerSections.dashboard;

  onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  getAmt() {
    return int.parse(globals.amount) * 100; // Converting to paisa
  }

  Future updateamount() async {
    Uri url = Uri.parse(globals.baseUrl + "updatepayment.php");
    await http.post(url, body: {
      "pid": globals.promoteid,
      "payment_date": DateTime.now().toString(),
      "amount": globals.amount,
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  "Select Payment",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
            Card(
              margin: EdgeInsets.only(top: 30, left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      child:
                          Image.asset("assets/images/khalti.png", width: 100),
                      onTap: () {
                        KhaltiScope.of(context).pay(
                          config: PaymentConfig(
                            amount: getAmt(),
                            productIdentity: 'Promotion',
                            productName: 'Property Promotion',
                          ),
                          preferences: [
                            PaymentPreference.khalti,
                          ],
                          onSuccess: (su) {
                            print("yess");
                            updateamount();
                            const successsnackBar = SnackBar(
                              content: Text(
                                  'Payment Successful. Property Promoted Successfully'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(successsnackBar);
                            globals.paymentstatus = "success";
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => userdashboard()));
                          },
                          onFailure: (fa) {
                            const failedsnackBar = SnackBar(
                              content: Text('Payment Failed'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(failedsnackBar);
                          },
                          onCancel: () {
                            const cancelsnackBar = SnackBar(
                              content: Text('Payment Cancelled'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(cancelsnackBar);
                          },
                        );
                      }),
                  Text("Rs. " + globals.amount,
                      style: TextStyle(
                          color: Color.fromARGB(255, 250, 102, 3),
                          fontSize: 24)),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.only(top: 30, left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/visa.png", width: 100),
                  Text("Rs. " + globals.amount,
                      style: TextStyle(
                          color: Color.fromARGB(255, 250, 102, 3),
                          fontSize: 24)),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.only(top: 30, left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/fonepay.png", width: 100),
                  Text("Rs. " + globals.amount,
                      style: TextStyle(
                          color: Color.fromARGB(255, 250, 102, 3),
                          fontSize: 24)),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.only(top: 30, left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/esewa.png", width: 100),
                  Text("Rs. " + globals.amount,
                      style: TextStyle(
                          color: Color.fromARGB(255, 250, 102, 3),
                          fontSize: 24)),
                ],
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
            }));
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
