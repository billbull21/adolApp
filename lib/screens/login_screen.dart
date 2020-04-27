import 'package:adolapp/api/authentication.dart';
import 'package:adolapp/helpers/getSharedPrefrences.dart';
import 'package:adolapp/values/strings.dart';
import 'package:flutter/material.dart';

import '../helpers/validator.dart';
import '../widget/customFilledButton.dart';
import '../widget/customTextField.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  bool _loading = false;
  bool _enableAction = true;
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
  }

  void _validateLoginInput() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _loading = true;
      _enableAction = false;
    });
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      try {
        final result = await Auth().signIn(_email, _password);
        await setSharedString(key: userID, value: result.documentID);
        Navigator.of(context).pushReplacementNamed("/");
      } catch (e) {
        print("oops : $e");
      } finally {
        setState(() {
          _loading = false;
          _enableAction = true;
        });
      }
    } else {
      setState(() {
        _loading = false;
        _autoValidate = true;
        _enableAction = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _mediaQuery = MediaQuery.of(context);

    final _heightChild = (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: (_mediaQuery.size.height - _mediaQuery.padding.top) * 0.9,
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
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(150)),
          ),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // 1 - Gambar
                    Container(
                      height: _heightChild * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
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
                            "Sign in",
                            style: TextStyle(
                              color: _theme.accentColor,
                              fontFamily: 'Google',
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 2 - Form login
                    Container(
                      child: Form(
                          key: _formKey,
                          autovalidate: _autoValidate,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
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
                                icon: Icons.lock,
                                obsecure: true,
                                keyboardType: TextInputType.emailAddress,
                                labelText: "Password",
                                validator: passwordValidator,
                                hintText: "your password",
                                onSaved: (input) => _password = input,
                              ),
                              _loading
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        _theme.primaryColor,
                                      ),
                                    )
                                  : CustomFilledButton(
                                      child: Text(
                                        "SIGN IN",
                                        style: _theme.textTheme.body1
                                            .copyWith(color: Colors.white),
                                      ),
                                      onTap: _validateLoginInput,
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: _enableAction
                                        ? () {
                                            // some action here
                                          }
                                        : null,
                                    child: Text(
                                      "forgot password",
                                      style: _theme.textTheme.body1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
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
                  onPressed: _enableAction
                      ? () {
                          Navigator.of(context).pushReplacementNamed("/register");
                        }
                      : () {},
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                      side: BorderSide(color: Color(0xFF179CDF))),
                  child: Text(
                    "SIGN UP",
                    style: _theme.textTheme.body2,
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
