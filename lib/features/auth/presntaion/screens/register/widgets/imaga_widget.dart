import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/main/upload_image/cubit/upload_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.selectedRole});

  final UserRole selectedRole;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadCubit, UploadState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = context.read<UploadCubit>();

        return InkWell(
          onTap: () async {
            await cubit.pickImage();
          },
          child: cubit.selectedImage != null
              ? CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(cubit.selectedImage!),
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundColor: ColorsManager.primary,
                  child: Icon(
                    selectedRole.name == 'developer' ? Icons.person : Icons.business,
                    size: 40,
              color: ColorsManager.white,
            ),
          ),
        );
      },
    
    );
  }
}
