abstract class Failure {
  final String message;
  const Failure(this.message);
}

// خطای مربوط به سرور، شبکه یا API
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// خطای مربوط به حافظه گوشی (وقتی نه اینترنت هست، نه کش)
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
