import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/features/Jobs/domain/entites/job_entites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class JobCard extends StatelessWidget {
  final JobEntity? job;
  const JobCard({super.key, this.job});

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
          backgroundImage:
              job?.companyImage != null && job!.companyImage!.isNotEmpty
              ? NetworkImage(job!.companyImage!)
              : AssetImage('assets/images/hiring.jpg') as ImageProvider,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job?.title ?? 'Flutter Developer',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              job?.companyName ?? 'Company',
              style: TextStyle(fontSize: 15.sp, color: ColorsManager.black),
            ),

            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 12.sp,
                  color: ColorsManager.grey,
                ),
                SizedBox(width: 4),
                Text(
                  job?.location.name ?? 'Location',
                  style: TextStyle(fontSize: 9.sp, color: ColorsManager.grey),
                ),

                SizedBox(width: 12),

                Icon(Icons.work_outlined, size: 14, color: ColorsManager.grey),
                SizedBox(width: 4),
                Text(
                  // use screen util to make the text responsive
                  job?.jobType.name ?? 'Full-time',
                  style: TextStyle(fontSize: 11.sp, color: ColorsManager.grey),
                ),
              ],
            ),
            Text(
              job?.salaryRange != null && job!.salaryRange.isNotEmpty
                  ? "${job?.salaryRange}\$"
                  : ' \$80,000 - \$100,000',
              style: TextStyle(
                fontSize: 14.sp,
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
              job?.createdAt != null ? timeago.format(job!.createdAt!) : '',
              style: TextStyle(fontSize: 12, color: ColorsManager.grey),
            ),
          ],
        ),
      ),
    );
  }
}
