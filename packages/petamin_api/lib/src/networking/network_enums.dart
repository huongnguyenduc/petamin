enum NetworkResponseErrorType {
  socket,
  exception,
  responseEmpty,
  didNotSucceed
}

enum CallBackParameterName { all, data }

extension CallbackParameterNameExtension on CallBackParameterName {
  dynamic getJson(json) {
    if (json == null) return null;
    switch (this) {
      case CallBackParameterName.all:
        return json;
      case CallBackParameterName.data:
        return json['data'];
    }
  }
}
