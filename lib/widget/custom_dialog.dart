import 'package:adolapp/values/strings.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, buttonNo, buttonOkay;
  final Widget body;
  final Function okayAction;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.body,
    this.buttonNo,
    @required this.buttonOkay,
    this.image,
    this.okayAction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(constPadding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: constDialogRadius + constPadding,
            bottom: constPadding,
            left: constPadding,
            right: constPadding,
          ),
          margin: EdgeInsets.only(top: constDialogRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(constPadding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.body1.copyWith(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              body,
              SizedBox(height: 24.0),
              buttonNo != null ?
              Align(
                alignment: Alignment.bottomLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(buttonNo, style: Theme.of(context).textTheme.body1.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),),
                ),
              ) : null,
              Align(
                alignment: Alignment.bottomRight,
                child: RaisedButton(
                  onPressed: okayAction != null ? okayAction : () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(buttonOkay, style: Theme.of(context).textTheme.body1.copyWith(
                    color: Colors.white,
                  ),),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: constPadding,
          right: constPadding,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.info_outline, color: Colors.white,),
            radius: constDialogRadius,
          ),
        ),
      ],
    );
  }
}
