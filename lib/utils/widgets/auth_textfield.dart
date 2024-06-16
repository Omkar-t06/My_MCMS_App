import 'package:flutter/material.dart';

class IdCredencialTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final String label;
  final Icon icon;
  const IdCredencialTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.label,
    required this.icon,
  });

  @override
  State<IdCredencialTextField> createState() => _IdCredencialTextFieldState();
}

class _IdCredencialTextFieldState extends State<IdCredencialTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        label: Text(widget.label),
        hintText: widget.hintText,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      keyboardType: widget.keyboardType,
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
