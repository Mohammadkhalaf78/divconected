import 'package:flutter/material.dart';

/// Simple back / bookmark bar shown at the top of the job details screen.
class JobDetailsAppBar extends StatelessWidget {
  const JobDetailsAppBar({super.key, this.onBookmarkTap});

  final VoidCallback? onBookmarkTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(24),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.arrow_back_ios_new, size: 20),
            ),
          ),
          InkWell(
            onTap: onBookmarkTap,
            borderRadius: BorderRadius.circular(24),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.bookmark_border, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}
