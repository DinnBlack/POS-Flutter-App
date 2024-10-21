import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pos_flutter_app/features/product/bloc/product_bloc.dart';
import 'package:pos_flutter_app/features/store/bloc/store_bloc.dart';
import 'package:pos_flutter_app/routes/app_routes.dart';
import 'package:pos_flutter_app/screens/mobile/main_mobile_screen.dart';
import 'package:pos_flutter_app/screens/services/login/login_screen.dart';
import 'package:pos_flutter_app/screens/tablet/main_tablet_screen.dart';
import 'package:pos_flutter_app/services/firebase/auth_firebase.dart';
import 'package:pos_flutter_app/services/firebase/firebase_options.dart';
import 'package:pos_flutter_app/services/firebase/product_firebase.dart';
import 'package:pos_flutter_app/services/firebase/store_firebase.dart';

import 'features/auth/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.web,
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
    );
  }

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthFirebase()),
        ),
        BlocProvider<StoreBloc>(
          create: (context) => StoreBloc(StoreFirebase()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(ProductFirebase(context)),
        ),
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'POS Flutter App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          fontFamily: 'Quicksand',
        ),
        onGenerateRoute: appRoutes,
        initialRoute: LoginScreen.route,
      ),
    );
  }
}
