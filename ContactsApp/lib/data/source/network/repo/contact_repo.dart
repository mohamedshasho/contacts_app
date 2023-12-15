import 'package:contacts_app/data/source/network/model/Contact.dart';
import 'package:contacts_app/data/source/network/model/network_response.dart';

abstract class ContactRepo {
  Future<NetworkResponse> getContacts();
  Future<NetworkResponse> addContact(Contact contact);
  Future<NetworkResponse> editContact(Contact contact);
  Future<NetworkResponse> deleteContact(int id);
}