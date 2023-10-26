import 'package:flutter/material.dart';
import 'package:project/views/add_new_contacr.dart';
import 'package:project/views/home.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.family,
    required this.work,
    required this.web,
  });

  final String name, phone, email, family, work, web;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _familyController = TextEditingController();
  TextEditingController _workController = TextEditingController();
  TextEditingController _webController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;
    _nameController.text = widget.name;
    _familyController.text = widget.family;
    _workController.text = widget.work;
    _webController.text = widget.web;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Contact")),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter any name" : null,
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Name"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Phone"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Email"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _familyController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Family"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _workController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Work"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _webController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Web"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 65,
                    width: MediaQuery.of(context).size.width * .9,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Update the contact using the provided data
                          CRUDService().updateContact(
                            _nameController.text,
                            _phoneController.text as Contact,
                            _emailController.text,
                            _familyController.text,
                            _workController.text,
                            _webController.text,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(fontSize: 16),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
