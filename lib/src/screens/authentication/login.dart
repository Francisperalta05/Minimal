import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tots_test/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:tots_test/src/extensions/navigation.dart';
import 'package:tots_test/src/extensions/sizer.dart';
import 'package:tots_test/src/extensions/validators.dart';
import 'package:tots_test/src/screens/home/home_list.dart';
import 'package:tots_test/src/utils/images_path.dart';

import '../widgets/green_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> _login() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final validate = _formKey.currentState?.validate();

      if (validate == true) {
        await context.read<AuthBloc>().loginUser(email, password);
        context.pushNamedAndRemoveUntil(HomeList.routeName);
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog.adaptive(
                content: Text(
                  e.toString(),
                  style: TextStyle(
                    fontSize: 20.w,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: context.pop,
                    child: const Text("Close"),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -100.h,
              right: -150.w,
              child: CircleBackground(
                size: 400.0.w,
              ),
            ),
            Positioned(
              left: -300.w,
              top: 280.h,
              child: CircleBackground(
                size: 400.0.w,
              ),
            ),
            Positioned(
              bottom: -450.h,
              left: -100.w,
              child: CircleBackground(
                size: 600.0.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      SizedBox(height: 170.h),
                      Image(
                        image: const AssetImage(AppImages.minimal),
                        width: 282.w,
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 12.w,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.5.w,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Mail'),
                        validator: (value) => value?.validateEmail,
                      ),
                      const SizedBox(height: 15.0),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: _passwordController,
                            obscureText: state.hidePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIconColor: Colors.grey,
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                onPressed: () => context
                                    .read<AuthBloc>()
                                    .add(OnShowPassword(!state.hidePassword)),
                              ),
                            ),
                            validator: (value) => value?.validateValue,
                          );
                        },
                      ),
                      SizedBox(height: 50.h),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state.loading ? null : _login,
                            child: state.loading
                                ? const CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.white)
                                : Text(
                                    'LOG IN',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.w,
                                    ),
                                  ),
                          );
                        },
                      ),
                      // const SizedBox(height: 20.0),
                      // TextButton(
                      //   onPressed: () {
                      //     print("Navegar a pantalla de registro");
                      //   },
                      //   child: const Text(
                      //     '¿No tienes cuenta? Regístrate',
                      //     style: TextStyle(),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
