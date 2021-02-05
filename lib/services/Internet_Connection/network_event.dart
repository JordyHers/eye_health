import 'package:eye_test/services/Internet_Connection/bloc.dart';

abstract class NetworkEvent {}

class ListenConnection extends NetworkEvent {}

class ConnectionChanged extends NetworkEvent {
  NetworkState connection;
  ConnectionChanged(this.connection);
}