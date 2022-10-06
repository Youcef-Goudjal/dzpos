enum Status {
  initial,
  success,
  loading,
  failure;

  bool get isInitial => this == Status.initial;
  bool get isFailure => this == Status.failure;
  bool get isSuccess => this == Status.success;
  bool get isLoading => this == Status.loading;
}
