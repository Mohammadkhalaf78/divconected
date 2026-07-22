import 'package:dev_connected/features/Jobs/domain/entites/job_entites.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

/// "Remote • Full-time" row, plus the "Posted Xh ago" line underneath.
///
/// Uses `toString().split('.').last` on the enums so it works regardless
/// of what the actual `JobType` / `Location` enum values end up being
/// named in `enums.dart`. Swap this for a proper display-name getter on
/// the enums themselves if you'd prefer (e.g. `job.jobType.label`).
class JobMetaSection extends StatelessWidget {
  const JobMetaSection({super.key, required this.job});

  final JobEntity job;

  String _enumLabel(Object value) {
    final raw = value.toString().split('.').last;
    if (raw.isEmpty) return raw;
    return raw[0].toUpperCase() + raw.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(_enumLabel(job.location), style: TextStyle(color: Colors.grey[700])),
            const SizedBox(width: 12),
            Icon(Icons.work_outline, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(_enumLabel(job.jobType), style: TextStyle(color: Colors.grey[700])),
          ],
        ),
        if (job.createdAt != null) ...[
          const SizedBox(height: 6),
          Text(
            'Posted ${timeago.format(job.createdAt!)}',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ],
    );
  }
}