import 'package:flutter/material.dart';
import 'package:hello_world/models/Brew.dart';
import 'package:hello_world/screens/home/brew_tile.dart';
import 'package:provider/provider.dart';

class BrewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) => BrewTile(brew: brews[index]),
    );
  }
}
