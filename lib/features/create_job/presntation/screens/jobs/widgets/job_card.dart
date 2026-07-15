import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.grey,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage(
            'https://cdn.freebiesupply.com/logos/large/2x/google-icon-logo-png-transparent.png',
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter Developer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Company',
              style: TextStyle(fontSize: 14, color: ColorsManager.black),
            ),

            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: ColorsManager.grey,
                ),
                SizedBox(width: 4),
                Text(
                  'Location',
                  style: TextStyle(fontSize: 14, color: ColorsManager.grey),
                ),

                SizedBox(width: 24),

                Icon(Icons.work_outlined, size: 14, color: ColorsManager.grey),
                SizedBox(width: 4),
                Text(
                  'Full-time',
                  style: TextStyle(fontSize: 14, color: ColorsManager.grey),
                ),
              ],
            ),
            Text(
              ' \$80,000 - \$100,000',
              style: TextStyle(
                fontSize: 14,
                color: ColorsManager.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        trailing: Column(
          children: [
            Icon(Icons.bookmark_border, color: ColorsManager.primary),
            Spacer(),
            Text(
              '2 d ago',
              style: TextStyle(fontSize: 12, color: ColorsManager.grey),
            ),
          ],
        ),
      ),
    );
  }
}
