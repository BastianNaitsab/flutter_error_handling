import 'package:flutter/material.dart';

import 'fetchDataFromApi.dart';
import 'result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
      appBar: AppBar(title: const Text("Manejo de Resultados")),
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
