import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:stc_health/screens/AllProductsScreen/AllProductsBloc/allProducts_bloc.dart';
import 'package:stc_health/screens/DetailScreen/DetailBloc/detail_bloc.dart';
import 'package:stc_health/screens/LoginScreen/LoginBloc/login_bloc.dart';
import 'package:stc_health/screens/AllProductsScreen/all_products_screen.dart';
import 'package:stc_health/screens/DetailScreen/details_screen.dart';
import 'package:stc_health/screens/LoginScreen/login_screen.dart';
import 'package:stc_health/utilities/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<AllProductsBloc>(
          create: (context) => AllProductsBloc(),
        ),
        BlocProvider<DetailProductBloc>(
          create: (context) => DetailProductBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          splashColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, primary: AppColors.mainColor),
          useMaterial3: true,
        ),
        home: LoginPage(),
      ),
    );
  }
}
