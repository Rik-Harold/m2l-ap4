import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/class/RequeteApi.dart';
import 'package:m2l/main.dart';
import 'package:m2l/navBar.dart';
import 'package:m2l/reservations/form.dart';

// Initilisation de l'appel à l'api
RequeteApi api = RequeteApi();

// Interface d'affiche des réservations de l'utilisateur courant
class MesReservations extends StatefulWidget {
  // Variable de stockage du statut du visiteur
  final dynamic dataUser;

  // Constructeur de la class d'accueil avec récupération du statut du visiteur
  const MesReservations({Key? key, required this.dataUser});

  @override
  State<MesReservations> createState() => _MesReservationsState();
}

class _MesReservationsState extends State<MesReservations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: couleurOrangePale,
      drawer: NavBar(
        userConnect: widget.dataUser,
      ),
      appBar: AppBar(
        title: const Text(
          'Mes réservations',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(192, 253, 250, 236)),
        ),
        backgroundColor: couleurJaune,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        const SizedBox(
          height: 30,
        ),
        // RESERVATIONS DE L'UTILISATEUR COURANT
        ListeReservation(userData: widget.dataUser),
        const SizedBox(
          height: 10,
        ),
      ])),
      // BOUTON FLOTTANT POUR LA CREATION D'UNE RESERVATION
      floatingActionButton: FloatingActionButton(
        backgroundColor: couleurJaune,
        onPressed: () {
          // Redirection vers l'interface de création de réservation
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Reservations(
                        userData: widget.dataUser,
                      )));
        },
        // Icone de création
        child: const Icon(
          Icons.add,
          color: couleurBleu,
        ),
      ),
    );
  }
}

class ListeReservation extends StatefulWidget {
  final userData;
  const ListeReservation({Key? key, required this.userData}) : super(key: key);

  @override
  State<ListeReservation> createState() => _ListeReservationState();
}

class _ListeReservationState extends State<ListeReservation> {
  // Variable de récupération des réservations de l'utilisateur
  late List<dynamic> reservations;

  // Récupération des données des réservations
  Future<dynamic> getUserReservation() async {
    return await api.getReservationUser(widget.userData.getId());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getUserReservation(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Récupération des salles du domaine sélectionné
            reservations = snapshot.data!;
            // Formatage des réservations de chaque salle du domaine sélectionné
            return Column(
              children: [
                for (var reservation in reservations)
                  DelayedAnimation(
                      delay: 1500,
                      child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                              color: couleurJaune,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            children: [
                              Text(
                                reservation['breve_description'].toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Du : ' +
                                  reservation['date_heure_debut'].toString()),
                              Text('au : ' +
                                  reservation['date_heure_fin'].toString())
                            ],
                          ))),
              ],
            );
          } else {
            // Notification en cas d'absence de réservations
            return const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text('Aucune réservation disponible !',
                      style: TextStyle(fontSize: 17)),
                ));
          }
        });
  }
}
