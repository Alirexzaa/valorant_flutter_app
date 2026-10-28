abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

// ⬇️ خطاهای جدید شبکه
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'اتصال به اینترنت را بررسی کنید.']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([
    super.message = 'سرور پاسخ نمی‌دهد. لطفاً دوباره تلاش کنید.',
  ]);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}
