
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailor/ui/pages/home.dart';
import 'package:tailor/ui/pages/explore.dart';
import 'package:tailor/ui/pages/feedback.dart';
import 'package:tailor/ui/pages/settings.dart';

const webScreenSize = 600;

List <Widget> homeScreenItems = [
  Settings(),
  Explore(),
  FeedScreen(),
];


