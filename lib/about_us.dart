import "package:flutter/material.dart";
import 'login.dart';
import 'my_drawer_header.dart';
import 'user_dashboard.dart';
import 'globals.dart';
import 'contact_us.dart';

class about_us extends StatefulWidget {
  const about_us({Key? key}) : super(key: key);

  @override
  State<about_us> createState() => _about_usState();
}

class _about_usState extends State<about_us> {
  bool _value = false;
  int val = -1;
  int _currentIndex = 0;
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = user_dashboard();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // ignore: prefer_const_constructors
              child: Text(
                'About US',
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Image.asset('assets/images/about_us.jpg'),
            ),
            Container(
                child: const Text(
              'The name of the app is “Hamro Property”. The purpose of this app is to simplify the search for properties/assets where most of the people must go to place to place in search for their desired one. But with the help of this application, you can easily search according to your need such as place, budget, area, rooms and even in co-ordinates or in google maps. It will display all the available properties in the desired area. With the help of this app users can view all pictures of available houses or land “Jagga” to rent or lease. If you want to buy or check you can just contact in the given contact number and can visit. This will help the people narrow down their options and find the best one accordingly. This is the best way to search any property whether it is land or buildings. Even if you want to sell or give for renting you don’t have keep advertising or move from place to another that you want to sell or rent. Just upload the description of the property, the area, the picture, and price if possible because some of the people will search according to the price as well, then interested people will automatically contact you directly. This will save your time as well. ',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
              ),
            )),
          ],
        ),
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
                        var globals;
                        globals.username.isNotEmpty
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => add_property()))
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
                icon: Icon(Icons.camera),
                label: 'Property',
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

  user_dashboard() {}

  add_property() {}
}

enum DrawerSections {
  dashboard,
  contacts,
  about_us,
}
