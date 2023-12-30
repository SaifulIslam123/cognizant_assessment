import 'package:bloc/bloc.dart';
import 'package:cognizant_assessment/repository/ContactRepository.dart';
import '../model/Contact.dart';
import '../network/Result.dart' as Result;

abstract class ContactsEvent {}

class SearchTextChangedEvent extends ContactsEvent {
  final String newText;

  SearchTextChangedEvent(this.newText);
}

class SearchTextChangedState extends ContactsState {
  final String newText;

  SearchTextChangedState(this.newText);
}

class FetchContactsEvent extends ContactsEvent {}

abstract class ContactsState {}

class InitailContactsState extends ContactsState {}

class LoadingContactsState extends ContactsState {}

class LoadedContactsState extends ContactsState {
  final List<Data> contactList;
  final List<Data> searchContactList;

  LoadedContactsState(this.contactList, this.searchContactList);
}

class ErrorContactsState extends ContactsState {
  final String error;

  ErrorContactsState(this.error);
}

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactRepository _repository = ContactRepository();

  ContactsBloc() : super(InitailContactsState()) {
    on<FetchContactsEvent>((event, emit) async {
      emit(LoadingContactsState());
      try {
        final response = await _repository.getContactList();

        if (response.status == Result.Status.SUCCESS) {
          Contact contact = response.data as Contact;

          contact.data?.sort(
              (a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
          emit(LoadedContactsState(contact.data ?? [], []));
        } else if (response.status == Result.Status.ERROR) {
          emit(ErrorContactsState(response.message ?? ""));
        }
      } catch (e) {
        emit(ErrorContactsState('Failed to load data. Error: $e'));
      }
    });
    on<SearchTextChangedEvent>((event, emit) async {
      LoadedContactsState loadState = state as LoadedContactsState;

      if (event.newText.isEmpty) {
        emit(LoadedContactsState(loadState.contactList, []));
      } else {
        List<Data> searchList = loadState.contactList
            .where((item) =>
                item.name.toLowerCase().contains(event.newText.toLowerCase()))
            .toList();
        emit(LoadedContactsState(loadState.contactList, searchList));
      }
    });
  }
}
