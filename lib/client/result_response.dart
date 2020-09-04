class ResultResponse<T> {
  int httpCode;
  T data;

  ResultResponse({
    this.httpCode,
    this.data,
  });

  ResultResponse.fromResponse({int httpCode, T result}) {
    this.httpCode = httpCode;
    data = result;
  }
}