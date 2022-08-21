import 'package:flutter/material.dart';
import 'package:rare_crew/ui/screens/dashboard/dashboard_container.dart';
import 'package:rare_crew/ui/widgets/widgets.dart';
import 'package:rare_crew/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              AtsTextField(
                labelText: 'Email address',
                hintText: 'hello@example.com',
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {},
              ),
              const YBox(20),
              AtsTextField(
                labelText: 'Password',
                hintText: 'Your password',
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                onChanged: (val) {},
              ),
              const YBox(30),
              AtsTextButton(
                title: 'Sign in',
                // isLoading: store.state.isLoading,
                // disabled: !_emailAndPasswordValidation(),
                onPressed: () async {
                  pushTo(context, const DashboardContainer());
                },
                buttonColor: rareCrewColors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
