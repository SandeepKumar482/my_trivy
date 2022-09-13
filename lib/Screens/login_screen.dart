import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my_trivy/Util/widgets.dart';
import 'package:my_trivy/Util/app_color.dart';
import 'package:my_trivy/Screens/home_screen.dart';
import 'package:my_trivy/Screens/signup.dart';
import 'package:my_trivy/bloc/auth_cubit.dart';
import 'package:my_trivy/Util/constants.dart';
import 'package:my_trivy/servies/loading_indicator.dart';
import 'package:my_trivy/servies/change_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
            changeScreen(context, const HomeScrn());
            break;
          case AuthState.error:
            showDialog(
                context: context,
                builder: (context) {
                  return const Text('Error');
                });
            break;
          case AuthState.logout:
            changeReplace(context, LoginScreen());
            break;
        }
      }),
      builder: ((context, state) {
        return Scaffold(
            backgroundColor: AppColor.bg,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AppColor.bg,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _key,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          controller: _emailController,
                          cursorColor: AppColor.pwhtie,
                          style: TextStyle(color: AppColor.pwhtie),
                          name: 'email',
                          decoration: kInputDecoration.copyWith(
                            labelText: ' Email ',
                            prefixIcon: const Icon(
                              Icons.email_rounded,
                              color: Colors.white,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (!RegExp(
                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                .hasMatch(value!)) {
                              return 'Invalid email address';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormBuilderTextField(
                          controller: _passwordController,
                          cursorColor: AppColor.pwhtie,
                          style: TextStyle(color: AppColor.pwhtie),
                          name: 'password',
                          obscureText: true,
                          decoration: kInputDecoration.copyWith(
                            labelText: 'Password',
                            prefixIcon: const Icon(
                              Icons.password_rounded,
                              color: Colors.white,
                            ),
                          ), // keyboardType: TextInputType.,
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        Hero(
                          tag: 'login',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Button(
                                label: 'Login',
                                onPress: () {
                                  authProvider.signInWithEmail(
                                      _emailController.text,
                                      _passwordController.text);
                                }),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text(" OR With",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(right: 80, left: 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                // ignore: sdk_version_set_literal
                                onTap: () => {},
                                child: CircleAvatar(
                                  // ignore: sort_child_properties_last
                                  child: Image.asset("images/google_logo.png"),
                                  backgroundColor: AppColor.bg,
                                ),
                              ),
                              InkWell(
                                // ignore: sdk_version_set_literal
                                onTap: () => {},
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: const AssetImage(
                                      "images/Facebook-01.png"),
                                  backgroundColor: AppColor.bg,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'New User?',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Hero(
                    tag: 'signup',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Button(
                          label: 'Signup',
                          onPress: () {
                            changeScreen(context, SignupScrn());
                          }),
                    ),
                  ),
                ],
              ),
            ));
      }),
    );
  }
}
