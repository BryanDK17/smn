import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaFavoritos extends StatefulWidget {
  @override
  _PaginaFavoritosState createState() => _PaginaFavoritosState();
}

class _PaginaFavoritosState extends State<PaginaFavoritos> {
  List<dynamic> municipios = [];
  List<String> favoritos = [];

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    await cargarMunicipios();
    await cargarFavoritos();
    setState(() {});
  }

  Future<void> cargarMunicipios() async {
    final String respuesta =
        await rootBundle.loadString('assets/data/datos_municipios.json');
    municipios = json.decode(respuesta);
  }

  Future<void> cargarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    favoritos = prefs.getStringList('favoritos') ?? [];
  }

  String idMunicipio(dynamic m) => '${m["id_edo"]}_${m["id_mpo"]}';

  @override
  Widget build(BuildContext context) {
    List<dynamic> municipiosFavoritos = municipios
        .where((m) => favoritos.contains(idMunicipio(m)))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Municipios Favoritos'),
      ),
      body: municipiosFavoritos.isEmpty
          ? Center(child: Text('No hay municipios en favoritos.'))
          : ListView.builder(
              itemCount: municipiosFavoritos.length,
              itemBuilder: (context, index) {
                final municipio = municipiosFavoritos[index];
                final id = idMunicipio(municipio);
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.favorite, color: Colors.red),
                    title: Text(municipio['label']),
                    subtitle: Text('ID: $id'),
                    onTap: () {
                      // Aquí puedes cargar el pronóstico si tienes la lógica
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Pronóstico para ${municipio['label']}'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // Si tuvieras una pantalla de pronóstico, puedes hacer:
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (_) => PaginaPronostico(municipio: municipio),
                      // ));
                    },
                  ),
                );
              },
            ),
    );
  }
}
