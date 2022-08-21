import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rare_crew/ui/screens/dashboard/dashboard_container.dart';
import 'package:rare_crew/ui/widgets/widgets.dart';
import 'package:rare_crew/utils/utils.dart';

class EditJobScreen extends StatelessWidget {
  const EditJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AtsCustomAppBar(
        title: 'Edit job offer',
        onLeadingTapped: () => pop(context),
        actions: [
          AtsTextButton(
            title: 'Update',
            size: const Size(70, 40),
            buttonColor: rareCrewColors.purple,
            textColor: rareCrewColors.background,
            radius: 25,
            // isLoading: store.state.isLoading,
            // disabled: !_buttonValidation(),
            onPressed: () async {
              // await updateJob(context);
              pop(context);
            },
          ),
        ],
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
              // controller: _jobTitleController,
              onChanged: (val) {},
              labelText: 'Job title',
              hintText: 'Ex: Software engineer',
              keyboardType: TextInputType.text,
            ),
            const YBox(25),
            Row(
              children: [
                Expanded(
                  child: AtsTextField(
                    // controller: _minimumSalaryController,
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
                    // controller: _maximumSalaryController,
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
              title: '',
              titleWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete_outline_rounded,
                    color: rareCrewColors.red,
                  ),
                  const XBox(10),
                  const Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              textColor: rareCrewColors.red,
              buttonColor: rareCrewColors.lightRed,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.symmetric(
                        horizontal: hPadding,
                        vertical: vPadding / 2,
                      ),
                      title: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                pop(context);
                              },
                              customBorder: const CircleBorder(),
                              child: const Icon(
                                Icons.close_rounded,
                                size: 30,
                              ),
                            ),
                          ),
                          const YBox(10),
                          const Text(
                            'Delete job offer',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const YBox(10),
                          const Text(
                            'Are you sure you want to delete\nthis job offer',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const YBox(25),
                          AtsTextButton(
                            title: 'Yes, delete',
                            buttonColor: rareCrewColors.lightRed,
                            textColor: rareCrewColors.red,
                            // isLoading: store.state.isLoading,
                            onPressed: () async {
                              // pop(context);
                              pop(context);
                              pushTo(context, DashboardContainer());
                            },
                          ),
                          const YBox(15),
                          AtsTextButton(
                            title: 'No, cancel',
                            buttonColor: rareCrewColors.background,
                            textColor: rareCrewColors.black,
                            onPressed: () {
                              pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
