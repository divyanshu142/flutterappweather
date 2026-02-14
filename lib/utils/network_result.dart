
// Sealed class defining different states of the network call
sealed class NetworkResult<T> {
  const NetworkResult();
}

class Success<T> extends NetworkResult<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends NetworkResult<T> {
  final String message;
  final T? data; // Optional data in case of partial error
  const Failure(this.message, {this.data});
}

class Loading<T> extends NetworkResult<T> {
  const Loading();
}

class Idle<T> extends NetworkResult<T> {
  const Idle();
}















