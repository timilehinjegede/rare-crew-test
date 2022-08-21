import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/ui/screens/dashboard/home_tab.dart';
import 'package:rare_crew/ui/screens/dashboard/profile_tab.dart';
import 'package:rare_crew/ui/widgets/widgets.dart';
import 'package:rare_crew/utils/utils.dart';
import 'package:rare_crew/viewmodels/job_viewmodels.dart';

class DashboardContainer extends HookConsumerWidget {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentIndex = useState(0);

    return Scaffold(
      backgroundColor: rareCrewColors.grey,
      bottomNavigationBar: RareCrewBottomNav(
        items: const [
          BottomNavItem.home,
          BottomNavItem.profile,
        ],
        onItemSelected: (newIndex) {
          currentIndex.value = newIndex;
        },
        currentIndex: currentIndex.value,
      ),
      appBar: AtsHomeCustomAppBar(
        title: currentIndex.value == 0 ? 'My Jobs' : 'My Profile',
        titleValue: currentIndex.value == 0 ? ref.watch(jobsListProvider).length : null,
        onAvatarTapped: () {
          if (currentIndex.value != 1) {
            currentIndex.value = 1;
          }
        },
      ),
      body: const [
        HomeTab(),
        ProfileTab(),
      ].elementAt(currentIndex.value),
      floatingActionButton: currentIndex.value == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  builder: (_) => const JobFormWidget(),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add a job'),
            )
          : null,
    );
  }
}
