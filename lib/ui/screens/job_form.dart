import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/models/job_dto.dart';
import 'package:rare_crew/ui/widgets/widgets.dart';
import 'package:rare_crew/utils/utils.dart';
import 'package:rare_crew/viewmodels/job_form_viewmodel.dart';
import 'package:rare_crew/viewmodels/job_viewmodels.dart';
import 'package:uuid/uuid.dart';

class JobFormScreen extends HookConsumerWidget {
  const JobFormScreen({
    Key? key,
    this.job,
  }) : super(key: key);

  final Job? job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobFormViewModel = ref.watch(jobFormProvider(job));

    return Scaffold(
      appBar: CustomAppBar(
        title:
            jobFormViewModel.isNewJob ? 'Create job offer' : 'Edit job offer',
        onLeadingTapped: () => pop(context),
        actions: [
          if (!jobFormViewModel.isNewJob)
            CustomTextButton(
              title: 'Update',
              size: const Size(70, 40),
              buttonColor: rareCrewColors.purple,
              textColor: rareCrewColors.background,
              radius: 25,
              onPressed: () async {
                jobFormViewModel.createOrEditJob();
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
            CustomTextField(
              initialValue: jobFormViewModel.jobTitle,
              labelText: 'Job title',
              hintText: 'Ex: Software engineer',
              keyboardType: TextInputType.text,
              onChanged: (val) {
                if (val.isNotEmpty) {
                  jobFormViewModel.jobTitle = val;
                }
              },
            ),
            const YBox(25),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    initialValue: (jobFormViewModel.minSalary == 0
                            ? ''
                            : jobFormViewModel.minSalary)
                        .toString(),
                    labelText: 'Minimum salary range',
                    hintText: '0',
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        jobFormViewModel.minSalary = int.parse(val);
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                const XBox(15),
                Expanded(
                  child: CustomTextField(
                    initialValue: (jobFormViewModel.maxSalary == 0
                            ? ''
                            : jobFormViewModel.maxSalary)
                        .toString(),
                    labelText: 'Maximum salary range',
                    hintText: '0',
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        jobFormViewModel.maxSalary = int.parse(val);
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ],
            ),
            const YBox(50),
            if (jobFormViewModel.isNewJob)
              CustomTextButton(
                title: 'Create job offer',
                onPressed: () async {
                  final Job job = Job(
                    id: const Uuid().v4(),
                    jobTitle: jobFormViewModel.jobTitle,
                    minSalary: jobFormViewModel.minSalary,
                    maxSalary: jobFormViewModel.maxSalary,
                    createdAt: DateTime.now().toIso8601String(),
                  );
                  ref.watch(jobsListProvider.notifier).addJob(job);
                  jobFormViewModel.resetFields();
                  pop(context);
                },
              )
            else
              CustomTextButton(
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
                            CustomTextButton(
                              title: 'Yes, delete',
                              buttonColor: rareCrewColors.lightRed,
                              textColor: rareCrewColors.red,
                              onPressed: () async {
                                jobFormViewModel.deleteJob();
                                pop(context);
                                pop(context);
                              },
                            ),
                            const YBox(15),
                            CustomTextButton(
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
