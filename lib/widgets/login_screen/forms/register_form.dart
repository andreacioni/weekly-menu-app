import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_menu_app/globals/constants.dart';
import 'package:weekly_menu_app/globals/errors_handlers.dart';
import 'package:weekly_menu_app/models/auth_token.dart';
import 'package:weekly_menu_app/providers/rest_provider.dart';
import 'package:weekly_menu_app/widgets/splash_screen/screen.dart';

import 'base_login_form.dart';

class RegisterForm extends StatefulWidget {
  final void Function() onBackToSignInPressed;

  RegisterForm({this.onBackToSignInPressed});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  String _name, _email, _password, _passwordVerification;

  @override
  Widget build(BuildContext context) {
    return BaseLoginForm(
      "Sign Up",
      "Register",
      [
        TextFormField(
          autofocus: true,
          decoration: InputDecoration(hintText: "Name"),
          onSaved: (name) => _name = name,
        ),
        buildEmailFormField(onSaved: (email) => _email = email),
        buildPasswordFormField(
          onSaved: (password) => _password = password,
        ),
        buildPasswordFormField(
            hintText: "Confirm password",
            onSaved: (passwordVerification) =>
                _passwordVerification = passwordVerification),
      ],
      secondaryActionWidget:
          buildCancelButton(context, onCancel: widget.onBackToSignInPressed),
      formKey: _formKey,
      onSaved: _doRegistration,
    );
  }

  void _doRegistration() async {
    var restProvider = Provider.of<RestProvider>(context, listen: false);

    showProgressDialog(context, dismissible: false);
    try {
      await restProvider.register(_name, _email, _password);

      hideProgressDialog(context);

      await showDialog(
          context: context,
          child: AlertDialog(
            content: Text(
                "You were successfully registered to Weekly Menu! Please login"),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ));

      SplashScreen.goToLogin(context);
    } catch (e) {
      hideProgressDialog(context);
      showAlertErrorMessage(context,
          errorMessage: "New user registration failed. Try again later");
    }
  }
}