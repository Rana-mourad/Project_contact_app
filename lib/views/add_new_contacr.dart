import 'package:project/views/home.dart';

class CRUDService {
  // Add new contacts (this is just a local list for demonstration)
  List<Contact> contacts = [];

  void addNewContact(String name, String phone, String email) {
    final newContact = Contact(
        name: name, phone: phone, email: email, family: '', work: '', web: '');
    contacts.add(newContact);
  }

  Stream<List<Contact>> getContacts({String? searchQuery}) async* {
    List<Contact> filteredContacts = List.from(contacts);

    if (searchQuery != null && searchQuery.isNotEmpty) {
      filteredContacts = filteredContacts
          .where((contact) =>
              contact.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    yield filteredContacts;
  }

  void updateContact(String name, Contact newContact, String phone,
      String family, String email, String web) {
    final index = contacts.indexWhere((contact) => contact.name == name);
    if (index != -1) {
      contacts[index] = newContact;
    }
  }

  void deleteContact(String name) {
    contacts.removeWhere((contact) => contact.name == name);
  }
}
