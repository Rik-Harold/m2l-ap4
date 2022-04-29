import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/class/RequeteApi.dart';
import 'package:m2l/main.dart';
import 'package:m2l/navBar.dart';
import 'package:date_time_picker/date_time_picker.dart';

// Initilisation de l'appel à l'api
RequeteApi api = RequeteApi();

// Interface d'affiche des réservations de l'utilisateur courant
class Recherche extends StatefulWidget {
  // Variable de récupération de la saisie à rechercher
  final String statutConnexion;
  final dynamic userConnect;
  final String saisie;

  // Constructeur de la class de recherche
  const Recherche(
      {Key? key,
      required this.statutConnexion,
      this.userConnect,
      required this.saisie});

  @override
  State<Recherche> createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  // Déclaration de variable
  // final idUser;

  // Constructeur

  // Variable de stockage de la donnée
  // late Future<dynamic> dataUser;

  var listeReservation = [
    {'name': 'Réservation 1', 'date': '12/11/2021', 'salle': 1, 'domaine': 2},
    {'name': 'Réservation 2', 'date': '12/11/2021', 'salle': 2, 'domaine': 1},
    {'name': 'Réservation 3', 'date': '12/11/2021', 'salle': 3, 'domaine': 1},
    {'name': 'Réservation 4', 'date': '12/11/2021', 'salle': 2, 'domaine': 3},
    {'name': 'Réservation 1', 'date': '12/11/2021', 'salle': 1, 'domaine': 2},
    {'name': 'Réservation 2', 'date': '12/11/2021', 'salle': 2, 'domaine': 1},
    {'name': 'Réservation 3', 'date': '12/11/2021', 'salle': 3, 'domaine': 1},
    {'name': 'Réservation 4', 'date': '12/11/2021', 'salle': 2, 'domaine': 3}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.statutConnexion == 'connecte'
          ? NavBar(
              userConnect: widget.userConnect,
            )
          : null,
      appBar: AppBar(
        title: const Text(
          'Rerchercher une réservation',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(192, 253, 250, 236)),
        ),
        backgroundColor: couleurJaune,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Container(
            child: Column(children: [
              DelayedAnimation(
                  delay: 1000,
                  child: BarreRecherche(
                    saisie: widget.saisie,
                  )),
              const SizedBox(
                height: 20,
              ),
              // Liste des réservations correspondant à la recherche
              for (var reservation in listeReservation)
                DelayedAnimation(
                    delay: 2000,
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                          color: couleurJaune,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(reservation['name'].toString()),
                    )),
            ]),
          )),
    );
  }
}

// BARRE DE RECHERCHE DES RESERVATIONS AVEC CRITETES DE SELECTION
class BarreRecherche extends StatefulWidget {
  final String saisie;
  const BarreRecherche({Key? key, required this.saisie}) : super(key: key);

  @override
  State<BarreRecherche> createState() => _BarreRechercheState();
}

class _BarreRechercheState extends State<BarreRecherche> {
  // Clé du formulaire
  final _formKey = GlobalKey<FormState>();

  // Requête d'authentification
  // Future<String> Reservations(email, mdp) async {
  //   // Reservations à l'API
  //   return await api.Reservations(email, mdp);
  // }

  // Déinition et initialisation de la valeur par défaut des choix
  int domaine = 1;
  String periodicite = 'Jour';
  String nomSalle = 'Salle 1';
  String type = 'Amphithéâtre';
  String nomDomaine = 'Plongée sous-marine';

  // Variables et initialisation des champs de saisie
  var saisie = TextEditingController();
  String? dateTrie;

