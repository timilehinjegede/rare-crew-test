import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/ui/widgets/widgets.dart';
import 'package:rare_crew/utils/utils.dart';
import 'package:rare_crew/viewmodels/job_viewmodels.dart';

class HomeTab extends HookConsumerWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsList = ref.watch(jobsListProvider);

    return jobsList.isEmpty
        ? const Center(
            child: Text(
              'Click + to add a job',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: hPadding,
              vertical: vPadding,
            ),
            itemBuilder: (_, index) => JobItemCard(
              job: jobsList[index],
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  builder: (_) => JobFormWidget(
                    job: jobsList[index],
                  ),
                );
              },
            ),
            separatorBuilder: (_, __) => const YBox(20),
            itemCount: jobsList.length,
          );
  }
}
