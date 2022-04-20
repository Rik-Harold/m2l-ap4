import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/connexion.dart';
import 'package:m2l/class/RequeteApi.dart';
import 'package:m2l/main.dart';
import 'package:m2l/reservations/form.dart';

// Initilisation de l'appel à l'api
RequeteApi api = RequeteApi();

// Création de l'interface de la page d'accueil
class Accueil extends StatefulWidget {
  // Déclaration de variable
  final statutConnexion;

  // Constructeur
  const Accueil(this.statutConnexion);

  @override
  State<Accueil> createState() => _AccueilState(statutConnexion);
}

class _AccueilState extends State<Accueil> {
  // Déclaration de variable
  final statutConnexion;

  // Constructeur
  _AccueilState(this.statutConnexion);

  // Variable de stockage de la donnée
  late Future<dynamic> dataUser;
  String nomDomaine = 'Plongée sous-marine';
  int domaine = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      child: Column(children: [
        const SizedBox(
          height: 40,
        ),
        // Entête de la page d'accueil
        DelayedAnimation(
            delay: 1000,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  color: couleurJaune,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Row(
                children: [
                  Container(
                      height: 80,
                      child: Image.asset('assets/images/logo_rond.png')),
                  Expanded(
                      child: Center(
                          child: Text(
                    statutConnexion,
                    style: const TextStyle(color: couleurRouge),
                  ))),
                  IconButton(
                    onPressed: () {
                      if (statutConnexion != 'Utilisateur non connecté') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Reservations()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Connexion()));
                      }
                    },
                    icon: const Icon(Icons.account_circle_rounded),
                    color: couleurRouge,
                    iconSize: 50,
                  )
                ],
              ),
            )),
        // Barre de recherche
        DelayedAnimation(
          delay: 1500,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(108, 219, 218, 218),
                      ),
                      child: const Center(
                          child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'Rechercher une réservation',
                            border: InputBorder.none),
                      ))),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  iconSize: 30,
                ),
              ],
            ),
          ),
        ),
        // Planning
        DelayedAnimation(
          delay: 2500,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.navigate_before)),
                    const Text(
                      'JOUR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: couleurBleu,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.navigate_next))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(108, 219, 218, 218),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(
                          color: Color.fromARGB(255, 219, 219, 219),
                          width: .3,
                          style: BorderStyle.solid)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(children: [
                          const Text(
                            'HORAIRE',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: couleurBleu),
                          ),
                          for (var i = 0; i < 10; i++)
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                (8 + i).toString() + 'h',
                              ),
                            )
                        ]),
                      ),
                      Expanded(child: Planning(indomaine: domaine))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    child: DelayedAnimation(
                      delay: 3000,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'DOMAINE : ',
                            style: TextStyle(
                                fontSize: 18,
                                color: couleurBleu,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          DropdownButton<String>(
                            value: nomDomaine,
                            icon: const Icon(Icons.arrow_drop_down),
                            onChanged: (String? newValue) {
                              setState(() {
                                // Modification dynamique
                                switch (newValue) {
                                  case 'Pétanque':
                                    domaine = 2;
                                    nomDomaine = newValue!;
                                    print('Domaine : $nomDomaine');
                                    print('Nouveau domaine : $newValue');
                                    print(domaine);
                                    break;
                                  case 'Tennis':
                                    domaine = 3;
                                    nomDomaine = newValue!;
                                    print('Domaine : $nomDomaine');
                                    print('Nouveau domaine : $newValue');
                                    print(domaine);
                                    break;
                                  default:
                                    domaine = 1;
                                    nomDomaine = newValue!;
                                    print('Domaine : $nomDomaine');
                                    print('Nouveau domaine : $newValue');
                                    print(domaine);
                                }
                              });
                            },
                            items: <String>[
                              'Plongée sous-marine',
                              'Pétanque',
                              'Tennis'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // Bouton de réservation de salle
        DelayedAnimation(
            delay: 3500,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: couleurJaune,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.all(12)),
              child: const Text(
                'Réserver une salle',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              onPressed: () {},
            )),
        const SizedBox(
          height: 10,
        ),
      ]),
    )));
  }
}

// CLASS DE RECUPERATION DU PLANNING
class Planning extends StatefulWidget {
  final int indomaine;
  Planning({Key? key, required this.indomaine});

  @override
  State<Planning> createState() => _PlanningState();
}

// FORMATAGE DU PLANNING
class _PlanningState extends State<Planning> {
  // Variables de récupération des salles du domaine 1
  late List<dynamic> reservationsDomaine;

  @override
  void didUpdateWidget(Planning planning) {
    super.didUpdateWidget(planning);
  }

  // Récupération des données du planning
  Future<dynamic> getPlanningData() async {
    return await api.getPlanningData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getPlanningData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Récupération des salles du domaine sélectionné
            reservationsDomaine = snapshot.data!['salles'];
            // Formatage des réservations de chaque salle du domaine sélectionné
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var salle in reservationsDomaine
                        .where((salle) => salle['area_id'] == widget.indomaine))
                      Reservation(salle['room_name'])
                  ],
                ));
          } else {
            return const Center(child: Text('Pas de données'));
          }
        });
  }
}

// FORMATAGE DES RESERVATION D'UNE SALLE DU DOMAINE SELECTIONNE
class Reservation extends StatelessWidget {
  // Variables locales de la salle
  final String nameSalle;
  // final List<Map<String, dynamic>> reservations;
  static const reservations = [
    {'name': 'Réunion', 'duree': 4, 'capacite': 50},
    {'name': 'Stage', 'duree': 2, 'capacite': 25},
    {'name': 'Séminaire', 'duree': 7, 'capacite': 30}
  ];

  const Reservation(this.nameSalle);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(nameSalle,
              style: const TextStyle(fontSize: 15, color: couleurBleu)),
        ),
        for (var reservation in reservations)
          Container(
            margin: const EdgeInsets.all(2),
            width: 80,
            height: 100,
            color: const Color.fromARGB(192, 219, 218, 218),
            child: Center(
                child: Text(
              reservation['name'].toString(),
              style: const TextStyle(fontWeight: FontWeight.w300),
            )),
          )
      ],
    );
  }
}
