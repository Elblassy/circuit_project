
import 'package:flutter/cupertino.dart';

Future<bool?> showPickerDialog(BuildContext context) async{

  final action = CupertinoActionSheet(
    message: Text("Choose Circuit Source"),
    actions: <Widget>[
      CupertinoActionSheetAction(
        child: Text("Use Camera"),
        isDefaultAction: true,
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
      CupertinoActionSheetAction(
        child: Text("Choose Picture"),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
      CupertinoActionSheetAction(
        child: Text("Cancel"),
        isDestructiveAction: true,
        onPressed: () {
          Navigator.of(context).pop(null);
        },
      )
    ],
  );


  final result = await showCupertinoModalPopup(
      context: context, builder: (context) => action);


  return result;

}