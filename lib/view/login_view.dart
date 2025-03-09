import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginController = Get.put(LoginController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text('Login Page', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/mono.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              TextField(
                controller: loginController.emailController,
                style: const TextStyle(),
                decoration: InputDecoration(label: Text('Email')),
              ),
              TextField(
                controller: loginController.passwordController,
                style: const TextStyle(),
                decoration: InputDecoration(label: Text('Password')),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                onPressed: () =>
                    {loginController.loginWithEmail(formkey: _formKey)},
                child: Text('Login'),
                backgroundColor: Colors.blue,
                hoverColor: Colors.grey,
              )
            ]),
          ),
        ),
      )),
    );
  }
}
