import 'package:cognizant_assessment/routes/ContactsRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CircularChartRoute.dart';

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
  final _backgroundColor = 0x6084FFFF;

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
                  margin: const EdgeInsets.only(left: 16, right: 16),
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
          margin: const EdgeInsets.all(16),
          alignment: Alignment.topLeft,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome To Flutter',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Please enter your details to continue',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.grey),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'User Name',
                  ),
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
                      hintText: 'Password'),
                ),
                const SizedBox(height: 5),
                const Align(
                    alignment: Alignment.topRight,
                    child: Text('Forgot Password?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00B8D4)))),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                        backgroundColor: Color(0xFF4FC3F7)),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    onPressed: () {
                      Get.to(ContactsRoute());
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
