import 'package:dev_connected/core/constance/widgets/app_top_snackbar.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/home_feed/presntation/controller/bloc/home_feed_bloc.dart';
import 'package:dev_connected/features/main/ipload_image/cubit/upload_cubit.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostPage extends StatelessWidget {
  final UserEntity? user;
  final TextEditingController postContentController = TextEditingController();
  final TextEditingController postImageController = TextEditingController();
  CreatePostPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeFeedBloc, HomeFeedState>(
          listener: (context, state) {
            if (state.createPostState == RequestState.loaded) {
              AppTopSnackBar.success(
                context,
                message: 'Post created successfully!',
              );
              Navigator.pop(context);
            } else if (state.createPostState == RequestState.error) {
               debugPrint('ERROR: ${state.createPostMessage}');
              AppTopSnackBar.error(context, message: state.createPostMessage);
            }
          },
        ),

        // listener for upload cubit
        BlocListener<UploadCubit, UploadState>(
          listener: (context, state) {
            if (state is UploadSuccess) {
              // Image uploaded successfully, now create the post with the image URL
              context.read<HomeFeedBloc>().add(
                CreatePostRequested(
                  postContent: postContentController.text,
                  postImage: state.imageUrl,
                  userImage: user?.imageUrl,
                  userName: user?.fullName ?? 'User',
                ),
              );
            } else if (state is UploadFailure) {
              AppTopSnackBar.error(context, message: state.message);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: ColorsManager.white,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,

          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: ColorsManager.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          title: const Text(
            "Create Post",
            style: TextStyle(
              color: ColorsManager.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
                onPressed: () async {
                  final uploadCubit = context.read<UploadCubit>();

                  if (uploadCubit.selectedImage != null) {
                    // فيه صورة متختارة - ارفعها الأول
                    await uploadCubit.uploadImage(uploadCubit.selectedImage!);
                  } else {
                    // مفيش صورة - كمّل بالـ URL اليدوي أو من غيرها
                    context.read<HomeFeedBloc>().add(
                      CreatePostRequested(
                        postContent: postContentController.text,
                        postImage: postImageController.text,
                        userImage: user?.imageUrl,
                        userName: user?.fullName ?? 'User',
                      ),
                    );
                  }
                },

                child: const Text(
                  "Post",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// User Info
              UserHeader(user: user),

              const SizedBox(height: 20),

              /// Post Text Field
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(color: Colors.grey.shade200),
                ),

                child: TextField(
                  maxLines: 6,
                  controller: postContentController,

                  decoration: InputDecoration(
                    border: InputBorder.none,

                    hintText:
                        "Share your coding journey...\n"
                        "Talk about your projects, ideas or experience",

                    hintStyle: TextStyle(
                      color: ColorsManager.grey,
                      height: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Image Picker
              const ImagePickerCard(),

              const SizedBox(height: 20),

              /// Image URL Text Field
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(color: Colors.grey.shade200),
                ),

                child: TextField(
                  controller: postImageController,

                  decoration: InputDecoration(
                    border: InputBorder.none,

                    hintText: "Enter image URL for your post (optional)",

                    hintStyle: TextStyle(
                      color: ColorsManager.grey,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Attachment Title
              const Text(
                "Add to your post",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: ColorsManager.black,
                ),
              ),

              const SizedBox(height: 12),

              /// Actions
              const PostActions(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserHeader extends StatelessWidget {
  final UserEntity? user;
  const UserHeader({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,

          decoration: const BoxDecoration(
            shape: BoxShape.circle,

            gradient: LinearGradient(
              colors: [ColorsManager.primary, ColorsManager.secondary],
            ),
          ),

          child: Center(
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                user?.imageUrl ??
                    'https://imgcdn.stablediffusionweb.com/2024/10/10/dfbf7741-3f6f-478d-b658-f7454c72f33a.jpg',
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              user?.fullName ?? 'User',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: ColorsManager.black,
              ),
            ),

            SizedBox(height: 4),

            Text(
              "Flutter Developer",
              style: TextStyle(color: ColorsManager.grey, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}

class ImagePickerCard extends StatelessWidget {
  const ImagePickerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadCubit, UploadState>(
      builder: (context, state) {
        final cubit = context.read<UploadCubit>();
        return GestureDetector(
          onTap: () {
            cubit.pickImage();
          },
          child: Container(
            height: 180,
            width: double.infinity,

            decoration: BoxDecoration(
              color: ColorsManager.primary.withAlpha((.05 * 255).round()),

              borderRadius: BorderRadius.circular(16),

              border: Border.all(
                color: ColorsManager.primary.withAlpha((.2 * 255).round()),
              ),
            ),

            child: cubit.selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      cubit.selectedImage!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                        width: 55,
                        height: 55,

                        decoration: BoxDecoration(
                          color: ColorsManager.primary.withAlpha(
                            (.1 * 255).round(),
                          ),

                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.add_photo_alternate_outlined,

                          size: 28,

                          color: ColorsManager.primary,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "Add Image",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ColorsManager.black,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "Upload your project screenshot\nor achievement",
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          fontSize: 12,
                          color: ColorsManager.grey,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class PostActions extends StatelessWidget {
  const PostActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: const [
          PostActionItem(
            icon: Icons.image_outlined,
            title: "Photo",
            color: ColorsManager.green,
          ),

          PostActionItem(
            icon: Icons.code,
            title: "Project",
            color: ColorsManager.primary,
          ),

          PostActionItem(
            icon: Icons.link,
            title: "Link",
            color: ColorsManager.blue,
          ),
        ],
      ),
    );
  }
}

class PostActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const PostActionItem({
    super.key,

    required this.icon,

    required this.title,

    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 42,
          height: 42,

          decoration: BoxDecoration(
            color: color.withAlpha((.12 * 255).round()),

            shape: BoxShape.circle,
          ),

          child: Icon(icon, color: color, size: 22),
        ),

        const SizedBox(height: 6),

        Text(
          title,

          style: const TextStyle(
            fontSize: 12,
            color: ColorsManager.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
