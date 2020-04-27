import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Key keyForm;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obsecure;
  final Function validator;
  final String labelText;
  final String hintText;
  final Function onSaved;

  CustomTextFormField({
    this.keyForm,
    this.icon,
    this.keyboardType,
    this.obsecure = false,
    this.validator,
    this.labelText,
    this.hintText,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _ownStyle = _theme.textTheme.body1.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    OutlineInputBorder accentLine() {
      return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: _theme.accentColor, width: 2.0),
      );
    }

    OutlineInputBorder commonLine() {
      return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.white70, width: 2.0),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        key: keyForm,
        keyboardType: keyboardType,
        style: _ownStyle,
        obscureText: obsecure,
        validator: validator,
        decoration: InputDecoration(
          hintStyle: _ownStyle,
          labelStyle: _ownStyle,
          focusedBorder: accentLine(),
          enabledBorder: commonLine(),
          border: commonLine(),
          errorBorder: commonLine(),
          prefixIcon: Padding(
            child: IconTheme(
              data: IconThemeData(color: _theme.accentColor),
              child: Icon(icon),
            ),
            padding: EdgeInsets.only(left: 20, right: 10),
          ),
          labelText: labelText,
          hintText: hintText,
        ),
        onSaved: onSaved,
      ),
    );
  }
}
