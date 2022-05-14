import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "globals.dart" as globals;
import "data.dart";
import 'package:khalti_flutter/khalti_flutter.dart';

void main() async {
  //final home = await SplashScreen();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_75a97301164d44f8b2d05f0e133ae547",
        builder: (context, navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            title: 'Hamro Property',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.openSansTextTheme(),
            ),
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        });
  }
}

class SplashScreen extends StatelessWidget {
  // const SplashScreen({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: Image.asset('assets/images/logo.jpg'),
      screenFunction: () async {
        getdata();
        return Homepage();
      },
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}

Future getdata() async {
  Uri url = Uri.parse(globals.baseUrl + "homepage_item.php");
  var response = await http.get(url);
  List data = json.decode(response.body);
  if (data == "Fail") return;
  Property p;
  for (var x = 0; x <= data.length; x++) {
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
    globals.homeproperties.add(p);
  }
}
