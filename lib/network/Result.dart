class Result<T> {
  Status status;
  T? data;
  String? message;
  int responseCode = 0;

  Result.loading() : status = Status.LOADING;
  Result.success(this.data, this.message) : status = Status.SUCCESS;
  Result.error(this.message,this.responseCode) : status = Status.ERROR;

  @override
  String toString() {
    return 'Result{status: $status, data: $data, message: $message, responseCode: $responseCode}';
  }
}

enum Status { LOADING, SUCCESS, ERROR }

