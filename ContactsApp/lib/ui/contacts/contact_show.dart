import 'package:contacts_app/bloc/contacts/contact_controller.dart';
import 'package:contacts_app/data/source/network/model/Contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contact_add_edit.dart';

class ContactShow extends StatefulWidget {
  final Color color;
  final Contact contact;

  const ContactShow({Key? key, required this.color, required this.contact})
      : super(key: key);

  @override
  State<ContactShow> createState() => _ContactShowState();
}

class _ContactShowState extends State<ContactShow> {
  late String name;
  late Contact _contact;

  @override
  void initState() {
    super.initState();
    _contact = widget.contact;
    handleName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) =>
                      ContactAddOrEdit(contact: Contact.clone(_contact)),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDeleteConfirmationDialog(
                context,
                () {
                  Navigator.pop(context);
                },
              );
            },
          ),
        ],
      ),
      body: BlocListener<ContactController, ContactState>(
        listener: (_, state) {
          if (state is ContactStateLoaded) {
            Contact newContact = state.contacts.firstWhere(
              (element) => element.id == _contact.id,
              orElse: () => _contact,
            );
            if (newContact != _contact) {
              _contact = newContact;
              setState(() {});
              handleName();
            }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
              ),
              child: Center(
                child: Text(
                  name[0],
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Card(
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Contact info"),
                      const SizedBox(height: 5),
                      ListTile(
                        title: Text(_contact.phone.toString()),
                        subtitle: const Text("Mobile"),
                        leading: const Icon(Icons.phone),
                        trailing: const Icon(Icons.message),
                      ),
                      _contact.email != null
                          ? ListTile(
                              title: Text(_contact.email.toString()),
                              subtitle: const Text("Email"),
                              leading: const Icon(Icons.email),
                              trailing: const Icon(Icons.alternate_email),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(
    BuildContext context,
    Function()? onDeleted,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this contact?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                if (_contact.id != null) {
                  context
                      .read<ContactController>()
                      .add(DeleteContactEvent(_contact.id!));
                  onDeleted?.call();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void handleName() {
    bool firstNameEmpty = _contact.firstName?.isNotEmpty ?? false;
    bool lastNameEmpty = _contact.lastName?.isNotEmpty ?? false;
    String firstName = _contact.firstName ?? "";
    String lastName = _contact.lastName ?? "";
    name = (firstNameEmpty || lastNameEmpty)
        ? "$firstName $lastName"
        : _contact.phone.toString();
  }
}
