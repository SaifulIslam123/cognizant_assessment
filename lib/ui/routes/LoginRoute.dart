import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CustomWidgetChartRoute.dart';
import 'ContactsRoute.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginRoute> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  final _backgroundColor = 0xFFCAEEFE;
  final _screenMargin = 22.0;
  final _labelColor = 0xFF8C969F;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                0.2,
                0.5,
                1
              ],
                  colors: [
                Color(_backgroundColor),
                Color(_backgroundColor),
                Colors.white
              ])),
          child: Column(
            children: [_showLogo(), _showLoginFields()],
          ),
        ),
      ),
    );
  }

  Widget _showLogo() {
    return Expanded(
        flex: 40,
        child: Row(
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  height: 200.0,
                  margin: EdgeInsets.only(
                      left: _screenMargin, right: _screenMargin),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset('assets/images/icons_flutter_240.png'),
                    ),
                  )),
            ),
          ],
        ));
  }

  Widget _showLoginFields() {
    return Expanded(
        flex: 60,
        child: Container(
          margin: EdgeInsets.all(_screenMargin),
          alignment: Alignment.topLeft,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome To Flutter',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xFF434343)),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Please enter your details to continue',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Color(0xFF8C969F)),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'User Name',
                      hintStyle: TextStyle(color: Color(_labelColor))),
                ),
                const SizedBox(height: 16),
                TextFormField(
                    obscureText: _isObscure,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Color(_labelColor)))),
                const SizedBox(height: 5),
                const Align(
                    alignment: Alignment.topRight,
                    child: Text('Forgot Password?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26C0F9)))),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                        backgroundColor: const Color(0xFF79D7FB)),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    onPressed: () {
                      Get.to(() => ContactsRoute());
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
