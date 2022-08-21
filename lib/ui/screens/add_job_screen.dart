import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rare_crew/ui/widgets/widgets.dart';
import 'package:rare_crew/utils/utils.dart';

class AddJobScreen extends StatelessWidget {
  const AddJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AtsCustomAppBar(
        title: 'Create job offer',
        onLeadingTapped: () => pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: hPadding,
          vertical: vPadding,
        ),
        child: Column(
          children: [
            const YBox(20),
            AtsTextField(
              labelText: 'Job title',
              hintText: 'Ex: Software engineer',
              keyboardType: TextInputType.text,
              onChanged: (val) {},
            ),
            const YBox(25),
            Row(
              children: [
                Expanded(
                  child: AtsTextField(
                    labelText: 'Minimum salary range',
                    hintText: '0',
                    keyboardType: TextInputType.number,
                    onChanged: (val) {},
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                const XBox(15),
                Expanded(
                  child: AtsTextField(
                    labelText: 'Maximum salary range',
                    hintText: '0',
                    keyboardType: TextInputType.number,
                    onChanged: (val) {},
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ],
            ),
            const YBox(50),
            AtsTextButton(
              title: 'Create job offer',
              // isLoading: store.state.isLoading,
              onPressed: () async {},
              // disabled: !_buttonValidation(),
            ),
          ],
        ),
      ),
    );
  }
}
