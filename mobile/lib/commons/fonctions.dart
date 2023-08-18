import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/commons/style.dart';
import 'package:mobile/providers/data_providers.dart';

printer(data) {
  if (kDebugMode) {
    print(data);
  }
}

toasterError(BuildContext context, message) {
  final SnackBar bar = SnackBar(
    content: Text(
      message.toString(),
      style: primarystyle,
    ),
    elevation: 0.0,
    width: 300,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: Colors.red,
    padding: const EdgeInsets.all(8),
    // margin: const EdgeInsets.all(40),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(bar);
}

toasterSucces(BuildContext context, message) {
  final SnackBar bar = SnackBar(
    content: Text(
      message.toString(),
      style: primarystyle17,
    ),
    elevation: 0.0,
    width: 300,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: Colors.green,
    padding: const EdgeInsets.all(8),
    // margin: const EdgeInsets.all(40),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(bar);
}

authorization() => {
      'Accept': 'application/Json',
      "Authorization": "Bearer ${UserProvider.user.tokenuser}"
    };
