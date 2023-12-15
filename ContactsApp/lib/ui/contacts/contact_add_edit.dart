import 'package:contacts_app/bloc/contacts/contact_controller.dart';
import 'package:contacts_app/data/source/network/model/Contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactAddOrEdit extends StatefulWidget {
  final Contact? contact;

  const ContactAddOrEdit({super.key, this.contact});

  @override
  State<ContactAddOrEdit> createState() => _ContactAddOrEditState();
}

class _ContactAddOrEditState extends State<ContactAddOrEdit> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName, _lastName, _email;
  late int _phoneNumber;

  @override
  Widget build(BuildContext context) {
    var contact = widget.contact;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create contact"),
          leading: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            _buildSubmitButton(),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              customTextField(
                initialValue: contact?.firstName,
                hint: "First Name",
                onSaved: (value) => contact != null
                    ? contact.firstName = value
                    : _firstName = value,
              ),
              const SizedBox(height: 10),
              customTextField(
                hint: "Last Name",
                initialValue: contact?.lastName,
                onSaved: (value) => contact != null
                    ? contact.lastName = value
                    : _lastName = value,
              ),
              const SizedBox(height: 10),
              customTextField(
                hint: "Email",
                initialValue: contact?.email,
                onSaved: (value) =>
                    contact != null ? contact.email = value : _email = value,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  if (value.isNotEmpty && !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              customTextField(
                initialValue: contact?.phone.toString(),
                hint: "Phone Number",
                keyboardType: TextInputType.number,
                onSaved: (value) => contact != null
                    ? contact.phone = int.parse(value!)
                    : _phoneNumber = int.parse(value!),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      if (widget.contact != null) {
        context
            .read<ContactController>()
            .add(EditContactEvent(widget.contact!));
      } else {
        var newContact = Contact(
          firstName: _firstName,
          lastName: _lastName,
          email: _email,
          phone: _phoneNumber,
        );
        context.read<ContactController>().add(AddContactEvent(newContact));
      }
      Navigator.pop(context);
    }
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: _submitForm,
        child: Text(widget.contact != null ? "Update" : "Save"),
      ),
    );
  }

  Widget customTextField({
    String? initialValue,
    required String hint,
    required Function(String?)? onSaved,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: onSaved,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.all(12),
        isDense: true,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  InputDecoration getInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.all(12),
      isDense: true,
      border: const OutlineInputBorder(),
    );
  }
}