  // Initialisation des saisies du formulaire
  @override
  void dispose() {
    // Initialisation de chaque champ
    saisie.dispose();

    // Lancement de l'inialisation des champs
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Récupération de la donnée à rechercher
    saisie.text = widget.saisie;

    // Récupération du formulaire
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              // Conteneur de la barre de recherche
              Expanded(
                child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(108, 219, 218, 218),
                    ),
                    child: Center(
                        child: TextField(
                      style: const TextStyle(fontSize: 13, letterSpacing: 2),
                      controller: saisie,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          hintText: 'Décrivez la réservation...',
                          border: InputBorder.none),
                    ))),
              ),
              const SizedBox(
                width: 5,
              ),
              // Bouton de lancement de la recherche
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(108, 219, 218, 218),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    // color: couleurBleu,
                    color: Color.fromARGB(121, 39, 38, 38),
                  ),
                  iconSize: 30,
                ),
              ),
            ],
          ),
          // Critères de tri de réservation
          Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  child: // Entrée de la date et de l'heure de début
                      DateTimePicker(
                    type: DateTimePickerType.date,
                    autovalidate: true,
                    dateMask: 'dd/MM/yyyy',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2025),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Date de réservation',
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar
                      if (date.weekday == 6 || date.weekday == 7) {
                        return false;
                      }
                      return true;
                    },
                    onChanged: (val) {},
                    onSaved: (val) {
                      // Enregistrement de la date et l'heure de début de réservation
                      dateTrie = val;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Type de réservation
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: const Text(
                        'Type',
                        style: TextStyle(
                          fontSize: 13,
                          color: couleurPale,
                        ),
                      ),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: type,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? newValue) {
                          setState(() {
                            // Modification dynamique
                            switch (newValue) {
                              case 'Amphithéâtre':
                                domaine = 2;
                                nomDomaine = newValue!;
                                break;
                              case 'Réunion':
                                domaine = 3;
                                nomDomaine = newValue!;
                                break;
                              default:
                                domaine = 1;
                                nomDomaine = newValue!;
                            }
                          });
                        },
                        items: <String>[
                          'Amphithéâtre',
                          'Convivialité',
                          'Salle de réunion'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(
                                    fontSize: 13, color: couleurPale)),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                // Sélection du domaine
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: const Text(
                        'Domaine',
                        style: TextStyle(
                          fontSize: 13,
                          color: couleurPale,
                        ),
                      ),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: nomDomaine,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? newValue) {
                          setState(() {
                            // Modification dynamique
                            switch (newValue) {
                              case 'Pétanque':
                                domaine = 2;
                                nomDomaine = newValue!;
                                break;
                              case 'Tennis':
                                domaine = 3;
                                nomDomaine = newValue!;
                                break;
                              default:
                                domaine = 1;
                                nomDomaine = newValue!;
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
                            child: Text(value,
                                style: const TextStyle(
                                    fontSize: 13, color: couleurPale)),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                // Sélection de la salle
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: const Text(
                        'Salle',
                        style: TextStyle(
                          fontSize: 13,
                          color: couleurPale,
                        ),
                      ),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: nomSalle,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? newValue) {
                          setState(() {
                            // Modification dynamique
                            switch (newValue) {
                              case 'Salle 2':
                                domaine = 2;
                                nomSalle = newValue!;
                                break;
                              case 'Salle 3':
                                domaine = 3;
                                nomSalle = newValue!;
                                break;
                              default:
                                domaine = 1;
                                nomSalle = newValue!;
                            }
                          });
                        },
                        items: <String>['Salle 1', 'Salle 2', 'Salle 3']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  fontSize: 13, color: couleurPale),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
          /*/ Périodicité de la réservation
          Row(
            children: [
              Container(
                width: 100,
                child: const Text(
                  'Périodicité : ',
                  style: TextStyle(
                    fontSize: 10,
                    color: couleurBleu,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: DropdownButton<String>(
                  value: periodicite,
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: (String? newValue) {
                    setState(() {
                      // Modification dynamique
                      switch (newValue) {
                        case 'Jour':
                          domaine = 2;
                          nomDomaine = newValue!;
                          break;
                        case 'Semaine':
                          domaine = 3;
                          nomDomaine = newValue!;
                          break;
                        default:
                          domaine = 1;
                          nomDomaine = newValue!;
                      }
                    });
                  },
                  items: <String>[
                    'Jour',
                    'Semaine',
                    'Mois',
                    'Année',
                    'Année',
                    'Jour de semaine',
                    'Jour du mois'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}
