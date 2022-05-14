import "package:flutter/material.dart";
import "my_drawer_header.dart";
import "package:http/http.dart" as http;
import "globals.dart" as globals;
import "dart:convert";
import "data.dart";
import "detail.dart";
import "add_property.dart";
import "login.dart";
import "promote.dart";
import 'home_page.dart';
import 'about_us.dart';
import 'contact_us.dart';

class userdashboard extends StatefulWidget {
  //userdashboard({Key? key}) : super(key: key);

  @override
  State<userdashboard> createState() => _userdashboardState();
}

class _userdashboardState extends State<userdashboard> {
  int _currentIndex = 0;
  var currentPage = DrawerSections.dashboard;
  bool enabled = true;
  List<Property> allproperties = [];
  List<Property> promotedproperties = [];

  Future getdata() async {
    Uri url = Uri.parse(globals.baseUrl + "userproperty.php");
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
  }

  Future getpromoteddata() async {
    Uri url = Uri.parse(globals.baseUrl + "userpromotedproperty.php");
    var response = await http.post(url, body: {
      "email": globals.email,
    });
    var data = json.decode(response.body);
    if (data == "Fail") return;
    Property p;
    promotedproperties.clear();
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
      promotedproperties.add(p);
    }
  }

  @override
  Widget build(BuildContext context) {
    promoteproperty();
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
          "Your Properties",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RawMaterialButton(
                    fillColor: enabled
                        ? Color.fromARGB(255, 42, 174, 218)
                        : Color.fromARGB(115, 255, 255, 255),

                    //height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Color.fromARGB(255, 155, 48, 40)),
                    ),
                    onPressed: () {
                      setState(() {
                        enabled = true;
                      });
                      getdata();
                    },
                    child: Text(
                      'ALL',
                      style: TextStyle(color: Color.fromARGB(255, 48, 43, 176)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RawMaterialButton(
                    fillColor: !enabled
                        ? Color.fromARGB(255, 42, 174, 218)
                        : Color.fromARGB(115, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Color.fromARGB(255, 155, 48, 40)),
                    ),
                    onPressed: () {
                      setState(() {
                        enabled = false;
                      });
                      getpromoteddata();
                    },
                    child: Text('Promoted',
                        style:
                            TextStyle(color: Color.fromARGB(255, 48, 43, 176))),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: enabled
                    ? FutureBuilder<void>(
                        future: getdata(),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
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
                        })
                    : FutureBuilder<void>(
                        future: getpromoteddata(),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return promotedproperties.length > 0
                                ? ListView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    children: buildpromotedProperties(),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: 35,
                                    color: Colors.blue[100],
                                    alignment: Alignment.center,
                                    child: Text('No Promoted Property',
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
                // ListView(
                //   physics: BouncingScrollPhysics(),
                //   scrollDirection: Axis.vertical,
                //   children: buildProperties(),
                // ),
              ),
            ),
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
            switch (index) {
              case 0:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homepage()));
                break;
              case 1:
                break;
              case 3:
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

  List<Widget> buildpromotedProperties() {
    List<Widget> list = [];

    for (var i = 0; i < promotedproperties.length; i++) {
      list.add(Hero(
          tag: promotedproperties[i].image1,
          child: buildProperty(promotedproperties[i], i)));
    }
    return list;
  }

  Widget buildProperty(Property property, int index) {
    return Card(
        key: ValueKey(property.pid),
        color: Colors.yellow[200],
        margin: EdgeInsets.only(bottom: 24),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detail(property: property)),
                );
              },
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
              ]),
            ),
            enabled
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: RawMaterialButton(
                          fillColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue),
                          ),
                          onPressed: () {
                            globals.promoteid = property.pid;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => promotepage()));
                          },
                          child: Text(
                            'Promote',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: RawMaterialButton(
                          fillColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Color.fromARGB(255, 155, 48, 40)),
                          ),
                          onPressed: () {
                            showAlert(context, property.pid);
                          },
                          child: Text('Delete',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 16)),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: RawMaterialButton(
                          fillColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Color.fromARGB(255, 155, 48, 40)),
                          ),
                          onPressed: () {
                            showAlert(context, property.pid);
                          },
                          child: Text('Delete',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
          ],
        ));
  }

  Future deleteproperty(x) async {
    Uri url = Uri.parse(globals.baseUrl + "deleteproperty.php");
    var response = await http.post(url, body: {
      "pid": x,
    });
    var data = json.decode(response.body);

    if (data == "Success") {
      globals.userproperties = [];
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: const Duration(seconds: 4),
          content: Text('Property Deleted Succesfully')));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => userdashboard()));
    }
  }

  Future promoteproperty() async {
    if (globals.paymentstatus == "success") {
      Uri url = Uri.parse(globals.baseUrl + "promoteproperty.php");
      await http.post(url, body: {
        "pid": globals.promoteid,
      });
      globals.paymentstatus == "fail";

      // if (data == "Success") {
      //   allproperties.clear();
      //   // globals.userproperties = [];
      //   // Navigator.push(
      //   //     context, MaterialPageRoute(builder: (context) => userdashboard()));
      //   print("Success");
      // } else {
      //   print("Fail");
      // }
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

  showAlert(BuildContext context, String x) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.yellow[100],
          title: Text(
            'Warning',
            style: TextStyle(color: Colors.red),
          ),
          content: Text("Are You Sure Want To Delete this Property?"),
          actions: <Widget>[
            MaterialButton(
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Color.fromARGB(255, 155, 48, 40)),
              ),
              child: Text(
                "YES",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                deleteproperty(x);
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Color.fromARGB(255, 155, 48, 40)),
              ),
              child: Text(
                "No",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Color.fromARGB(255, 155, 48, 40)),
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
        );
      },
    );
  }
}

enum DrawerSections {
  dashboard,
  contacts,
  about_us,
}
