import 'package:flutter/material.dart';
import 'add_property.dart';
import 'admin_panel.dart';
import 'data.dart';
import 'detail.dart';
import 'user_dashboard.dart';
import 'my_drawer_header.dart';
import 'globals.dart' as globals;
import 'add_property.dart';
import 'login.dart';
import 'home_page.dart';
import "dart:convert";
import "data.dart";
import "package:http/http.dart" as http;
import 'about_us.dart';
import 'contact_us.dart';

class allproperty extends StatefulWidget {
  const allproperty({Key? key}) : super(key: key);

  @override
  State<allproperty> createState() => _allpropertyState();
}

class _allpropertyState extends State<allproperty> {
  // List<Property> properties = getPropertyList();
  int _currentIndex = 0;
  var currentPage = DrawerSections.dashboard;
  List<Property> allproperties = [];

  Future getdata() async {
    Uri url = Uri.parse(globals.baseUrl + "allproperty.php");
    var response = await http.post(url, body: {
      "email": globals.email,
    });
    var data = json.decode(response.body);

    if (data == "Fail") return;
    Property p;
    allproperties.clear();
    for (var x = 0; x < data.length; x++) {
      p = Property(
          data[x][0].toString(),
          data[x][2].toString(),
          data[x][1].toString(),
          data[x][3].toString(),
          data[x][4].toString(),
          data[x][5].toString(),
          data[x][6].toString(),
          data[x][7].toString(),
          data[x][8].toString(),
          data[x][9].toString(),
          data[x][10].toString(),
          data[x][11].toString(),
          data[x][12].toString(),
          data[x][13].toString(),
          data[x][14].toString());
      allproperties.add(p);
    }
    print(allproperties.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 16),
            child: TextField(
              style: TextStyle(
                fontSize: 22,
                height: 1,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.grey[400],
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(left: 25),
            decoration: BoxDecoration(
                color: Colors.pink[500],
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                )),
            child: Center(
              child: Text(
                "All Properties",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[100]),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: FutureBuilder<void>(
                  future: getdata(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return allproperties.length > 0
                          ? ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              children: buildProperties(),
                            )
                          : Container(
                              width: double.infinity,
                              height: 35,
                              //color: Colors.blue[100],
                              alignment: Alignment.center,
                              child: Text('No Property Added',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                    fontSize: 18,
                                  )));
                    } else {
                      return Flexible(
                        child: Text('Loading'),
                      );
                    }
                  }),
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
            switch (index) {
              case 0:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homepage()));
                break;
              case 1:
                break;
              case 3:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => allproperty()));
                break;
              case 4:
                break;
            }
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }

  List<Widget> buildProperties() {
    List<Widget> list = [];
    for (var i = 0; i < allproperties.length; i++) {
      list.add(Hero(
          tag: allproperties[i].image1,
          child: buildProperty(allproperties[i], i)));
    }
    return list;
  }

  Widget buildProperty(Property property, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(property: property)),
        );
      },
      child: Card(
          color: Colors.yellow[200],
          margin: EdgeInsets.only(bottom: 24),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(children: [
            Container(
              height: 210,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(globals.imageUrl + property.image4),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[500],
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      width: 80,
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Center(
                        child: Text(
                          "FOR " + property.title,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      property.SR,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Rs. " + property.price.toString(),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 14,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          property.address,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.zoom_out_map,
                          color: Colors.red,
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          property.area.toString() + " Aana",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ])),
    );
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
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;

              if (globals.username == "admin") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => adminpanel()));
              } else if (globals.username.isNotEmpty) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homepage()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
              }
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
