part of "internet_connectivity_bloc.dart";

@freezed
class InternetConnectivityEvent with _$InternetConnectivityEvent {
  const factory InternetConnectivityEvent.onInternetConnected() =
      _InternetConnected;
  const factory InternetConnectivityEvent.onInternetDisconnected() =
      _InternetDisconnected;
}
