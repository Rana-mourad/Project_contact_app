import 'package:flutter/material.dart';
import 'package:project/views/home.dart';

class ContactDetails extends StatefulWidget {
  final Contact contact;

  ContactDetails({required this.contact});

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _familyController = TextEditingController();
  TextEditingController _workController = TextEditingController();
  TextEditingController _webController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with contact details
    _nameController = TextEditingController(text: widget.contact.name);
    _familyController = TextEditingController(text: widget.contact.family);
    _phoneController = TextEditingController(text: widget.contact.phone);
    _workController = TextEditingController(text: widget.contact.work);
    _emailController = TextEditingController(text: widget.contact.email);
    _webController = TextEditingController(text: widget.contact.web);
  }

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    _nameController.dispose();
    _familyController.dispose();
    _phoneController.dispose();
    _workController.dispose();
    _emailController.dispose();
    _webController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                // Save the contact
                saveContact();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to save the contact
  void saveContact() {
    final updatedContact = Contact(
      name: _nameController.text,
      family: _familyController.text,
      phone: _phoneController.text,
      work: _workController.text,
      email: _emailController.text,
      web: _webController.text,
    );
    Navigator.pop(context, updatedContact);
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
