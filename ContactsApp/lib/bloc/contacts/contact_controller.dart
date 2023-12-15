import 'package:contacts_app/data/source/network/model/Contact.dart';
import 'package:contacts_app/data/source/network/model/network_response.dart';
import 'package:contacts_app/data/source/network/repo/contact_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_state.dart';

part 'item_event.dart';

class ContactController extends Bloc<ContactEvent, ContactState> {
  final ContactRepo repo;
  List<Contact> _contacts = [];

  static ContactController get(context) => BlocProvider.of(context);

  ContactController(this.repo) : super(ContactStateInitial()) {
    on<GetContactsEvent>((event, emit) async {
      emit(ContactStateLoading());
      var result = await repo.getContacts();
      if (result is NetworkSuccess) {
        _contacts = result.data;
        emit(ContactStateLoaded(contacts: _contacts));
      }
      if (result is NetworkError) {
        emit(ContactStateError(result.message));
      }
    });

    on<AddContactEvent>((event, emit) async {
      var result = await repo.addContact(event.contact);
      if (result is NetworkSuccess) {
        _contacts.add(result.data);
        emit(ContactStateLoaded(contacts: _contacts));
      }
      if (result is NetworkError) {
        emit(ContactStateLoaded(contacts: _contacts, message: result.message));
      }
    });

    on<DeleteContactEvent>((event, emit) async {
      var result = await repo.deleteContact(event.id);
      if (result is NetworkSuccess) {
        var contact = result.data;
        _contacts.removeWhere((item) => item.id == contact.id);
        emit(ContactStateLoaded(contacts: _contacts));
      }
      if (result is NetworkError) {
        emit(ContactStateLoaded(contacts: _contacts, message: result.message));
      }
    });

    on<EditContactEvent>((event, emit) async {
      var result = await repo.editContact(event.contact);
      if (result is NetworkSuccess) {
        var contact = result.data;
        // Find the index of the contact to update
        int indexOfContactToUpdate = _contacts.indexWhere((item) =>
        item.id == contact.id);
        if (indexOfContactToUpdate != -1) {
          // Replace the existing contact with the updated contact
          _contacts[indexOfContactToUpdate] = contact;
          emit(ContactStateLoaded(contacts: _contacts));
        }
      }
      if (result is NetworkError) {
        emit(ContactStateLoaded(contacts: _contacts, message: result.message));
      }
    });
  }
}
