import 'package:flutter/material.dart';
import 'package:myinsta/screens/add_post_screen.dart';
import 'package:myinsta/screens/profile_screen.dart';

import '../screens/feed_screen.dart';
import '../screens/search_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  Center(
    child: FeedScreen(),
  ),
  Center(
    child: SearchScreen(),
  ),
  Center(
    child: AddPostScreen(),
  ),
  Center(
    child: Text('Favorites'),
  ),
  Center(
    child: ProfileScreen(),
  ),
];
