abstract class Failure {
  final String mensaje;

  const Failure([this.mensaje = 'Ocurrió un error inesperado.']);
}

// Aquí puedes añadir tus fallas específicas que hereden de Failure
// Por ejemplo:

class ServerFailure extends Failure {
  const ServerFailure([super.mensaje = 'Error del servidor. Intenta de nuevo más tarde.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.mensaje = 'No hay conexión a internet.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.mensaje = 'Error al acceder a la caché.']);
}
