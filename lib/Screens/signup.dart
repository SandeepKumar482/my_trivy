import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my_trivy/Util/app_color.dart';
import 'package:my_trivy/Screens/home_screen.dart';
import 'package:my_trivy/Screens/login_screen.dart';
import 'package:my_trivy/bloc/auth_cubit.dart';
import 'package:my_trivy/Util/constants.dart';
import 'package:my_trivy/servies/change_screen.dart';
import 'package:my_trivy/servies/loading_indicator.dart';

import '../Util/widgets.dart';

class SignupScrn extends StatelessWidget {
  SignupScrn({super.key});

  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(listener: ((context, state) {
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
                return const Text('Error');
              });
          break;
        case AuthState.logout:
          changeReplace(context, LoginScreen());
          break;
      }
    }), builder: (context, state) {
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
                        controller: _nameController,
                        cursorColor: AppColor.pwhtie,
                        style: TextStyle(color: AppColor.pwhtie),
                        name: 'name',
                        decoration: kInputDecoration.copyWith(
                            labelText: 'Name', hintText: 'Enter your name', prefixIcon: const Icon(
                            Icons.switch_account_rounded,
                            color: Colors.white,
                          ),),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        controller: _emailController,
                        cursorColor: AppColor.pwhtie,
                        style: TextStyle(color: AppColor.pwhtie),
                        name: 'email',
                        decoration: kInputDecoration.copyWith(
                            labelText: 'Email', hintText: 'Enter Email', prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: Colors.white,
                          ),),
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
                          hintText: 'Enter the Password',
                          labelText: 'Password',
                          prefixIcon: const Icon(
                            Icons.password_rounded,
                            color: Colors.white,
                          ),
                        ),
                         validator: (value) {
                            if (value.toString().length < 7) {
                              return 'Password must be of 7 characters ';
                            } else {
                              return null;
                            }
                          },
                       
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        controller: _confirmPasswordController,
                        cursorColor: AppColor.pwhtie,
                        style: TextStyle(color: AppColor.pwhtie),
                        name: 'cpassword',
                        obscureText: true,
                        decoration: kInputDecoration.copyWith(
                            labelText: 'Confirm Password ', prefixIcon: const Icon(
                            Icons.password_rounded,
                            color: Colors.white,
                          ),hintText: 'Enter Confirm Password'),
                         validator: (value) {
                            if (value.toString()!=_passwordController.text) {
                              return 'Both passwords must be same ';
                            } else {
                              return null;
                            }
                          },
                       
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      Hero(
                        tag: 'signup',
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Button(
                                label: 'Signup',
                                onPress: () {
                                  authProvider.signUpWithEmail(
                                      _nameController.text,
                                      _emailController.text,
                                      _confirmPasswordController.text);
                                })),
                      ),
                      const SizedBox(height: 25),
                      const Text(" OR With",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
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
                                backgroundColor: AppColor.bg,
                                child: Image.asset("images/google_logo.png"),
                              ),
                            ),
                            InkWell(
                              // ignore: sdk_version_set_literal
                              onTap: () => {},
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    const AssetImage("images/Facebook-01.png"),
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
                  'Already have an account?',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 10),
                Hero(
                  tag: 'Login',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Button(
                      label: 'Login',
                      onPress: () {
                        changeScreen(context, LoginScreen());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}

