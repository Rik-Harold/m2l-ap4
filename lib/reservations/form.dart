// Importation des packages de constrcution de pages
import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/class/RequeteApi.dart';
import 'package:m2l/navBar.dart';
import 'package:m2l/salles/form.dart';
import 'package:m2l/main.dart';
import 'package:date_time_picker/date_time_picker.dart';

// Initilisation de l'appel à l'api
RequeteApi api = RequeteApi();

// Interface d'affiche des réservations
class Reservations extends StatelessWidget {
  final dynamic userData;
  const Reservations({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(
          userConnect: userData,
        ),
        appBar: AppBar(
          title: const Text(
            'Réservation de salles',
            style: TextStyle(color: Color.fromARGB(192, 253, 250, 236)),
          ),
          backgroundColor: couleurJaune,
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
          child: const DelayedAnimation(delay: 1000, child: FormReservations()),
        )));
  }
}

// Page de Reservations à l'application
class FormReservations extends StatefulWidget {
  const FormReservations({Key? key}) : super(key: key);

  // String dateFin = '';

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

  // Déinition et initialisation de la valeur par défaut des choix
  int domaine = 1;
  String periodicite = 'Jour';
  String nomSalle = 'Salle 1';
  String type = 'Amphithéâtre';
  String nomDomaine = 'Plongée sous-marine';

  // Variables et initialisation des champs de saisie
  var descriptionComplete = TextEditingController();
  var descriptionBreve = TextEditingController();
  String? dateHeureDebut;
  String? dateHeureFin;

  // Initialisation des saisies du formulaire
  @override
  void dispose() {
    // Initialisation de chaque champ
    descriptionComplete.dispose();
    descriptionBreve.dispose();

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
          // Titre du formulaire de réservation
          const Center(
            child: Text(
              'RESERVATION',
              style: TextStyle(
                  color: couleurBleu,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Titre de la réservation
          TextFormField(
            controller: descriptionBreve,
            decoration: const InputDecoration(
              labelText: 'Titre',
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
            height: 15,
          ),
          // Description de la réservation
          TextFormField(
            controller: descriptionComplete,
            decoration: const InputDecoration(
              labelText: 'Description',
              labelStyle: TextStyle(color: couleurBleu),
            ),
            maxLines: 3,
            maxLength: 300,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ doit être rempli';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          // Entrée de la date et de l'heure de début
          DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            autovalidate: true,
            dateMask: 'dd MM, yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2025),
            icon: const Icon(Icons.event),
            dateLabelText: 'Date de début',
            timeLabelText: "Heure de début",
            selectableDayPredicate: (date) {
              // Disable weekend days to select from the calendar
              if (date.weekday == 6 || date.weekday == 7) {
                return false;
              }
              return true;
            },
            onChanged: (val) {},
            validator: (selectedDate) {
              if (selectedDate != null) {
                DateTime selected = DateTime.parse(selectedDate);
                if (selected.difference(DateTime.now()).isNegative) {
                  return 'La date doit être ultérieure';
                }
              } else {
                return "Date nulle";
              }
              return null;
            },
            onSaved: (val) {
              // Enregistrement de la date et l'heure de début de réservation
              dateHeureDebut = val;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          // Entrée de la date et de l'heure de fin
          DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            autovalidate: true,
            dateMask: 'dd MM, yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2025),
            icon: const Icon(Icons.event),
            dateLabelText: 'Date de fin',
            timeLabelText: "Heure de fin",
            selectableDayPredicate: (date) {
              // Disable weekend days to select from the calendar
              if (date.weekday == 6 || date.weekday == 7) {
                return false;
              }
              return true;
            },
            onChanged: (val) {},
            validator: (selectedDate) {
              if (selectedDate != null) {
                DateTime selected = DateTime.parse(selectedDate);
                if (selected.difference(DateTime.now()).isNegative) {
                  return 'La date doit être ultérieure';
                }
              } else {
                return "Date nulle";
              }
              return null;
            },
            onSaved: (val) {
              // Enregistrement de la date et l'heure de fin de réservation
              dateHeureFin = val;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          // Périodicité de la réservation
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
                  isExpanded: true,
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
          // Type de réservation
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
                  isExpanded: true,
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
                      child: Text(value),
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
                  isExpanded: true,
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
          // Sélection de la salle
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
                  isExpanded: true,
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
          const SizedBox(
            height: 15,
          ),
          // Bouton de Reservations
          DelayedAnimation(
            delay: 2000,
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: couleurJaune,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all(10)),
                child: const Text('Réserver',
                    style: TextStyle(fontSize: 20, letterSpacing: 2)),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const Salles(action: 'Modification')));
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
