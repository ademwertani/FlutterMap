//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Pour gérer les coordonnées des lieux
import 'package:url_launcher/url_launcher.dart';
import 'package:contacts_service/contacts_service.dart';

void main() {
  runApp(MyApp());
}
class MapPage extends StatelessWidget {
  final Address address;

  MapPage({required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carte de ${address.name}'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(address.latitude, address.longitude),
          zoom: 15.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 40.0,
                height: 40.0,
                point: LatLng(address.latitude, address.longitude),
                builder: (ctx) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_pin),
                    color: Colors.blue,
                    iconSize: 30.0,
                    onPressed: () {
                      // Vous pouvez ajouter une action lorsqu'on clique sur le marqueur
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddressListPage(addresses: addresses),
    );
  }
}



class AddressListPage extends StatelessWidget {
  final List<Address> addresses;

  AddressListPage({required this.addresses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des adresses'),
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(addresses[index].name),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressDetailPage(address: addresses[index]),
                  ),
                );
              },




              trailing: GestureDetector(
                child: Icon(Icons.map, size: 24, color: Colors.blue,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapPage(address: addresses[index]),
                ),
              );
            },
          )
          );
        },
      ),
    );
  }
}


class Address {
  final String name;
  final double latitude;
  final double longitude;
  final String localisation;
  final  telephone;

  Address({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.localisation,
    required this.telephone,
  });

  //Address();

//Address({required this.name, required this.latitude, required this.longitude});
}
class AddressDetailPage extends StatelessWidget {
  final Address address;

  AddressDetailPage({required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de ${address.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nom: ${address.name}"),
            SizedBox(height: 12),
            Text("Latitude: ${address.latitude}"),
            SizedBox(height: 12),
            Text("Longitude: ${address.longitude}"),
            SizedBox(height: 12),
            Text("Localisation: ${address.localisation}"),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    _showContactOptionsSheet(context); // Affiche le menu d'options
                  },
                  child: Text(
                    "Numéro de téléphone: ${address.telephone}",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Ajoutez d'autres informations que vous souhaitez afficher
          ],
        ),
      ),
    );
  }

  void _showContactOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Appeler le numéro'),
                onTap: () {
                  Navigator.pop(context); // Ferme le menu d'options
                 // _makePhoneCall('tel:${address.telephone}');
                },
              ),
              ListTile(
                leading: Icon(Icons.save),
                title: Text('Enregistrer le numéro'),
                onTap: () {
                  Navigator.pop(context); // Ferme le menu d'options
                 // _saveContact(context); // Passez le context ici également
                },
              ),
            ],
          ),
        );
      },
    );
  }


  // Fonction pour lancer un appel téléphonique
  /*
  void _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible de lancer l\'appel $url';
    }
  }

// Fonction pour lancer un appel téléphonique
  void _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible de lancer l\'appel $url';
    }
  }

// Fonction pour enregistrer le numéro dans le répertoire
  void _saveContact(BuildContext context) async {
    final contact = Contact();
    contact.phones = [Item(label: 'Mobile', value: address.telephone.toString())];
    await ContactsService.addContact(contact);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Numéro enregistré dans le répertoire.')),
    );
  }
*/
}

List<Address> addresses = [
  Address(name: 'Dr Mohamed mourad BEN KHALIFA', latitude: 33.884334168654654, longitude: 10.10410151063253, localisation: 'Immeuble Oumayma center, avenue mongi slim ( au dessus magasin ZEN) Gabes Medina 6000 Gabes Tunisie', telephone:  75278133 ),
  Address(name: 'Dr Omar BEN HAJ SAID', latitude: 36.80949791637098, longitude: 10.138681739565031, localisation: "8 avenue Habib bourguiba. Bardo medrar centre 4ème étage Le Bardo 2000 Tunis Tunisie", telephone:  71507753 ),
   Address(name: 'Dr Lotfi JALLALI', latitude: 36.73663324640673, longitude: 10.208617041410395, localisation: "1 شارع الشهداء المركب الطبي ابن منظور المروج El Mourouj 1 2074 Ben arous Tunisie", telephone: 71363135 ),
  Address(name: 'Dr Samia KEFI', latitude: 36.85897438763227, longitude: 10.257368770250013, localisation: "El aouina médical 44Av de l'environnement Cabinet A5 1 étage L'Aouina L'aouina 2045 Tunis Tunisie", telephone: 20551401),
  Address(name: 'Dr Issam eddine ELLEUCH', latitude: 36.82630327128026, longitude: 10.194111251211575, localisation: "Cité el khadra voie x2 1003 tunis en face de ibn zohr Cite El Khadra 1003 Tunis Tunisie", telephone: 98775150 ),
  Address(name: 'Dr Elyes BEN SMIDA', latitude: 36.830915491464935, longitude: 10.31456721257823, localisation: "208 avenue Habib BOURGUIBA Le Kram Medical 1er etage Le Kram 2015 Tunis Tunisie", telephone: 99585064),
  // Ajoutez autant d'adresses que nécessaire
];
