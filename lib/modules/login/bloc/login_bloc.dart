import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:live_tracking/helpers/navigation_helper.dart';
import 'package:live_tracking/helpers/user_helper.dart';
import 'package:live_tracking/repositories/auth_repository.dart';
import 'package:live_tracking/utils/enums.dart';
import 'package:live_tracking/utils/wrappers/error_wrapper.dart';

import '../../../helpers/flash_message_helper.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitEvent>(_loginSubmit);
  }

  final _repo = AuthRepository();

  Future _loginSubmit(LoginSubmitEvent event, Emitter emit) async {
    emit(LoginLoading());
    await ErrorWrapper.asyncGuard(
      () => _repo.submitLogin(event.email, event.password),
      onError: (e) {
        emit(LoginInitial());
        GetIt.I<FlashMessageHelper>().showError("User not found");
      },
    );

    final user = GetIt.I<UserHelper>().getUser();
    emit(LoginInitial());

    if (user != null) {
      GetIt.I<NavigationHelper>().goToDashboard();
    }

    //TODO: Add logic to navigate to dashboard
  }
}
