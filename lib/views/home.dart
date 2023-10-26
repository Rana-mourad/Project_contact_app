import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: ContactApp(),
  ));
}

class ContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact App')),
      body: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Contact> contacts = [];
  TextEditingController _searchController = TextEditingController();
  List<Contact> displayedContacts = [];

  @override
  void initState() {
    super.initState();
    contacts = loadContacts();
    displayedContacts = List.from(contacts);
  }

  void makePhoneCall(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void deleteContact(Contact contact) {
    setState(() {
      contacts.remove(contact);
      displayedContacts.remove(contact);
      saveContacts(contacts);
    });
  }

  void editContact(Contact contact) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditContact(
          contact: contact,
          onUpdateContact: (updatedContact) {
            final index = contacts.indexWhere((c) => c.name == contact.name);
            if (index != -1) {
              setState(() {
                contacts[index] = updatedContact;
                saveContacts(contacts);
              });
            }
          },
        ),
      ),
    );
  }

  List<Contact> loadContacts() {
    return [
      Contact(
        name: "Shimaa Elamir",
        phone: "123-456-7890",
        email: '',
        family: '',
        work: '',
        web: '',
      ),
      Contact(
        name: "Rana Elamir",
        phone: "987-654-3210",
        email: '',
        family: '',
        work: '',
        web: '',
      ),
      Contact(
        name: "Elamir",
        phone: "987-654-3210",
        email: '',
        family: '',
        work: '',
        web: '',
      ),
    ];
  }

  void saveContacts(List<Contact> contacts) {
    // Implement the logic to save contacts to local storage here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  displayedContacts = contacts
                      .where((contact) => contact.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedContacts.length,
              itemBuilder: (context, index) {
                final contact = displayedContacts[index];
                return Dismissible(
                  key: Key(contact.name),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(16),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.blue,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(16),
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      deleteContact(contact);
                    } else if (direction == DismissDirection.startToEnd) {
                      editContact(contact);
                    }
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(contact.name[0]),
                    ),
                    title: Text(contact.name),
                    subtitle: Text(contact.phone),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.call),
                          onPressed: () {
                            makePhoneCall(contact.phone);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteContact(contact);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            editContact(contact);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddContact(
                contacts: contacts,
                onAddContact: (newContact) {
                  contacts.add(newContact);
                  saveContacts(contacts);
                },
              ),
            ),
          );
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}

class Contact {
  final String name;
  final String phone;
  final String family;
  final String work;
  final String email;
  final String web;

  Contact({
    required this.name,
    required this.phone,
    required this.family,
    required this.work,
    required this.email,
    required this.web,
  });
}

class ContactDetails extends StatelessWidget {
  final Contact contact;

  ContactDetails({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${contact.name}'),
            Text('Phone: ${contact.phone}'),
            Text('Family: ${contact.family}'),
            Text('Work: ${contact.work}'),
            Text('Email: ${contact.email}'),
            Text('Web: ${contact.web}'),
          ],
        ),
      ),
    );
  }
}

class AddContact extends StatefulWidget {
  final List<Contact> contacts;
  final Function(Contact) onAddContact;

  AddContact({required this.contacts, required this.onAddContact});

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _familyController = TextEditingController();
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _webController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextFieldWithIcon(_nameController, 'Name', Icons.person),
            _buildTextFieldWithIcon(_phoneController, 'Phone', Icons.phone),
            _buildTextFieldWithIcon(
                _familyController, 'Family', Icons.family_restroom),
            _buildTextFieldWithIcon(_workController, 'Work', Icons.work),
            _buildTextFieldWithIcon(_emailController, 'Email', Icons.email),
            _buildTextFieldWithIcon(_webController, 'Web', Icons.web),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final phone = _phoneController.text;
                final family = _familyController.text;
                final work = _workController.text;
                final email = _emailController.text;
                final web = _webController.text;
                if (name.isNotEmpty && phone.isNotEmpty) {
                  final newContact = Contact(
                    name: name,
                    phone: phone,
                    family: family,
                    work: work,
                    email: email,
                    web: web,
                  );
                  widget.onAddContact(newContact);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add Contact'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditContact extends StatefulWidget {
  final Contact contact;
  final Function(Contact) onUpdateContact;

  EditContact({required this.contact, required this.onUpdateContact});

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _familyController = TextEditingController();
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _webController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.contact.name;
    _phoneController.text = widget.contact.phone;
    _familyController.text = widget.contact.family;
    _workController.text = widget.contact.work;
    _emailController.text = widget.contact.email;
    _webController.text = widget.contact.web;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextFieldWithIcon(_nameController, 'Name', Icons.person),
            _buildTextFieldWithIcon(_phoneController, 'Phone', Icons.phone),
            _buildTextFieldWithIcon(
                _familyController, 'Family', Icons.family_restroom),
            _buildTextFieldWithIcon(_workController, 'Work', Icons.work),
            _buildTextFieldWithIcon(_emailController, 'Email', Icons.email),
            _buildTextFieldWithIcon(_webController, 'Web', Icons.web),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final phone = _phoneController.text;
                final family = _familyController.text;
                final work = _workController.text;
                final email = _emailController.text;
                final web = _webController.text;
                if (name.isNotEmpty && phone.isNotEmpty) {
                  final updatedContact = Contact(
                    name: name,
                    phone: phone,
                    family: family,
                    work: work,
                    email: email,
                    web: web,
                  );
                  widget.onUpdateContact(updatedContact);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Update Contact'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTextFieldWithIcon(
    TextEditingController controller, String label, IconData icon) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon), // Add the icon here
    ),
  );
}
