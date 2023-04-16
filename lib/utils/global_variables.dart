import 'package:flutter/material.dart';
import 'package:myinsta/screens/add_post_screen.dart';

import '../screens/feed_screen.dart';
import '../screens/search_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  Center(
    child: SearchScreen(),
  ),
  Center(
    child: FeedScreen(),
  ),
  Center(
    child: AddPostScreen(),
  ),
  Center(
    child: Text('Favorites'),
  ),
  Center(
    child: Text('Profile'),
  ),
];
