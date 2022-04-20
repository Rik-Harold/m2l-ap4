// Importation des packages de constrcution de pages
import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/class/RequeteApi.dart';
import 'package:m2l/accueil.dart';
import 'package:m2l/main.dart';

// Initilisation de l'appel à l'api
RequeteApi api = RequeteApi();

// Interface d'affiche des réservations
class Reservations extends StatelessWidget {
  const Reservations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Créer une réservation'),
          backgroundColor: couleurJaune,
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(children: [
            // Formulaire de Reservations
            const DelayedAnimation(delay: 1000, child: FormReservations()),
            const SizedBox(
              height: 50,
            ),
            // Bouton de redirection vers la page d'inscription
            DelayedAnimation(
                delay: 2000,
                child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: couleurJaune,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.all(10)),
                      child: const Text('Créer'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Accueil('moi@gmail.com')));
                      },
                    ))),
          ]),
        )));
  }
}

// Page de Reservations à l'application
class FormReservations extends StatefulWidget {
  const FormReservations({Key? key}) : super(key: key);

  @override
  State<FormReservations> createState() => _FormReservationsState();
}

class _FormReservationsState extends State<FormReservations> {
  // Clé du formulaire
  final _formKey = GlobalKey<FormState>();

  // Requête d'authentification
  // Future<String> Reservations(email, mdp) async {
  //   // Reservations à l'API
  //   return await api.Reservations(email, mdp);
  // }

  // Déclaration des variables de récupération des champs de texte
  var saisieEmail = TextEditingController();
  var saisieMdp = TextEditingController();
  var afficheMdp = true;

  String nomDomaine = 'Plongée sous-marine';
  String nomSalle = 'Salle 1';
  String periodicite = 'Jour';
  String type = 'Réunion';
  var descriptionComplete = TextEditingController();
  var descriptionBreve = TextEditingController();
  var heureDebut = TextEditingController();
  var heureFin = TextEditingController();
  int domaine = 1;

  // Initialisation des saisies du formulaire
  @override
  void dispose() {
    // Initialisation de chaque champ
    saisieEmail.dispose();
    saisieMdp.dispose();

    // Lancement de l'inialisation des champs
    super.dispose();
  }

  // Formulaire rendu
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: descriptionBreve,
            decoration: const InputDecoration(
              labelText: 'Brève description',
              labelStyle: TextStyle(color: couleurBleu),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ doit être rempli';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: descriptionComplete,
            decoration: const InputDecoration(
              labelText: 'Description complète',
              labelStyle: TextStyle(color: couleurBleu),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ doit être rempli';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: heureDebut,
            decoration: const InputDecoration(
              labelText: 'Date de début',
              labelStyle: TextStyle(color: couleurBleu),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ doit être rempli';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: heureFin,
            decoration: const InputDecoration(
              labelText: 'Date de fin',
              labelStyle: TextStyle(color: couleurBleu),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ doit être rempli';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 100,
                child: const Text(
                  'Périodicité : ',
                  style: TextStyle(
                    fontSize: 17,
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
          ),
          Row(
            children: [
              Container(
                width: 100,
                child: const Text(
                  'Type de réservation : ',
                  style: TextStyle(
                    fontSize: 17,
                    color: couleurBleu,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: DropdownButton<String>(
                  value: type,
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
                  items: <String>['Amphithéâtre', 'Réunion']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 100,
                child: const Text(
                  'Domaine : ',
                  style: TextStyle(
                    fontSize: 17,
                    color: couleurBleu,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: DropdownButton<String>(
                  value: nomDomaine,
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
                  items: <String>['Plongée sous-marine', 'Pétanque', 'Tennis']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                child: const Text(
                  'Salle : ',
                  style: TextStyle(
                    fontSize: 17,
                    color: couleurBleu,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: DropdownButton<String>(
                  value: nomSalle,
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
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          // Bouton de Reservations
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: couleurJaune,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.all(10)),
            child: const Text('Reservations'),
            onPressed: () async {
              // if (_formKey.currentState!.validate()) {
              //   // Authentification
              //   var email = 'moi@gmail.com';
              //   var mdp = 'moi';
              //   var reponse =
              //       // await api.Reservations(saisieEmail.text, saisieMdp.text);
              //       await api.Reservations(email, mdp);

              //   // Vérification de la réponse d'authentification
              //   if (reponse['statut'] == 'on') {
              //     // Redirection vers l'accueil pour les visiteurs inscrits
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) =>
              //                 Accueil(reponse['utilisateur'])));
              //   } else if (reponse['statut'] == 'invalide') {
              //   } else {
              //     // Redirection vers la page d'inscription pour les non inscrits
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const Inscription()));
              //   }
              // }
            },
          )
        ],
      ),
    );
  }
}
