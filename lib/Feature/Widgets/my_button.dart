import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterecommerceapp/Views/Colors.dart';

class MyButton extends ConsumerStatefulWidget {
  final VoidCallback? onTab;
  final String buttonText;
  final Color? color;

  const MyButton({
    super.key,
    required this.onTab,
    required this.buttonText,
    this.color = Colors.blueAccent,
  });

  @override
  ConsumerState<MyButton> createState() => _MyButton();
}

class _MyButton extends ConsumerState<MyButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: widget.onTab,
        child: Text(
          widget.buttonText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
