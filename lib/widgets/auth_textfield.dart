import 'package:flutter/material.dart';

class EmailTextField extends StatefulWidget {
  final TextEditingController controller;
  const EmailTextField({super.key, required this.controller});

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email_rounded),
        label: Text("Email"),
        hintText: "Enter Your Email",
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      controller: widget.controller,
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordTextField({super.key, required this.controller});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_rounded),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          icon: isObscure
              ? const Icon(Icons.visibility_off_outlined)
              : const Icon(Icons.visibility),
        ),
        label: const Text("Password"),
        hintText: "Enter Your Password",
        filled: true,
      ),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      obscureText: isObscure,
      controller: widget.controller,
    );
  }
}
