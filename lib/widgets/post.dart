import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myinsta/utils/colors.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
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
              // profile image
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(snap['profileImage']),
              ),

              // username
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    snap['username'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),

              // three dot menu
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

          // caption
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                    text: snap['caption'],
                    style: const TextStyle(color: primaryColor),
                  ),
                  const TextSpan(
                    text: ' at ',
                    style: TextStyle(color: secondaryColor, fontSize: 16),
                  ),
                  TextSpan(
                    text: DateFormat.yMMMd().format(
                      snap['datePublished'].toDate(),
                    ),
                    style: const TextStyle(color: secondaryColor, fontSize: 16),
                  )
                ],
              ),
            ),
          ),

          // post image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),

          Row(
            children: [
              // heart / like
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              Text(snap['likes'].length.toString()),

              // comments
              IconButton(
                onPressed: () {},
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
