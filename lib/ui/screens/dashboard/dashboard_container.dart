import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rare_crew/ui/screens/add_job_screen.dart';
import 'package:rare_crew/ui/screens/dashboard/home_tab.dart';
import 'package:rare_crew/ui/screens/dashboard/profile_tab.dart';
import 'package:rare_crew/ui/widgets/widgets.dart';
import 'package:rare_crew/utils/theme.dart';
import 'package:rare_crew/utils/utils.dart';

class DashboardContainer extends StatefulWidget {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  State<DashboardContainer> createState() => _DashboardContainerState();
}

class _DashboardContainerState extends State<DashboardContainer> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rareCrewColors.grey,
      bottomNavigationBar: RareCrewBottomNav(
        items: const [
          BottomNavItem.home,
          BottomNavItem.profile,
        ],
        onItemSelected: (newIndex) {
          log('newIndex: $newIndex');
          setState(() {
            _currentIndex = newIndex;
          });
        },
        currentIndex: _currentIndex,
      ),
      appBar: AtsHomeCustomAppBar(
        title: _currentIndex == 0 ? 'My Items' : 'My Profile',
        titleValue: _currentIndex == 0 ? 10 : null,
        onAvatarTapped: () {
          if (_currentIndex != 1) {
            setState(() {
              _currentIndex = 1;
            });
          }
        },
      ),
      body: const [
        HomeTab(),
        ProfileTab(),
      ].elementAt(_currentIndex),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                pushTo(
                  context,
                  const AddJobScreen(),
                );
              },
              icon: const Icon(Icons.add),
              label: Text('Add a job'),
            )
          : null,
    );
  }
}
