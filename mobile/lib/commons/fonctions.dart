import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/providers/tokenprovider.dart';

printer(data) {
  if (kDebugMode) {
    print(data);
  }
}

toasterError(data) {
  Fluttertoast.showToast(
    msg: data.toString(),
    toastLength: Toast.LENGTH_LONG,
  );
}

Map<String, dynamic> authorization() => {
      'Content-Type': 'Application/json',
      'Authorization': 'Bearer ${UserProvider.user.tokenuser}'
    };
