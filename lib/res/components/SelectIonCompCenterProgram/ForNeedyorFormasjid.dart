import 'package:flutter/material.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';



class ForNeedyAndForMasjidComp extends StatelessWidget {
  final Color color;
  final String title;
  final Widget traling;
  const ForNeedyAndForMasjidComp(
      {super.key,
      required this.color,
      required this.title,
      required this.traling});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.mw * 0.04,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.mw * 0.03,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: color,
                width: 2.0,
              ),
            ),
            title: Text(title),
            trailing: traling,
          ),
        )
      ],
    );
  }
}
