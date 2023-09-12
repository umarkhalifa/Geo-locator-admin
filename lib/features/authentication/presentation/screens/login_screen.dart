import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:land_survey/core/constants/sizes.dart';
import 'package:land_survey/features/authentication/presentation/providers/registerProvider.dart';
import 'package:land_survey/features/authentication/presentation/providers/sign_in_notifier.dart';
import 'package:land_survey/utils/validation_extension.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_icons/solar_icons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: Colors.white),
              padding: const EdgeInsets.only(
                top: 30,
                left: 15,
                right: 15,
                bottom: 20,
              ),
              child: const LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulHookConsumerWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(signInNotifier);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    ref.listen(signInNotifier.select((value) => value.status),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Lottie.asset("assets/images/animation'.json",
                fit: BoxFit.cover),
          ),
          const Text(
            "Welcome Back",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          // RichText(
          //   text: TextSpan(
          //     text: "Don't have an account?",
          //     style:
          //         TextStyle(color: Colors.grey.shade800, fontFamily: "Faktum"),
          //     children: [
          //       TextSpan(
          //         recognizer: TapGestureRecognizer()
          //           ..onTap = () {
          //             context.pushNamed(RouterNames.register.name);
          //           },
          //         text: " Register",
          //         style: const TextStyle(
          //           color: Colors.blue,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          gapH24,
          AuthForm(
            label: 'Email Address',
            hint: "Enter your email address",
            iconData: SolarIconsOutline.letter,
            validator: context.validateEmailAddress,
            controller: emailController,
          ),
          AuthForm(
            label: 'Password',
            hint: "Enter your password",
            iconData: SolarIconsOutline.lock,
            validator: context.validatePassword,
            controller: passwordController,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: const Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          gapH20,
          GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate()) {
                ref.read(signInNotifier.notifier).signIn(
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
        ],
      ),
    );
  }
}

class AuthForm extends StatelessWidget {
  final String label;
  final String hint;
  final IconData iconData;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AuthForm(
      {super.key,
      required this.label,
      required this.hint,
      required this.iconData,
      this.validator,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label),
        ),
        gapH4,
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
              prefixIcon: Icon(iconData),
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w100)),
        ),
        gapH20,
      ],
    );
  }
}
