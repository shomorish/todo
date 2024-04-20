import 'package:flutter/material.dart';

class LeftRightRow extends StatelessWidget {
  final Widget left;
  final Widget? right;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const LeftRightRow({
    super.key,
    this.onTap,
    this.padding,
    required this.left,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              left,
              if (right != null) right!,
            ],
          ),
        ),
      ),
    );
  }
}
