import 'package:flutter/material.dart';

class ToDoCard extends StatelessWidget {
  final String title;
  final String? details;
  final bool isCompleted;
  final void Function()? onTap;

  const ToDoCard({
    super.key,
    required this.title,
    this.details,
    required this.isCompleted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent.withAlpha(255 ~/ 3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  decoration: isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            if (details != null)
              Expanded(
                child: Text(
                  details!,
                  style: TextStyle(
                    color: Colors.transparent.withAlpha(255 ~/ 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
