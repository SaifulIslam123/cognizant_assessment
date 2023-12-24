import 'package:bloc/bloc.dart';
import 'package:cognizant_assessment/repository/ContactRepository.dart';
import 'package:equatable/equatable.dart';

abstract class DataEvent {}

class FetchDataEvent extends DataEvent {}

abstract class DataState {}

class InitialDataState extends DataState {}

class LoadedDataState extends DataState {
  final dynamic data;

  LoadedDataState(this.data);
}

class ErrorDataState extends DataState {
  final String error;

  ErrorDataState(this.error);
}

class DataBloc extends Bloc<DataEvent, DataState> {
  final ContactRepository _repository = ContactRepository();

  DataBloc() : super(InitialDataState());

  @override
  DataState get initialState => InitialDataState();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is FetchDataEvent) {
      yield InitialDataState();
      try {
        final contacts = await _repository.getContactList();
        yield LoadedDataState(contacts);
      } catch (e) {
        yield ErrorDataState('Failed to load data. Error: $e');
      }
    }
  }
}
