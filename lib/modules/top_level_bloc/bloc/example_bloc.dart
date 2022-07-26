import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:live_tracking/models/example.dart';
import 'package:live_tracking/repositories/example_repository.dart';
import 'package:live_tracking/utils/wrappers/error_wrapper.dart';

part 'example_event.dart';

part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleInitial()) {
    on<SearchExample>(_searchExample);
  }

  final _repo = ExampleRepository();

  Future _searchExample(SearchExample event, Emitter emit) async {
    emit(ExampleLoading(state));
    final result = await ErrorWrapper.asyncGuard(
      () => _repo.getExamples(event.key),
      onError: (_) {
        emit(ExampleError(state));
      },
    );

    final data = result.data as List<Example>;

    emit(ExampleLoaded(data));
  }
}
