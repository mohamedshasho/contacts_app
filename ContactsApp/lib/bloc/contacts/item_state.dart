

part of 'contact_controller.dart';

abstract class ContactState {}

class ContactStateInitial extends ContactState {}

class ContactStateLoading extends ContactState {}
class ContactStateUpdated extends ContactState {}

class ContactStateError extends ContactState {
  final String? message;
  ContactStateError(this.message);
}

class ContactStateLoaded extends ContactState {
  final List<Contact> contacts;
  final String? message;
  ContactStateLoaded({required this.contacts, this.message});
}