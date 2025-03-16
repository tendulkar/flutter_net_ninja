import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FormEvent {
  const FormEvent();
}

class UpdateFormEvent extends FormEvent {
  final String key;
  final dynamic value;
  const UpdateFormEvent(this.key, this.value);
}

class FormState {
  final Map<String, dynamic> data;
  const FormState({required this.data});

  FormState copyWith(String key, dynamic value) {
    final newData = Map<String, dynamic>.from(data);
    newData[key] = value;
    return FormState(data: newData);
  }
}

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(const FormState(data: {})) {
    on<UpdateFormEvent>((event, emit) {
      final data = state.copyWith(event.key, event.value);
      emit(data);
    });
  }
}
