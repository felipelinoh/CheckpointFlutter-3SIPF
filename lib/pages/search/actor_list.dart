import 'package:flutter/material.dart';
import 'package:movie_app/models/person_model.dart';
import 'package:movie_app/pages/search/widgets/actors_horizontal_item.dart';

class ActorList extends StatelessWidget {
  const ActorList({super.key, required this.actors});

  final List<Actor> actors;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          return ActorsHorizontalItem(actor: actors[index]);
        },
      ),
    );
  }
}