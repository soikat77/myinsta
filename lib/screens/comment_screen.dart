import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postid'])
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          // show progress indicator before getting the data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // after getting the data
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => Comment(
              snap: (snapshot.data! as dynamic).docs[index].data(),
            ),
          );
        },
      ),
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
              // post the comment to database
              onTap: () async {
                await FirestoreMethods().postComment(
                  widget.snap['postid'],
                  _commentText.text,
                  user.uid,
                  user.username,
                  user.photoUrl,
                );
                // clear the text
                setState(() {
                  _commentText.clear();
                });
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
