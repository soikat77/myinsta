import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myinsta/models/user_model.dart';
import 'package:myinsta/providers/user_provider.dart';
import 'package:myinsta/resources/firestore_methods.dart';
import 'package:myinsta/screens/comment_screen.dart';
import 'package:myinsta/utils/colors.dart';
import 'package:myinsta/widgets/heart_animation.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isAnimate = false;

  @override
  Widget build(BuildContext context) {
    // getting the user
    final UserModel user = Provider.of<UserProvider>(context).getUser;

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //* ---------------------------- profile image ---------------------------- *//
              CachedNetworkImage(
                imageUrl: widget.snap['profileImage'],
                placeholder: (context, url) => const CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 22,
                ),
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundImage: image,
                  radius: 22,
                ),
              ),

              //* -------------------------------- username -------------------------------- *//
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    widget.snap['username'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),

              //* ----------------------------- three dot menu ----------------------------- *//
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shrinkWrap: true,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Delete'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('Report'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          //* --------------------------------- caption -------------------------------- *//
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.snap['caption'],
                    style: const TextStyle(color: primaryColor),
                  ),
                  const TextSpan(
                    text: ' at ',
                    style: TextStyle(color: secondaryColor, fontSize: 16),
                  ),
                  TextSpan(
                    text: DateFormat.yMMMEd().format(
                      widget.snap['datePublished'].toDate(),
                    ),
                    style: const TextStyle(color: secondaryColor, fontSize: 16),
                  )
                ],
              ),
            ),
          ),

          //* ------------------------------- post image ------------------------------- *//
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().likePost(
                widget.snap['postid'],
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                isAnimate = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: widget.snap['postUrl'],
                    maxHeightDiskCache: 100,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isAnimate ? 1 : 0,
                  child: HeartAnimation(
                    isAnimate: isAnimate,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isAnimate = false;
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              // heart / like
              HeartAnimation(
                isAnimate: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await FirestoreMethods().likePost(
                      widget.snap['postid'],
                      user.uid,
                      widget.snap['likes'],
                    );
                  },
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 24,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 24,
                        ),
                ),
              ),
              Text(widget.snap['likes'].length.toString()),

              // comments
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(snap: widget.snap),
                  ),
                ),
                icon: const Icon(
                  Icons.comment_outlined,
                  size: 22,
                ),
              ),
              // Text(snap['likes'].length.toString()),

              // share
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  size: 22,
                ),
              ),

              // save / favorite
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_outline,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
