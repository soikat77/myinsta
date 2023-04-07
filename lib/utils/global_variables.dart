import 'package:flutter/material.dart';
import 'package:myinsta/screens/add_post_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  Center(
    child: Text('Home'),
  ),
  Center(
    child: Text('Search'),
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