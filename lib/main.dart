import 'package:flutter/material.dart';
import 'package:pos_flutter_app/routes/app_routes.dart';
import 'package:pos_flutter_app/screens/tablet/main_tablet_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Quicksand_Regular',
      ),
      onGenerateRoute: appRoutes,
      initialRoute: MainTabletScreen.route,
    );
  }
}
