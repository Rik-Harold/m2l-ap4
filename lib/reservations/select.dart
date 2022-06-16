import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/class/RequeteApi.dart';
import 'package:m2l/main.dart';
import 'package:m2l/navBar.dart';
import 'package:m2l/reservations/form.dart';

// Initilisation de l'appel à l'api
RequeteApi api = RequeteApi();

// Interface d'affiche des réservations de l'utilisateur courant
class SelectReservation extends StatefulWidget {
  // Variable de stockage du statut du visiteur
  final String statutUser;
  final dynamic dataUser;
  final dynamic reservation;
  final String nameDomaine;
  final String nameSalle;

  // Constructeur de la class d'accueil avec récupération du statut du visiteur
  const SelectReservation(
      {Key? key,
      required this.statutUser,
      required this.dataUser,
      required this.reservation,
      required this.nameDomaine,
      required this.nameSalle});

  @override
  State<SelectReservation> createState() => _SelectReservationState();
}

class _SelectReservationState extends State<SelectReservation> {
  @override
  Widget build(BuildContext context) {
    // Récupération de la page
    return Scaffold(
        backgroundColor: couleurOrangePale,
        drawer: widget.statutUser == 'connecte'
            ? NavBar(
                userConnect: widget.dataUser,
              )
            : null,
        appBar: AppBar(
          title: const Text(
            'Réservation',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(192, 253, 250, 236)),
          ),
          backgroundColor: couleurJaune,
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: [
            const SizedBox(
              height: 40,
            ),
            DelayedAnimation(
                delay: 1000,
                child: Column(children: [
                  Text(
                    widget.reservation['breve_description'].toUpperCase(),
                    style: const TextStyle(
                        fontFamily: 'fantasy',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: couleurJaune,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Text(
                      widget.reservation['description_complete'],
                      style: const TextStyle(
                          fontFamily: 'arial', fontSize: 18, letterSpacing: 2),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('SALLE   : ' + widget.nameSalle,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15)),
                  Text('DOMAINE : ' + widget.nameDomaine,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15)),
                ])),
          ]),
        )));
  }
}

// BOUTON DE RESERVATION DE SALLE OU D'AFFICHAGE D'UNE NOTIFICATION D'ALERTE
class AfficheReservation extends StatefulWidget {
  final int id;
  final dynamic dataConnect;
  const AfficheReservation(
      {Key? key, required this.id, required this.dataConnect})
      : super(key: key);

  @override
  State<AfficheReservation> createState() => _AfficheReservationState();
}

// Formatage du bouton
class _AfficheReservationState extends State<AfficheReservation> {
  // Widget d'affichage de la boite d'alerte en dialogue
  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ALERTE RESERVATION'),
          content: const Text(
              'Vous n\'avez pas les autorisations nécessaires pour réserver.'),
          actions: <Widget>[
            // Bouton de retour au planning
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Revenir au planning'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: couleurJaune,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.all(12)),
      // Bouton de réservation
      child: const Text(
        'Réserver une salle',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      ),
      onPressed: () {
        // Vérification du statut de l'utilisation pour une redirection
        if (widget.id == 1) {
          // Redirection vers le formulaire de réservation de salles
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Reservations(
                        userData: widget.dataConnect,
                      )));
        } else {
          // Affichage de l'alerte en cas d'utilisateur non connecté
          showAlert(context);
        }
      },
    );
  }
}
