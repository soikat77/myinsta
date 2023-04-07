import 'package:flutter/material.dart';
import 'package:myinsta/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

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
              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/7249743/pexels-photo-7249743.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
              ),

              // username
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Soikat Alam',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
              text: const TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        'Post Caption. Post Caption. Post Caption. Post Caption. Post Caption.',
                    style: TextStyle(color: primaryColor),
                  ),
                  TextSpan(
                    text: ' at 05.36 PM in Dhaka',
                    style: TextStyle(color: secondaryColor, fontSize: 16),
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
              'https://images.pexels.com/photos/2087322/pexels-photo-2087322.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
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
              const Text('1,257 Likes'),

              // comments
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment_outlined,
                  size: 22,
                ),
              ),
              const Text('57 comments'),

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
