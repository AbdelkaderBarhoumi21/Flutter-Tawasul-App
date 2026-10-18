import 'package:flutter/foundation.dart';

/// A pre-provisioned Stream Chat account used for the demo sign-in.
@immutable
class DemoUser {
  const DemoUser({required this.id, required this.name, required this.image});

  final String id;
  final String name;
  final String image;

  static const all = [
    DemoUser(
      id: 'gordon',
      name: 'Gordon Hayes',
      image: 'https://picsum.photos/seed/gordon/300/300',
    ),
    DemoUser(
      id: 'salvatore',
      name: 'Salvatore Giordano',
      image: 'https://picsum.photos/seed/salvatore/300/300',
    ),
    DemoUser(
      id: 'sacha',
      name: 'Sacha Arbonel',
      image: 'https://picsum.photos/seed/sacha/300/300',
    ),
    DemoUser(
      id: 'deven',
      name: 'Deven Joshi',
      image: 'https://picsum.photos/seed/deven/300/300',
    ),
    DemoUser(
      id: 'sahil',
      name: 'Sahil Kumar',
      image: 'https://picsum.photos/seed/sahil/300/300',
    ),
    DemoUser(
      id: 'reuben',
      name: 'Reuben Turner',
      image: 'https://picsum.photos/seed/reuben/300/300',
    ),
    DemoUser(
      id: 'nash',
      name: 'Nash Ramdial',
      image: 'https://picsum.photos/seed/nash/300/300',
    ),
  ];
}
