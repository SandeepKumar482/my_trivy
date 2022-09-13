import 'package:my_trivy/Screens/home_screen.dart';
import 'package:my_trivy/bloc/auth_cubit.dart';

import 'Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Screens/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Trivy',
        home: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          switch (state) {
            case AuthState.authenticating:
              return const SplashScrn();
            case AuthState.authenticated:
              return const HomeScrn();
            case AuthState.error:
              return const SplashScrn();
            case AuthState.logout:
              return LoginScreen();
          }
        }),
      ),
    );
  }
}

