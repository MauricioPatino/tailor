import 'package:equatable/equatable.dart';
export 'package:tailor/ui/pages/models/profile.dart';
import 'package:flutter/material.dart';

class Profile extends Equatable {
  final int id;
  final String name;
  final int age;
  final List<String> imageUrls;
  final String bio;
  final String jobTitle;

  const Profile({required this.id,required this.name,required this.age,required this.imageUrls,required this.bio,required this.jobTitle});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, age, imageUrls, bio, jobTitle,];
}


List<Profile> users = [Profile(id: 0, name: 'Alfred', age: 23, imageUrls: ['https://i.kym-cdn.com/photos/images/original/002/250/753/a0a.jpg'], bio: 'I hate you Mao', jobTitle: 'Barista')];