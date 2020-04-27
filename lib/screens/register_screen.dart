import 'package:adolapp/api/authentication.dart';
import 'package:adolapp/helpers/toastHelper.dart';
import 'package:adolapp/screens/hometabs_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helpers/validator.dart';
import '../widget/customFilledButton.dart';
import '../widget/customTextField.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _username;
  String _email;
  String _password;
  bool _loading = false;
  bool _autoValidate = false;

  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    super.initState();
  }

  void _submit() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _loading = true;
    });
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      try {
        await Auth().signUp(_username, _email, _password);
        await Auth().sendEmailVerification();
        showInfoToast("we send you a email verification!");
        Navigator.of(context).pushReplacementNamed("/");
      } catch (e) {
        print("oops: $e");
      } finally {
        setState(() {
          _loading = false;
        });
      }
    } else {
      setState(() {
        _loading = false;
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          height: (_mediaQuery.size.height - _mediaQuery.padding.top) * 0.9,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _theme.primaryColor,
                  _theme.primaryColor.withOpacity(0.7),
                  _theme.accentColor.withOpacity(0.6)
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(150))),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // 1 - Gambar
                    Container(
                      child: Text(
                        "A",
                        style: TextStyle(
                          color: _theme.primaryColor,
                          fontFamily: 'Google',
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                        ),
                      ),
                      padding: EdgeInsets.only(
                        bottom: 16.0,
                        top: 8.0,
                        left: 4.0,
                        right: 24.0,
                      ),
                      decoration: BoxDecoration(
                        color: _theme.accentColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      "Sign up",
                      style: TextStyle(
                        color: _theme.accentColor,
                        fontFamily: 'Google',
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                      ),
                    ),
                    // 2 - Form login
                    Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: Column(
                          children: <Widget>[
                            // Username field
                            CustomTextFormField(
                              icon: Icons.account_circle,
                              keyboardType: TextInputType.text,
                              labelText: "Username",
                              validator: commonValidator,
                              hintText: "alex",
                              onSaved: (input) => _username = input,
                            ),
                            // Email field
                            CustomTextFormField(
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              labelText: "Email",
                              validator: emailValidator,
                              hintText: "email@example.com",
                              onSaved: (input) => _email = input,
                            ),
                            CustomTextFormField(
                              keyForm: _passwordFieldKey,
                              icon: Icons.lock,
                              keyboardType: TextInputType.text,
                              obsecure: true,
                              labelText: "Password",
                              validator: passwordValidator,
                              hintText: "confirm your password",
                              onSaved: (input) => _password = input,
                            ),
                            CustomTextFormField(
                              icon: Icons.lock,
                              keyboardType: TextInputType.text,
                              obsecure: true,
                              labelText: "Confirm Password",
                              validator: (value) => confirmPasswordValidator(
                                value,
                                _passwordFieldKey.currentState.value,
                              ),
                              hintText: "confirm your password",
                            ),
                            _loading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _theme.primaryColor,
                                    ),
                                  )
                                : CustomFilledButton(
                                    child: Text(
                                      "SIGN UP",
                                      style: _theme.textTheme.body1
                                          .copyWith(color: Colors.white),
                                    ),
                                    onTap: _submit,
                                  ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: (_mediaQuery.size.height - _mediaQuery.padding.top) * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: RaisedButton(
                padding: const EdgeInsets.all(15.0),
                onPressed: !_loading ? () {
                  Navigator.of(context).pushReplacementNamed("/login");
                } : () {},
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                    side: BorderSide(color: Color(0xFF179CDF))),
                child: Text(
                  "SIGN IN",
                  style: _theme.textTheme.body2,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
