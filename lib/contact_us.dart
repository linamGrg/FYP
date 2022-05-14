import "package:flutter/material.dart";
import 'add_property.dart';
import "user_dashboard.dart";
import "my_drawer_header.dart";
import "globals.dart" as globals;
import 'about_us.dart';
import "login.dart";

class contact_us extends StatefulWidget {
  const contact_us({Key? key}) : super(key: key);

  @override
  State<contact_us> createState() => _contact_usState();
}

class _contact_usState extends State<contact_us> {
  bool _value = false;
  int val = -1;
  int _currentIndex = 0;
  var currentPage = DrawerSections.dashboard;

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
        title: const Text(
          "Hamro Property",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            // ignore: prefer_const_constructors
            child: Text(
              'Contact Us',
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Image.asset('assets/images/contact_us.jpg'),
          ),
          Container(
              child: const Text(
            'Nepal',
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )),
          Container(
              margin: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Text(
                'Hamro Property Post Box 375, Pokhara ',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
          Container(
              margin: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Text(
                'Phone: 00977 – 061535471',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
          Container(
              margin: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Text(
                'Mobile: 00977 – 9815170606 ',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
          Container(
              margin: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Text(
                'Email: hamroproperty@gmail.com',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.black),
            const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 167, 237, 117),
                        shape: BoxShape.circle),
                    // padding: EdgeInsets.all(14),
                    child: IconButton(
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
                      icon: Icon(Icons.person),
                    ),
                  ),
                ),
                label: '',
                backgroundColor: Colors.black),
            const BottomNavigationBarItem(
                icon: Icon(Icons.star_sharp),
                label: 'Package',
                backgroundColor: Colors.black),
            const BottomNavigationBarItem(
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

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
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
                  style: const TextStyle(
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
  // ignore: constant_identifier_names
  about_us,
}
