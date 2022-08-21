import 'package:flutter/material.dart';
import 'package:rare_crew/ui/screens/add_job_screen.dart';
import 'package:rare_crew/ui/screens/edit_job_screen.dart';
import 'package:rare_crew/ui/widgets/widgets.dart';
import 'package:rare_crew/utils/utils.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: hPadding,
        vertical: vPadding,
      ),
      itemBuilder: (_, index) => JobItemCard(
        // jobOpening: jobsResult.data![index],
        onTap: () {
          pushTo(
            context,
            const EditJobScreen(),
          );
        },
      ),
      separatorBuilder: (_, __) => const YBox(20),
      itemCount: 10,
    );
  }
}
