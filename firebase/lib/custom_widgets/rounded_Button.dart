// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  String title = '';
  final VoidCallback onTap;
  bool loading;
  RoundedButton({
    super.key,
    required this.title,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child:
                loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(title, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
