abstract class NetworkResponse<T> {
  const NetworkResponse();
}

class NetworkLoading extends NetworkResponse<void> {
  const NetworkLoading();
}

class NetworkSuccess<T> extends NetworkResponse<T> {
  final T data;
  const NetworkSuccess(this.data);
}

class NetworkError extends NetworkResponse<void> {
  final String? message;
  const NetworkError(this.message);
}
