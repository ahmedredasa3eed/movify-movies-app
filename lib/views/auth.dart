import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movify/style/styles.dart';
import 'package:movify/views/home_view.dart';
import 'package:movify/widgets/alert_dialog.dart';
import 'package:movify/widgets/form_input.dart';
import 'package:movify/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  static const route = 'auth-screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoginPage = true;
  var _isLoading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void _trySignUp() async {
    if (_formKey.currentState.validate()) {
      if (_nameController.text.trim().isEmpty) {
        return CustomAlertDialog.showAlertDialog(
            context, "Warning", "Name is required");
      } else if (_emailController.text.trim().isEmpty) {
        return CustomAlertDialog.showAlertDialog(
            context, "Warning", "Email Address is required");
      } else if (_passwordController.text.trim().isEmpty) {
        return CustomAlertDialog.showAlertDialog(
            context, "Warning", "Password is required");
      }
      try {
        final _auth = FirebaseAuth.instance;
        UserCredential userCredential;
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('name', _nameController.text.trim());
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      } catch (error) {
        print(error);
      }
    }
  }

  void _trySignIn() async {
    if (_formKey.currentState.validate()) {
      if (_emailController.text.trim().isEmpty) {
        return CustomAlertDialog.showAlertDialog(
            context, "Warning", "Email Address is required");
      } else if (_passwordController.text.trim().isEmpty) {
        return CustomAlertDialog.showAlertDialog(
            context, "Warning", "Password is required");
      }
      setState(() {
        _isLoading = true;
      });
      try {
        final _auth = FirebaseAuth.instance;
        UserCredential userCredential;
        userCredential = await _auth.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.getString('name');
        print(preferences.getString('name'));
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      } catch (error) {
       setState(() {
         _isLoading = false;
       });
        var errorMessage = 'Authentication Failed ! try again';
        if (error.message.contains('badly formatted')) {
          errorMessage = "Email address is not valid";
        }
        CustomAlertDialog.showAlertDialog(context, "Warning", "$errorMessage");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff302b63),
                Color(0xff0f0c29),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _isLoginPage ? "Sign In" : "Sign Up",
                    style: kTitleText,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        !_isLoginPage
                            ? FormInput(
                                hintText: "Name",
                                prefixIcon: Icon(Icons.account_box,
                                    color: Colors.black),
                                keyboardType: TextInputType.text,
                                controller: _nameController,
                                obscureText: false,
                              )
                            : Container(),
                        SizedBox(height: 24),
                        FormInput(
                          hintText: "Email Address",
                          prefixIcon:
                              Icon(Icons.email_outlined, color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          obscureText: false,
                        ),
                        SizedBox(height: 24),
                        FormInput(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock, color: Colors.black),
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          obscureText: true,
                        ),
                        SizedBox(height: 48),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            child: _isLoading ? Loading() : RaisedButton.icon(
                              onPressed: () {
                                if (_isLoginPage) {
                                  _trySignIn();
                                } else {
                                  _trySignUp();
                                }
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              label: Text(
                                _isLoginPage ? "Sign In" : "Sign Up",
                                style: kRaisedButtonsText,
                              ),
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              _isLoginPage = !_isLoginPage;
                            });
                          },
                          child: _isLoginPage
                              ? Text(
                                  "Don\'t have an account, Sign Up now",
                                  style: kFlatButtonsText,
                                )
                              : Text(
                                  "Have an account, Login now",
                                  style: kFlatButtonsText,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
