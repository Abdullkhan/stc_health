import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stc_health/screens/LoginScreen/LoginBloc/login_bloc.dart';
import 'package:stc_health/screens/AllProductsScreen/all_products_screen.dart';
import 'package:stc_health/utilities/colors.dart';

import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_textField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isObscure = false;

  bool isProgress = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is InitialLoginState) {
        } else if (state is LoadingLoginState) {
        } else if (state is ErrorLoginState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red);
          setState(() {
            isProgress = false;
          });
        } else if (state is LoginSuccess) {
          if (state.message == null) {
            print('Not Success');
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllProductsScrren()));
            Fluttertoast.showToast(
              msg: 'Successfully login',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
            );
            setState(() {
              isProgress = false;
            });
          }
          print(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 400,
                  color: AppColors.mainColor,
                  child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'STC\n HEALTH',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: height * 0.1),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            'Log In',
                            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: Form(
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          labelText: 'Email',
                          keyBoardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: _passwordController,
                          labelText: 'Password',
                          isObscureText: isObscure,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                            child: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                          ),
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isProgress = true;
                            });
                            print('this is email ${_emailController}');

                            _loginBloc.add(
                              LoginData(
                                email: _emailController.text.toString(),
                                password: _passwordController.text,
                              ),
                            );
                          },
                          child: isProgress == true
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CustomButton(
                                  buttonText: 'Continue',
                                ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'NEED HELP ?',
                          style: TextStyle(
                            color: AppColors.textColors,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
