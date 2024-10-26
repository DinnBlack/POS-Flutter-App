import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pos_flutter_app/features/product/bloc/product_bloc.dart';
import 'package:pos_flutter_app/features/store/bloc/store_bloc.dart';
import 'package:pos_flutter_app/routes/app_routes.dart';
import 'package:pos_flutter_app/screens/services/login/login_screen.dart';
import 'package:pos_flutter_app/screens/services/store/store_select_screen.dart';
import 'package:pos_flutter_app/features/auth/data/auth_firebase.dart';
import 'package:pos_flutter_app/features/category/data/category_firebase.dart';
import 'package:pos_flutter_app/services/firebase/firebase_options.dart';
import 'package:pos_flutter_app/features/product/data/product_firebase.dart';
import 'package:pos_flutter_app/features/store/data/store_firebase.dart';

import 'features/auth/bloc/auth_bloc.dart';
import 'features/category/bloc/category_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarIconBrightness: Brightness.dark,
  //   statusBarColor: Colors.transparent,
  //   systemNavigationBarColor: Colors.transparent,
  // ));

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
          create: (context) {
            AuthBloc(AuthFirebase());
            final authBloc = AuthBloc(AuthFirebase());
            authBloc.add(AuthCheckStatus());
            return authBloc;
          },
        ),
        BlocProvider<StoreBloc>(
          create: (context) => StoreBloc(StoreFirebase()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(ProductFirebase(context)),
          child: BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(
                CategoryFirebase(context), context.read<ProductBloc>()),
          ),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(
              CategoryFirebase(context), context.read<ProductBloc>()),
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

  String _getInitialRoute(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    if (authState is AuthLoginSuccess) {
      return StoreSelectScreen.route;
    } else {
      return LoginScreen.route;
    }
  }
}
