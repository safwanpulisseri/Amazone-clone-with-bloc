import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app_with_bloc/Favourite/bloc/favourite_bloc.dart';
import 'package:shoping_app_with_bloc/cart/bloc/cart_bloc.dart';
import 'package:shoping_app_with_bloc/home/bloc/home_bloc.dart';
import 'package:shoping_app_with_bloc/screen_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(
          create: (context) => FavouriteBloc(),
        ),
        BlocProvider(create: (context) => CartBloc())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreenSplash(),
      ),
    );
  }
}
