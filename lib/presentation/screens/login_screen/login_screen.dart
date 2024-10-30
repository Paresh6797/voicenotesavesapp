import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../../logic/cubit/login/login_cubit.dart';
import '../../routers/app_router.dart';
import '../../widgets/custom_loading_indicator.dart';
import '../../widgets/custom_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Successful!')),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: redEB5757Color,
              ),
            );
          }
        },
        builder: (context, loginState) {
          if (loginState is LoginLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: theme00b894Color,
            ));
          } else if (loginState is LoginSuccess) {
            //Navigate to Home Screen
            navigateHomeScreen(context);
          }

          return CustomLoadingIndicator(
              inAsyncCall: loginState is LoginLoading,
              color: Colors.white,
              loadMsg: 'Loading...',
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: "Email"),
                      onChanged: (val) {
                        onValidatedData(context);
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                      if (state is LoginEmail) {
                        return CustomText(
                          text: state.errorMessage,
                          size: 14,
                          fontWeight: normal,
                          clr: redF15151Color,
                        );
                      } else {
                        return Container();
                      }
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true,
                      onChanged: (val) {
                        onValidatedData(context);
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                      if (state is LoginPass) {
                        return CustomText(
                          text: state.errorMessage,
                          size: 14,
                          fontWeight: normal,
                          clr: redF15151Color,
                        );
                      } else {
                        return Container();
                      }
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed:
                              loginState is LoginValid ? () => login() : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: loginState is LoginValid
                                ? theme00b894Color
                                : Colors.grey,
                          ),
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  void login() {
    FocusManager.instance.primaryFocus?.unfocus();

    BlocProvider.of<LoginCubit>(context).checkLogin(
        _emailController.text.toString(), _passwordController.text.toString());
  }

  void onValidatedData(BuildContext context) {
    BlocProvider.of<LoginCubit>(context)
        .validateData(_emailController.text, _passwordController.text);
  }

  void navigateHomeScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return; // Check if the widget is still mounted
      AppRouter.navigatorKey.currentState?.pushNamed(AppRouter.home);
    });
  }
}
