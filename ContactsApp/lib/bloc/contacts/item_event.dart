part of 'contact_controller.dart';

abstract class ContactEvent {}

class ContactEventInitial extends ContactEvent {}

class GetContactsEvent extends ContactEvent {}

class AddContactEvent extends ContactEvent {
  final Contact contact;

  AddContactEvent(this.contact);
}
class EditContactEvent extends ContactEvent {
  final Contact contact;
  EditContactEvent(this.contact);
}
class DeleteContactEvent extends ContactEvent {
  final int id;

  DeleteContactEvent(this.id);
}