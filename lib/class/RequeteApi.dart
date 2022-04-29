// Importation des packages
import 'dart:convert';
import 'package:m2l/class/User.dart';
import 'package:http/http.dart' as http;

// Class de gestion des utilisateurs
class RequeteApi {
  // FONCTION DE REQUETE A L'API POUR LA RECUPERATIOPN DES DONNEES DU PLANNING
  Future<dynamic> getPlanningData() async {
    // Définition du chemin d'accès aux données de l'api
    String apiUrl = 'http://10.0.2.2:3000/api/mobile/planning';

    // TRAITEMENTS
    try {
      // Requête à l'api
      var res = await http.post(Uri.parse(apiUrl));
      // Traitement de la réponse
      if (res.statusCode == 200) {
        // Récupération des données
        return jsonDecode(res.body);
      } else {
        // Notification d'absence des données de l'utilisateur
        return Future.error('Données indisponibles');
      }
    } catch (err) {
      // Notificatyion d'erreur de la requête
      return Future.error(err);
    }
  }

  // FONCTION DE REQUETE A L'API POUR L'AUTHENTIFICATION
  Future<dynamic> connexion(email, mdp) async {
    // Définition du chemin d'accès aux données de l'api
    String apiUrl = 'http://10.0.2.2:3000/api/mobile/connexion';

    // Traitement de la requête
    try {
      // Requête à l'api
      var res = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'mail': email, 'password': mdp}));
      // Traitement de la réponse
      if (res.statusCode == 200) {
        // Récupération des données
        var dataUser = jsonDecode(res.body);
        // Vérification des statuts de connexion
        if (dataUser['info'] == 'on') {
          // Connexion au compte utilisateur
          final userConnect = User(
              dataUser['id'],
              dataUser['statut'],
              dataUser['email'],
              dataUser['niveauTarif'],
              dataUser['droitReservation']);
          // Confirmation de la connexion
          // return {'statut': 'on', 'utilisateur': dataUser['email']};
          return {'statut': 'on', 'utilisateur': userConnect};
        } else {
          // Traitement en cas de non connexion
          return {'statut': dataUser['info']};
        }
      } else {
        // Notification d'absence des données de l'utilisateur
        return Future.error('off');
      }
    } catch (err) {
      // Notificatyion d'erreur de la requête
      return Future.error(err);
    }
  }
}
