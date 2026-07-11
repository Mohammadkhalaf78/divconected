import 'package:dev_connected/features/home_feed/presntation/bloc/home_feed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuButton extends StatelessWidget {
  final String postId;
  const MenuButton({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text('Delete'),
            onTap: () {
              // Handle delete action
              context.read<HomeFeedBloc>().add(DeletePostRequested(postId:postId ));
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Delete Post'),
                  content: Text('Are you sure you want to delete this post?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle delete confirmation
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          PopupMenuItem(
            child: Text('Edit'),
            onTap: () {
              // Handle edit action
            },
          ),
        ];
      },
    );
  }
}
