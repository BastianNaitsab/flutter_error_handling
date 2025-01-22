import 'package:flutter/material.dart';

import 'fetchDataFromApi.dart';
import 'result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Result<String>> _fetchResult;

  @override
  void initState() {
    super.initState();
    _fetchResult =
        fetchDataFromApi(); // Llamamos a la función que retorna el Result
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manejo de error Result")),
      body: Center(
        child: FutureBuilder<Result<String>>(
          future: _fetchResult,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Mostramos cargando mientras obtenemos datos
            }

            if (snapshot.hasError) {
              return Text("Error inesperado: ${snapshot.error}");
            }

            if (snapshot.hasData) {
              final result = snapshot.data;

              // Verificamos si el resultado es un éxito o un error
              // Desenrollamos el objeto Result
              switch (result) {
                case Ok<String>():
                  return Text(
                    result.value, // Aqui se obtiene el valor
                    style: const TextStyle(fontSize: 24, color: Colors.green),
                  ); // Caso de éxito

                case Error<String>():
                  return Text(
                    result.error.toString(), // Aqui se obtiene el error
                    style: const TextStyle(fontSize: 24, color: Colors.red),
                  ); // Caso de error
                default:
              }
            }

            return Container(); // En caso de que no haya datos o esté vacío
          },
        ),
      ),
    );
  }
}
