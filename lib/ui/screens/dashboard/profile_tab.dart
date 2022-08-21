import 'package:flutter/material.dart';
import 'package:rare_crew/ui/widgets/button.dart';
import 'package:rare_crew/ui/widgets/textfield.dart';
import 'package:rare_crew/utils/utils.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rareCrewColors.background,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: hPadding,
          vertical: vPadding,
        ),
        child: Column(
          children: [
            AtsTextField(
              labelText: 'First name',
              hintText: 'MyFirstName',
              keyboardType: TextInputType.text,
              onChanged: (val) {},
            ),
            const YBox(20),
            AtsTextField(
              labelText: 'Last name',
              hintText: 'MyLastName',
              keyboardType: TextInputType.text,
              onChanged: (val) {},
            ),
            const YBox(20),
            AtsTextField(
              labelText: 'Email address',
              hintText: 'hello@example.com',
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) {},
            ),
            const YBox(50),
            AtsTextButton(
              title: 'Logout',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
