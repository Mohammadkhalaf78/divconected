import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:flutter/material.dart';

class CreatePostPage extends StatelessWidget {
  final UserEntity? user;
  const CreatePostPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () {},

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
            const UserHeader(),

            const SizedBox(height: 20),

            /// Post Text Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),

                border: Border.all(color: Colors.grey.shade200),
              ),

              child: const TextField(
                maxLines: 6,

                decoration: InputDecoration(
                  border: InputBorder.none,

                  hintText:
                      "Share your coding journey...\n"
                      "Talk about your projects, ideas or experience",

                  hintStyle: TextStyle(color: ColorsManager.grey, height: 1.5),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Image Picker
            const ImagePickerCard(),

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
                user?.imageUrl ?? 'https://imgcdn.stablediffusionweb.com/2024/10/10/dfbf7741-3f6f-478d-b658-f7454c72f33a.jpg',
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
    return Container(
      height: 180,
      width: double.infinity,

      decoration: BoxDecoration(
        color: ColorsManager.primary.withOpacity(.05),

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: ColorsManager.primary.withOpacity(.2)),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            width: 55,
            height: 55,

            decoration: BoxDecoration(
              color: ColorsManager.primary.withOpacity(.1),

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

            style: TextStyle(fontSize: 12, color: ColorsManager.grey),
          ),
        ],
      ),
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
            color: color.withOpacity(.12),

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
