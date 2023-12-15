import 'package:contacts_app/data/service/api_client.dart';
import 'package:contacts_app/data/source/network/model/network_response.dart';

import '../source/network/model/Contact.dart';
import '../source/network/repo/contact_repo.dart';

class ContactRepoImp extends ContactRepo {
  final ApiClient apiClient;

  ContactRepoImp(this.apiClient);

  @override
  Future<NetworkResponse> getContacts() async {
    try {
      var result = await apiClient.get();
      return NetworkSuccess(result);
    } catch (e) {
      return NetworkError(e.toString());
    }
  }

  @override
  Future<NetworkResponse> addContact(Contact contact) async {
    try {
      var result = await apiClient.add(contact);
      if (result.status ?? false) {
        return NetworkSuccess(result.data);
      } else {
        return NetworkError(result.message);
      }
    } catch (e) {
      return NetworkError(e.toString());
    }
  }

  @override
  Future<NetworkResponse> editContact(Contact contact) async {
    try {
      var result = await apiClient.edit(contact);
      if (result.status ?? false) {
        return NetworkSuccess(result.data);
      } else {
        return NetworkError(result.message);
      }
    } catch (e) {
      return NetworkError(e.toString());
    }
  }

  @override
  Future<NetworkResponse> deleteContact(int id) async {
    try {
      var result = await apiClient.delete(id);
      if (result.status ?? false) {
        return NetworkSuccess(result.data);
      } else {
        return NetworkError(result.message);
      }
    } catch (e) {
      return NetworkError(e.toString());
    }
  }
}
