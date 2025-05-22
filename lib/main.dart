import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssu_prime/responsive/desktop_scaffold.dart';
import 'package:ssu_prime/responsive/mobile_scaffold.dart';
import 'package:ssu_prime/responsive/responsive.dart';
import 'package:ssu_prime/responsive/tablet_scaffold.dart';
import 'package:ssu_prime/themes/theme_provider.dart';



void main() async {
  runApp(
  MultiProvider(
    providers: [
      // Theme Provider
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({
    super.key,
  });

  //get onTap => null;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: //LoginPage(onTap: onTap),


      Responsive(
        mobileScaffold: const MobileScaffold(),
        tabletScaffold:  const TabletScaffold(),
        desktopScaffold:  const DesktopScaffold(),
      ),



      theme: Provider
          .of<ThemeProvider>(context)
          .themeData,
    );
  }
}