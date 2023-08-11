import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/models/langues.dart';
import 'package:mobile/models/lecon_model.dart';
import 'package:mobile/models/module.dart';
import 'package:mobile/views/sreens/lecture.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

TextStyle primarystyle = GoogleFonts.poppins(fontSize: 15);

spacerheight(val) => SizedBox(height: double.parse(val.toString()));
spacerwidth(val) => SizedBox(width: double.parse(val.toString()));
Size taille(context) => MediaQuery.sizeOf(context);

TextStyle primarystyle17 = GoogleFonts.poppins(fontSize: 17);

// inputAppp() => TextFormField() ;

Widget leconModel(
    Color colors, String leconName, String leconTitle, leconDescription) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blue.shade100,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      title: Text(
        leconTitle,
        style: primarystyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle:
          Text(leconDescription, overflow: TextOverflow.ellipsis, maxLines: 2),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            leconName,
            style: primarystyle.copyWith(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

Widget leconModelReading(BuildContext context, Lecon lecon, Langue langue,
    {double percent = 50 / 100, required Module module}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blue[50],
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              child: LectureScreen(lecon: lecon, module: module),
              type: PageTransitionType.leftToRight),
        );
      },
      trailing: CircularPercentIndicator(
        radius: 25,
        percent: percent,
        progressColor: Colors.green,
        center: Text(
          '${(percent * 100).toInt()}%',
          style: GoogleFonts.poppins(),
        ),
      ),
      title: Text(
        lecon.lecon_title,
        style: primarystyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(lecon.lecon_description ?? '',
          overflow: TextOverflow.ellipsis, maxLines: 2),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: selColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            langue.langue_name.substring(1, 3),
            style: primarystyle.copyWith(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

List<Color> colors = [
  Colors.orange,
  Colors.purple,
  Colors.green,
  Colors.indigo,
  Colors.blue,
  Colors.brown,
  Colors.red,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.teal,
  Colors.yellow.shade900,
  Colors.blueGrey,
  Colors.lime.shade900,
  Colors.pink,
];

Color selColor() => (colors..shuffle()).first;
