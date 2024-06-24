import 'package:flutter/material.dart';
import 'package:to_do_list_app/view/screens/todoapp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  //TextEditingControllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Key
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isPasswordVisiable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Column(
            children: [
              Text(
                "WELCOME!",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                "Sign in to continue",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 16,
                    ),
              ),
              Container(
                width: 600,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(20)),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/person.png",
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: _usernameController,
                          style: Theme.of(context).textTheme.titleSmall,
                          decoration: const InputDecoration(
                              hintText: "Enter UserName",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color.fromRGBO(34, 31, 31, 0.4),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter UserName";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: _passwordController,
                          style: Theme.of(context).textTheme.titleSmall,
                          obscureText: _isPasswordVisiable,
                          decoration: InputDecoration(
                            errorBorder: InputBorder.none,
                            hintText: "Enter password",
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromRGBO(34, 31, 31, 0.4),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPasswordVisiable = !_isPasswordVisiable;
                                });
                              },
                              child: Icon(
                                _isPasswordVisiable
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 26,
                                color: const Color.fromRGBO(34, 31, 31, 0.4),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Password";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            bool isValidate = _formkey.currentState!.validate();
                            if (isValidate) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Login Successful"),
                                ),
                              );
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const ToDoApp(),
                                ),
                              );
                              _usernameController.clear();
                              _passwordController.clear();
                            }
                          },
                          child: Text("Login",
                              style: Theme.of(context).textTheme.titleMedium)),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
