import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/pages/home.dart';
import 'package:marketplace/pages/productPage.dart';

import 'api/settings_api.dart';
import 'bloc/category/category_bloc.dart';
import 'bloc/cubit/auth_cubit.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/product/product_bloc.dart';
import 'pages/login.dart';
import 'pages/product.dart';
import 'pages/splash.dart';
import 'utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new UserPreferences();
  await prefs.initPrefs();
  MarketApi.configureDio();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()..init()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => ProductBloc())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instant buy',
      initialRoute: '/',
      routes: {
        '/': (_) => Splash(),
        '/login': (_) => LoginPage(),
        '/home': (_) => HomePage(),
        '/newProduct': (_) => NewProduct(),
        '/product': (_) => ProductPage()
      },
    );
  }
}
