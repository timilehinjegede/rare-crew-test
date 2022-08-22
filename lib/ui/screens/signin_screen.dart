import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/ui/screens/dashboard/dashboard_container.dart';
import 'package:rare_crew/ui/widgets/widgets.dart';
import 'package:rare_crew/utils/utils.dart';
import 'package:rare_crew/viewmodels/signin_viewmodel.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: hPadding,
            vertical: vPadding * 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const YBox(10),
              const Text(
                'Login to your account',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const YBox(40),
              CustomTextField(
                labelText: 'Email address',
                hintText: 'hello@example.com',
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {},
              ),
              const YBox(20),
              CustomTextField(
                labelText: 'Password',
                hintText: 'Your password',
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                onChanged: (val) {},
              ),
              const YBox(30),
              CustomTextButton(
                title: 'Sign in',
                onPressed: () async {
                  ref.watch(signInViewModelProvider.notifier).signIn();
                  pushTo(context, const DashboardContainer());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
