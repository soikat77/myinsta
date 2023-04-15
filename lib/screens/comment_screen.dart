import 'package:flutter/material.dart';
import 'package:myinsta/models/user_model.dart';
import 'package:myinsta/providers/user_provider.dart';
import 'package:myinsta/resources/firestore_methods.dart';
import 'package:myinsta/utils/colors.dart';
import 'package:myinsta/widgets/comment.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentText = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getting user data
    final UserModel user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: mobileBackgroundColor,
      ),
      body: const Comment(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(user.photoUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: _commentText,
                  decoration: InputDecoration(
                    hintText: 'Comment as ${user.username}',
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await FirestoreMethods().postComment(
                  widget.snap['postid'],
                  _commentText.text,
                  user.uid,
                  user.username,
                  user.photoUrl,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
