import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'globals.dart' as globals;
import 'home_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class addProperty extends StatefulWidget {
  @override
  State<addProperty> createState() => _addPropertyState();
}

class _addPropertyState extends State<addProperty> {
  List<XFile>? _imageFileList;
  List<XFile>? _imageFileList2;
  List<XFile>? _imageFileList3;
  List<XFile>? _imageFileList4;

  String status = '';
  String base64Image1 = "";
  String base64Image2 = "";
  String base64Image3 = "";
  String base64Image4 = "";

  String errMessage = 'Error Uploading Image';
  TextEditingController pid = TextEditingController();
  TextEditingController owner = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController sr = TextEditingController();
  TextEditingController propertytitle = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController numberoffloors = TextEditingController();
  TextEditingController rooms = TextEditingController();
  TextEditingController image1 = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController image2 = TextEditingController();
  TextEditingController image3 = TextEditingController();
  TextEditingController image4 = TextEditingController();
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
  bool isChecked = false;
  bool _isvisible = false;
  final _formKey = GlobalKey<FormState>();
  List<String> items = ['Sale', 'Rent'];
  String selectedItem = 'Sale';
  //late Future<PickedFile> pickedFile;
  // late File tmpFile;
  // String imagepath = "";

  List<String> props = ['House', 'Land'];
  String selectedPropItem = 'Land';
  // dynamic _pickImageError;
  String? _retrieveDataError;

  //late XFile tmpfile;
  final ImagePicker _picker = ImagePicker();
  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  final ImagePicker _picker2 = ImagePicker();
  set _imageFile2(XFile? value) {
    _imageFileList2 = value == null ? null : [value];
  }

  final ImagePicker _picker3 = ImagePicker();
  set _imageFile3(XFile? value) {
    _imageFileList3 = value == null ? null : [value];
  }

