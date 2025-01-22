import 'dart:io';

import 'result.dart';

Future<Result<String>> fetchDataFromApi() async {
  try {
    // Simulamos un fallo o éxito aleatorio
    await Future.delayed(
        const Duration(seconds: 2)); // Simulamos una llamada de red

    bool isSuccess = DateTime.now().second % 2 == 0; // Resultado aleatorio

    // Aqui se crea el objeto Result, tanto ok como error
    if (isSuccess) {
      return Result.ok("Datos obtenidos exitosamente");
    } else {
      return Result.error(
          const HttpException("Hubo un error al obtener los datos"));
    }
  } catch (error) {
    return Result.error(Exception("Error desconocdio: $error"));
  }
}
