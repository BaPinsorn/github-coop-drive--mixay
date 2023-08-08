import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coop_driver_mixay/Providers/scan_provider.dart';
import 'package:flutter_coop_driver_mixay/screen/Branches.dart';
import 'package:flutter_coop_driver_mixay/screen/QR_Scanner.dart';
import 'package:flutter_coop_driver_mixay/screen/ScanConfirmation.dart';
import 'package:flutter_coop_driver_mixay/screen/login.dart';
import 'package:flutter_coop_driver_mixay/screen/menu.dart';
import 'package:provider/provider.dart';
import 'Colors.dart/MxColors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MxColors.mainColorRed,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Custom function to create a MaterialColor from RGB values
  MaterialColor _createMaterialColor(Color color) {
    List<double> strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  @override
  Widget build(BuildContext context) {
    Color customColor = MxColors.mainColorRed;
    MaterialColor customSwatch = _createMaterialColor(customColor);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return ScanProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: customSwatch),
        debugShowCheckedModeBanner: true,
        home: const MenuScreen(),
      ),
    );
  }
}
