import 'package:dev_connected/features/Jobs/domain/entites/job_entites.dart';
import 'package:flutter/material.dart';

/// Company logo + job title + company name, as shown at the top of the card.
class JobHeaderSection extends StatelessWidget {
  const JobHeaderSection({super.key, required this.job});

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CompanyLogo(imageUrl: job.companyImage),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (job.companyName != null) ...[
                const SizedBox(height: 4),
                Text(
                  job.companyName!,
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  const _CompanyLogo({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.business, color: Colors.grey),
            )
          : const Icon(Icons.business, color: Colors.grey),
    );
  }
}
