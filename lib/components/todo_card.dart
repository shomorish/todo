import 'package:flutter/material.dart';

class ToDoCard extends StatelessWidget {
  final String title;
  final String? details;
  final bool isCompleted;
  final void Function() onDelete;
  final void Function()? onTap;

  const ToDoCard({
    super.key,
    required this.title,
    this.details,
    required this.isCompleted,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Ink(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withAlpha(255 ~/ 3),
              ),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (details != null)
                  Expanded(
                    child: Text(
                      details!,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(255 ~/ 2),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Delete button.
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
