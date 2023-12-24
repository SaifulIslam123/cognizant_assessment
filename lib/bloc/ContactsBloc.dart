import 'package:bloc/bloc.dart';
import 'package:cognizant_assessment/repository/ContactRepository.dart';
import '../model/Contact.dart';
import '../network/Result.dart';

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

  ContactsBloc() : super(InitailContactsState());

  @override
  ContactsState get initialState => InitailContactsState();

  @override
  Stream<ContactsState> mapEventToState(ContactsEvent event) async* {
    if (event is FetchContactsEvent) {
      yield LoadingContactsState();
      try {
        final response = await _repository.getContactList();
        Contact contact = response.data as Contact;

        contact.data?.sort(
            (a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
        yield LoadedContactsState(contact.data ?? [], []);
      } catch (e) {
        yield ErrorContactsState('Failed to load data. Error: $e');
      }
    } else if (event is SearchTextChangedEvent) {
      LoadedContactsState loadState = state as LoadedContactsState;

      if (event.newText.isEmpty) {
        yield LoadedContactsState(loadState.contactList, []);
      } else {
        List<Data> searchList = loadState.contactList
            .where((item) =>
                item.name.toLowerCase().contains(event.newText.toLowerCase()))
            .toList();
        yield LoadedContactsState(loadState.contactList, searchList);
      }
    }
  }
}
