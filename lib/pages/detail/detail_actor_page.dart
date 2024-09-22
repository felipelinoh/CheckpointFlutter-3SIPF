// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_app/models/person_model.dart';
import 'package:movie_app/services/api_services.dart';

class ActorDetailPage extends StatefulWidget {
  final int personId;

  const ActorDetailPage({Key? key, required this.personId}) : super(key: key);

  @override
  State<ActorDetailPage> createState() => _ActorDetailPageState();
}

class _ActorDetailPageState extends State<ActorDetailPage> {
  late Future<Actor> actorFuture;

  @override
  void initState() {
    super.initState();
    actorFuture = ApiServices().getActorDetails(widget.personId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Actor>(
        future: actorFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Detalhes do ator não encontrados.'),
            );
          }

          final actor = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    actor.profilePath.isNotEmpty
                        ? Image.network(
                            actor.profilePath,
                            height: 350,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox.shrink(),
                    Positioned(
                      top: 20,
                      left: 16,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              const Color.fromARGB(10, 0, 0, 0),
                            ],
                          ),
                        ),
                        child: Text(
                          actor.name,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nascimento',
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${actor.birthday.day}/${actor.birthday.month}/${actor.birthday.year} (${calcularIdade(actor.birthday)} anos)',
                        style: const TextStyle(
                            fontSize: 17, color: Colors.white70),
                      ),
                      Text(
                        actor.placeOfBirth,
                        style: const TextStyle(fontSize: 17),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'Biografia',
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        actor.biography,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
