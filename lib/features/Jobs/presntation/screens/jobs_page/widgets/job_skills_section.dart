import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:flutter/material.dart';

/// "Skills" label + wrap of pill chips.
///
/// JobEntity currently has no `skills` field, so this widget takes the list
/// as an explicit parameter and renders nothing if it's empty. Add e.g.
/// `List<String>? skills` to JobEntity to wire this up for real.
class JobSkillsSection extends StatelessWidget {
  const JobSkillsSection({super.key, required this.skills});

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skills',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills
              .map(
                (skill) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorsManager.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      color: ColorsManager.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
