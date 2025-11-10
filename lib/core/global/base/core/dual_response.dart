abstract class DualResponse<E, S> {
  dynamic fold({
    required void Function(S success) onSuccess,
    required void Function(E error) onError,
  });

  void getData();
}

class SuccessReponse<E, S> extends DualResponse<E, S> {
  SuccessReponse(this.data);

  S data;
  @override
  dynamic fold({
    required void Function(E error) onError,
    required void Function(S success) onSuccess,
  }) {
    onSuccess(data);
  }

  @override
  S getData() => data;
}

class ErrorResponse<E, S> extends DualResponse<E, S> {
  ErrorResponse(this.data);

  E data;
  @override
  dynamic fold({
    required void Function(E error) onError,
    required void Function(S success) onSuccess,
  }) {
    onError(data);
  }

  @override
  E getData() => data;
}

class VoidResponse {}
