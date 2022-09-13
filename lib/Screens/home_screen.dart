import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_trivy/Screens/login_screen.dart';
import 'package:my_trivy/bloc/auth_cubit.dart';
import 'package:my_trivy/servies/loading_indicator.dart';
import 'package:my_trivy/servies/change_screen.dart';

class HomeScrn extends StatelessWidget {
  const HomeScrn({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: ((context, state) {
        switch (state) {
          case AuthState.authenticating:
            loadingIndicator(context);
            break;
          case AuthState.authenticated:
            changeReplace(context, const HomeScrn());
            break;
          case AuthState.error:
            showDialog(
                context: context,
                builder: (context) {
                  return const Text(' Error ');
                });
            break;
          case AuthState.logout:
            changeScreen(context, LoginScreen());
            break;
        }
      }),
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: GestureDetector(
              onTap: () {
                authProvider.logout();
              },
              child: Text(
                'HomeScrn',
              ),
            ),
          ),
        );
      },
    );
  }
}
