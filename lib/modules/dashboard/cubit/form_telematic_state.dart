part of 'form_telematic_cubit.dart';

class FormTelematicState extends Equatable {
  const FormTelematicState(
    this.altitude,
    this.speed,
    this.lat,
    this.long,
    this.timestamp,
  );

  // factory FormTelematicState.initial() => const FormTelematicState(
  //       0,
  //       '',
  //       '',
  //       '',
  //       '',
  //     );

  final double altitude;
  final double speed;
  final double lat;
  final double long;
  final DateTime timestamp;

  FormTelematicState copyWith({
    double? altitude,
    double? speed,
    double? lat,
    double? long,
    DateTime? timestamp,
  }) =>
      FormTelematicState(
        altitude ?? this.altitude,
        speed ?? this.speed,
        lat ?? this.lat,
        long ?? this.long,
        timestamp ?? this.timestamp,
      );

  @override
  List<Object?> get props => [altitude, speed, lat, long, timestamp];
}
