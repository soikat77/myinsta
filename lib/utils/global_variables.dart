import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myinsta/screens/add_post_screen.dart';
import 'package:myinsta/screens/profile_screen.dart';

import '../screens/feed_screen.dart';
import '../screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const Center(
    child: FeedScreen(),
  ),
  const Center(
    child: SearchScreen(),
  ),
  const Center(
    child: AddPostScreen(),
  ),
  const Center(
    child: Text('Favorites'),
  ),
  Center(
    child: ProfileScreen(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
  ),
];
