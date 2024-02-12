import 'package:flutter/material.dart';

class JazzCashNumberFormField extends StatelessWidget {
  final TextEditingController controller;

  const JazzCashNumberFormField({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          hintText: 'Enter JazzCash Number',
          border: InputBorder.none,
          icon: Icon(Icons.phone),
        ),
        validator: (value) {
          // You can add more validation if required
          return null;
        },
      ),
    );
  }
}
