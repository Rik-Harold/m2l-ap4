// Importation des packages de constrcution de pages
import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/main.dart';
import 'package:m2l/accueil.dart';

// Création de l'interface de la page d'accueil
class Inscription extends StatelessWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: couleurJaune,
          title: const Text('S\'inscrire'),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(children: [
            DelayedAnimation(
                delay: 1000,
                child: Container(
                    height: 200,
                    child: Image.asset('assets/images/logo_rond.png'))),
            const SizedBox(
              height: 50,
            ),
            const DelayedAnimation(delay: 1500, child: FormInscription())
          ]),
        )));
  }
}

// Formulaire d'inscription
class FormInscription extends StatefulWidget {
  const FormInscription({Key? key}) : super(key: key);

  @override
  State<FormInscription> createState() => _FormInscriptionState();
}

class _FormInscriptionState extends State<FormInscription> {
  // Clé du formulaire
  final _formKey = GlobalKey<FormState>();

  // Déclaration des variables de récupération des champs de texte
  var saisieEmail = TextEditingController();
  var saisieMdp = TextEditingController();
  var saisieStatut = TextEditingController();
  var afficheMdp = true;

  // Initialisation des saisies du formulaire
  @override
  void dispose() {
    // Initialisation de chaque champ
    saisieEmail.dispose();
    saisieMdp.dispose();
    saisieStatut.dispose();

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
            controller: saisieEmail,
            decoration: const InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(
                  color: couleurBleu,
                ),
                contentPadding: EdgeInsets.all(10)),
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
            controller: saisieStatut,
            decoration: const InputDecoration(
                labelText: 'Statut',
                labelStyle: TextStyle(
                  color: couleurBleu,
                ),
                contentPadding: EdgeInsets.all(10)),
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
            controller: saisieMdp,
            obscureText: afficheMdp,
            decoration: InputDecoration(
                labelText: 'Mot de passe',
                labelStyle: const TextStyle(
                  color: couleurBleu,
                ),
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        afficheMdp = !afficheMdp;
                      });
                    },
                    icon: const Icon(Icons.visibility))),
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
            obscureText: afficheMdp,
            decoration: InputDecoration(
                labelText: 'Confirmez votre mot de passe',
                labelStyle: const TextStyle(
                  color: couleurBleu,
                ),
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        afficheMdp = !afficheMdp;
                      });
                    },
                    icon: const Icon(Icons.visibility))),
            validator: (value) {
              if (value == null || value.isEmpty || value != saisieMdp.text) {
                return 'Les mots de passe ne correspondent pas !';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          // Bouton d'inscription
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: couleurJaune,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.only(
                    top: 12, bottom: 12, left: 25, right: 25)),
            child: const Text('INSCRIPTION', style: TextStyle(fontSize: 17)),
            onPressed: () {
              // Redirection vers l'accueil en tant qu'utilisateur en demande d'inscription
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Accueil(
                            statutConnexion: 'non connecte',
                            userConnect: null,
                          )));
            },
          )
        ],
      ),
    );
  }
}
