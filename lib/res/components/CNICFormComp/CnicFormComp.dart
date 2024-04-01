import 'package:flutter/material.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

import '../AddNeedyPeople/addNeedyPeopleComp.dart';

class CnicFormComp extends StatelessWidget {
  final TextEditingController cardHoldername;
  final TextEditingController cnicno;
  final TextEditingController doIssue;
  final TextEditingController doExpire;
  final TextEditingController doBirth;
  const CnicFormComp(
      {super.key,
      required this.cardHoldername,
      required this.doIssue,
      required this.doExpire,
      required this.doBirth,
      required this.cnicno});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddNeedyPeopleComp(
            title: 'Card Holder Name',
            icon: Icons.person,
            hint: 'Masab / Ayesha',
            controller: cardHoldername),
        AddNeedyPeopleComp(
            title: 'CNIC Number',
            icon: Icons.person,
            hint: '352020-4545452-1',
            controller: cnicno),
        Row(
          children: [
            Expanded(
              child: AddNeedyPeopleComp(
                  title: 'Date of Issue',
                  hint: 'DD/MM/YYYY',
                  icon: Icons.dataset,
                  controller: doIssue),
            ),
            Expanded(
              child: AddNeedyPeopleComp(
                  title: 'Date of Expire',
                  hint: 'DD/MM/YYYY',
                  icon: Icons.person,
                  controller: doExpire),
            ),
          ],
        ),
        AddNeedyPeopleComp(
            title: 'Date of Birth',
            icon: Icons.person,
            hint: 'DD/MM/YYYY',
            controller: doBirth),
        0.02.ph,
        
      ],
    );
  }
}
