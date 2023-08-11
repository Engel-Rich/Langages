import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SchimmerWidget extends StatelessWidget {
  final double hauteur, largeur;
  final ShapeBorder shapeBorder;

  const SchimmerWidget(
      {super.key,
      required this.hauteur,
      required this.largeur,
      required this.shapeBorder});

  const SchimmerWidget.rectangular(
      {super.key, required this.hauteur, required this.largeur})
      : shapeBorder = const RoundedRectangleBorder();

  const SchimmerWidget.circle({
    super.key,
    required this.hauteur,
    required this.largeur,
    required this.shapeBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade100,
      period: const Duration(milliseconds: 2500),
      child: Container(
        height: hauteur,
        width: largeur,
        decoration: ShapeDecoration(
          shape: shapeBorder,
          color: Colors.red.shade300,
        ),
      ),
    );
  }
}
