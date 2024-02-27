part of "internet_connectivity_bloc.dart";

@freezed
class InternetConnectivityState with _$InternetConnectivityState {
  const factory InternetConnectivityState.initial() = _Initial;
  const factory InternetConnectivityState.connected({
    required ConnectivityResult connectivityResult,
  }) = _Connected;
  const factory InternetConnectivityState.disConnected() = _DisConnected;

  const InternetConnectivityState._();

  bool get isConnected {
    if (this is _Connected) {
      return true;
    }
    return false;
  }
}
