import 'package:flutter/material.dart';

import '../screens/tablet/main_tablet_screen.dart';

Route<dynamic?> appRoutes(settings) {
  return switch (settings.name) {
    MainTabletScreen.route =>
      MaterialPageRoute(builder: (context) => const MainTabletScreen()),
    _ => MaterialPageRoute(builder: (context) => const MainTabletScreen())
  };
}
