import 'package:flutter/material.dart';

/// "Requirements" label + a check-mark list.
///
/// JobEntity.requirements is a single String rather than a List<String>,
/// so this splits on newlines/commas to build the list. If you can, change
/// `requirements` on JobEntity to `List<String>` instead — it'll be more
/// robust than splitting a free-text string.
class JobRequirementsSection extends StatelessWidget {
  const JobRequirementsSection({super.key, required this.requirements});

  final String requirements;

  List<String> get _items => requirements
      .split(RegExp(r'[\n,]'))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  @override
  Widget build(BuildContext context) {
    final items = _items;
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Requirements',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
