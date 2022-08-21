import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/ui/screens/signin_screen.dart';
import 'package:rare_crew/ui/widgets/button.dart';
import 'package:rare_crew/ui/widgets/textfield.dart';
import 'package:rare_crew/utils/utils.dart';
import 'package:rare_crew/viewmodels/profile_viewmodel.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileViewModel = ref.watch(profileViewModelProvider);

    return Container(
      color: rareCrewColors.background,
      height: double.infinity,
      child: profileViewModel.when(
        data: (data) {
          final user = data!;
          log('user is ${user.email}');

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: hPadding,
              vertical: vPadding,
            ),
            child: Column(
              children: [
                AtsTextField(
                  initialValue: user.firstName,
                  labelText: 'First name',
                  hintText: 'MyFirstName',
                  keyboardType: TextInputType.text,
                  readOnly: true,
                ),
                const YBox(20),
                AtsTextField(
                  initialValue: user.lastName,
                  labelText: 'Last name',
                  hintText: 'MyLastName',
                  keyboardType: TextInputType.text,
                  readOnly: true,
                ),
                const YBox(20),
                AtsTextField(
                  initialValue: user.email,
                  labelText: 'Email address',
                  hintText: 'hello@example.com',
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                ),
                const YBox(20),
                AtsTextField(
                  initialValue: user.phone,
                  labelText: 'Phone',
                  hintText: '+44 0000000000',
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                ),
                const YBox(50),
                AtsTextButton(
                  title: 'Logout',
                  onPressed: () {
                    // remove token
                    ref.read(profileViewModelProvider.notifier).signOut();
                    pushToAndClearStack(
                      context,
                      const SignInScreen(),
                    );
                  },
                ),
              ],
            ),
          );
        },
        error: (err, _) => Center(
          child: Text(
            err.toString(),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
