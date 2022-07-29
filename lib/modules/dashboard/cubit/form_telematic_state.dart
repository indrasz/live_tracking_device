part of 'form_telematic_cubit.dart';

class FormTelematicState extends Equatable {
  const FormTelematicState(this.email, this.password);

  factory FormTelematicState.initial() => const FormTelematicState(
        kDebugMode ? 'dashboard.dev@transtrack.id' : '',
        kDebugMode ? '1234qwer' : '',
      );

  final String email;
  final String password;

  FormTelematicState copyWith({
    String? email,
    String? password,
  }) =>
      FormTelematicState(
        email ?? this.email,
        password ?? this.password,
      );

  @override
  List<Object?> get props => [email, password];
}