  final ImagePicker _picker4 = ImagePicker();
  set _imageFile4(XFile? value) {
    _imageFileList4 = value == null ? null : [value];
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
        _imageFileList = response.files;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  chooseImage() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 200,
        maxWidth: 200);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  chooseImage2() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 200,
        maxWidth: 200);
    setState(() {
      _imageFile2 = pickedFile;
    });
  }

  chooseImage3() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 200,
        maxWidth: 200);
    setState(() {
      _imageFile3 = pickedFile;
    });
  }

  chooseImage4() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 200,
        maxWidth: 200);
    setState(() {
      _imageFile4 = pickedFile;
    });
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  //@override
  void initState() {
    _passwordVisible = false;
    _passwordVisible2 = false;
    isChecked = false;
  }

  Future register() async {
    Uri url1 = Uri.parse(globals.baseUrl + "nexthouseid.php");
    var response1 = await http.get(url1);
    var data1 = json.decode(response1.body);

    Uri url = Uri.parse(globals.baseUrl + "addproperty.php");
    var response = await http.post(url, body: {
      "pid": data1.toString(),
      "owner": globals.username,
      "email": globals.email,
      "phone": phone.text,
      "sr": selectedItem,
      "type": selectedPropItem,
      "title": propertytitle.text,
      "address": address.text,
      "price": price.text,
      "area": area.text,
      "floors": numberoffloors.text,
      "rooms": rooms.text,
      "description": description.text,
      "filename1": "house" + data1.toString() + "_1.jpg",
      "filename2": "house" + data1.toString() + "_2.jpg",
      "filename3": "house" + data1.toString() + "_3.jpg",
      "filename4": "house" + data1.toString() + "_4.jpg",
      "image1": base64Image1,
      "image2": base64Image2,
      "image3": base64Image3,
      "image4": base64Image4,
    });
    var data = json.decode(response.body);

    if (data == "Success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            duration: const Duration(seconds: 4),
            content: Text('Property Successfully Registered')),
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } else if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 4),
            content: Text('Data could not be saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Property')),
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
                                child: Container(
                                    width: double.infinity,
                                    height: 35,
                                    color: Colors.blue[100],
                                    alignment: Alignment.center,
                                    child: Text('Basic Information',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent,
                                          fontSize: 18,
                                        )))),
                            Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                              height: 30,
                                              child: Text(
                                                'Type',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          SizedBox(
                                              width: 100,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                onSaved: (value) {
                                                  setState(() {
                                                    selectedItem = value!;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter some text';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 3,
                                                                    color: Colors
                                                                        .blue))),
                                                value: selectedItem,
                                                items: items
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(item,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18)),
                                                        ))
                                                    .toList(),
                                                onChanged: (item) => setState(
                                                    () => selectedItem = item!),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  height: 30,
                                                  child: Text(
                                                    'Property',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              SizedBox(
                                                  width: 120,
                                                  child: DropdownButtonFormField<
                                                          String>(
                                                      onSaved: (value) {
                                                        setState(() {
                                                          selectedPropItem =
                                                              value!;
                                                        });
                                                      },
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter some text';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              borderSide: BorderSide(
                                                                  width: 3,
                                                                  color: Colors
                                                                      .blue))),
                                                      value: selectedPropItem,
                                                      items: props
                                                          .map((item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: item,
                                                                child: Text(
                                                                    item,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18)),
                                                              ))
                                                          .toList(),
                                                      onChanged: (item) =>
                                                          setState(() {
                                                            selectedPropItem =
                                                                item!;
                                                            _isvisible =
                                                                !_isvisible;
                                                          })
                                                      // setState(() =>
                                                      //     selectedPropItem =
                                                      //         item!),
                                                      )),
                                            ],
                                          )),
                                    ])),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: propertytitle,
                                decoration: InputDecoration(
                                    labelText: 'Proprty Title',
                                    prefixIcon: Icon(Icons.title),
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
                                controller: price,
                                decoration: InputDecoration(
                                    labelText: 'Price',
                                    prefixIcon:
                                        Icon(Icons.monetization_on_outlined),
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
                                controller: area,
                                decoration: InputDecoration(
                                    labelText: 'Area',
                                    prefixIcon:
                                        Icon(Icons.autofps_select_sharp),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                            ),
                            Visibility(
                              visible: _isvisible,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: numberoffloors,
                                  decoration: InputDecoration(
                                      labelText: 'Number Of Floors',
                                      prefixIcon:
                                          Icon(Icons.house_siding_sharp),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: _isvisible,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: rooms,
                                  decoration: InputDecoration(
                                      labelText: 'Rooms',
                                      prefixIcon: Icon(Icons.roofing_rounded),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  // MaterialButton(
                                  //   shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(18.0),
                                  //     side: BorderSide(
                                  //         color:
                                  //             Theme.of(context).primaryColor),
                                  //   ),
                                  //   onPressed: chooseImage,
                                  //   child: Text('Choose Image'),
                                  // ),
                                  Container(
                                      width: double.infinity,
                                      height: 35,
                                      color: Colors.blue[100],
                                      alignment: Alignment.center,
                                      child: Text('Property Images',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                            fontSize: 18,
                                          ))),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: chooseImage,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0))),
                                              width: 100,
                                              height: 70,
                                              child: FutureBuilder<void>(
                                                  future: retrieveLostData(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<void>
                                                              snapshot) {
                                                    if (snapshot.connectionState ==
                                                            ConnectionState
                                                                .done &&
                                                        _imageFileList?[0] !=
                                                            null) {
                                                      base64Image1 = base64Encode(
                                                          File(_imageFileList![
                                                                      0]
                                                                  .path)
                                                              .readAsBytesSync());

                                                      return Flexible(
                                                          child: Image.file(
                                                        File(_imageFileList![0]
                                                            .path),
                                                        fit: BoxFit.fill,
                                                      ));
                                                    } else {
                                                      return Flexible(
                                                        child: Image.asset(
                                                            'assets/images/logo.jpg'),
                                                      );
                                                    }
                                                  }),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          GestureDetector(
                                            onTap: chooseImage2,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0))),
                                              width: 100,
                                              height: 70,
                                              child: FutureBuilder<void>(
                                                  future: retrieveLostData(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<void>
                                                              snapshot) {
                                                    if (snapshot.connectionState ==
                                                            ConnectionState
                                                                .done &&
                                                        _imageFileList2?[0] !=
                                                            null) {
                                                      base64Image2 = base64Encode(
                                                          File(_imageFileList2![
                                                                      0]
                                                                  .path)
                                                              .readAsBytesSync());
                                                      return Flexible(
                                                          child: Image.file(
                                                        File(_imageFileList2![0]
                                                            .path),
                                                        fit: BoxFit.fill,
                                                      ));
                                                    } else {
                                                      return Flexible(
                                                        child: Image.asset(
                                                            'assets/images/logo.jpg'),
                                                      );
                                                    }
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: chooseImage3,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0))),
                                              width: 100,
                                              height: 70,
                                              child: FutureBuilder<void>(
                                                  future: retrieveLostData(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<void>
                                                              snapshot) {
                                                    if (snapshot.connectionState ==
                                                            ConnectionState
                                                                .done &&
                                                        _imageFileList3?[0] !=
                                                            null) {
                                                      base64Image3 = base64Encode(
                                                          File(_imageFileList3![
                                                                      0]
                                                                  .path)
                                                              .readAsBytesSync());
                                                      return Flexible(
                                                          child: Image.file(
                                                        File(_imageFileList3![0]
                                                            .path),
                                                        fit: BoxFit.fill,
                                                      ));
                                                    } else {
                                                      return Flexible(
                                                        child: Image.asset(
                                                            'assets/images/logo.jpg'),
                                                      );
                                                    }
                                                  }),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          GestureDetector(
                                            onTap: chooseImage4,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0))),
                                              width: 100,
                                              height: 70,
                                              child: FutureBuilder<void>(
                                                  future: retrieveLostData(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<void>
                                                              snapshot) {
                                                    if (snapshot.connectionState ==
                                                            ConnectionState
                                                                .done &&
                                                        _imageFileList4?[0] !=
                                                            null) {
                                                      base64Image4 = base64Encode(
                                                          File(_imageFileList4![
                                                                      0]
                                                                  .path)
                                                              .readAsBytesSync());
                                                      return Flexible(
                                                          child: Image.file(
                                                        File(_imageFileList4![0]
                                                            .path),
                                                        fit: BoxFit.fill,
                                                      ));
                                                    } else {
                                                      return Flexible(
                                                        child: Image.asset(
                                                            'assets/images/logo.jpg'),
                                                      );
                                                    }
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                minLines: 1,
                                maxLines:
                                    5, // allow user to enter 5 line in textfield
                                keyboardType: TextInputType
                                    .multiline, // user keyboard will have a button to move cursor to next line

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: description,
                                decoration: InputDecoration(
                                    labelText: 'Description',
                                    prefixIcon:
                                        Icon(Icons.text_fields_outlined),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: double.infinity,
                                    height: 35,
                                    color: Colors.blue[100],
                                    alignment: Alignment.center,
                                    child: Text('Location',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent,
                                          fontSize: 18,
                                        )))),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: address,
                                decoration: InputDecoration(
                                    labelText: 'Address',
                                    prefixIcon: Icon(Icons.home),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: double.infinity,
                                    height: 35,
                                    color: Colors.blue[100],
                                    alignment: Alignment.center,
                                    child: Text('Contact Details',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent,
                                          fontSize: 18,
                                        )))),
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
                                    labelText: 'Phone Number',
                                    prefixIcon: Icon(Icons.phone),
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
                                        if (_formKey.currentState?.validate() ==
                                                true &&
                                            isChecked == true) {
                                          register();
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
                                        'Save',
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
