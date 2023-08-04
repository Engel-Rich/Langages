import 'package:flutter/material.dart';
import 'package:mobile/commons/style.dart';

ElevatedButton bouttonCommun({
  Key? key,
  required String tittle,
  required void Function()? onPressed,
  void Function()? onLongPress,
  void Function(bool)? onHover,
  void Function(bool)? onFocusChange,
  ButtonStyle? style,
  FocusNode? focusNode,
  bool autofocus = false,
  Clip clipBehavior = Clip.none,
  MaterialStatesController? statesController,
  // required Widget? child,
}) =>
    ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      child: Text(tittle, style: primarystyle),
    );

Widget button2(
  String title,
  void Function()? onPressed,
) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(
      title,
      style: primarystyle,
    ),
  );
}
