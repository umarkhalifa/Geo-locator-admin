import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:land_survey/core/constants/sizes.dart';
import 'package:land_survey/features/authentication/presentation/providers/registerProvider.dart';
import 'package:land_survey/features/authentication/presentation/screens/login_screen.dart';
import 'package:land_survey/utils/validation_extension.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_icons/solar_icons.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white),
            padding:
                const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 20),
            child: const RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulHookConsumerWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerNotifier);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    ref.listen(registerNotifier.select((value) => value.status),
        (previous, next) {
      if (next == AuthState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(registerState.errorMessage),
          ),
        );
      }
    });
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Lottie.asset("assets/images/animation'.json",
                fit: BoxFit.cover),
          ),
          const Text(
            "Create an account",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          RichText(
            text: TextSpan(
              text: "Already have an account?",
              style:
                  TextStyle(color: Colors.grey.shade800, fontFamily: "Faktum"),
              children: [
                TextSpan(
                  text: " Sign In",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.pop();
                    },
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
          gapH24,
          AuthForm(
            label: 'Email Address',
            hint: "Enter your email address",
            controller: emailController,
            iconData: SolarIconsOutline.letter,
            validator: context.validateEmailAddress,
          ),
          AuthForm(
            label: 'Password',
            hint: "Enter your password",
            controller: passwordController,
            iconData: SolarIconsOutline.lock,
            validator: context.validatePassword,
          ),
          AuthForm(
            label: 'Password',
            hint: "Repeat your password",
            iconData: SolarIconsOutline.lock,
            validator: context.validatePassword,
          ),
          gapH20,
          GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate()) {
                ref.read(registerNotifier.notifier).register(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
              }
            },
            child: Material(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 56,
                width: MediaQuery.sizeOf(context).width,
                child: Center(
                  child: registerState.status == AuthState.loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                ),
              ),
            ),
          ),
          gapH24
        ],
      ),
    );
  }
}
