import 'package:contacts_app/bloc/contacts/contact_controller.dart';
import 'package:contacts_app/ui/contacts/contact_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/contact_item.dart';
import '../utils/Constants.dart';
import 'contact_add_edit.dart';

class ContactApp extends StatefulWidget {
  const ContactApp({super.key});

  @override
  State<ContactApp> createState() => _ContactAppState();
}

class _ContactAppState extends State<ContactApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contacts"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => const ContactAddOrEdit()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add_ic_call),
                    SizedBox(width: 20),
                    Text(
                      "Create new contact",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            BlocConsumer<ContactController, ContactState>(
                listener: (ctx, state) {
              if (state is ContactStateLoaded && state.message != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message ?? "Unknown Error")));
              }
            }, builder: (ctx, state) {
              if (state is ContactStateLoaded) {
                var contacts = state.contacts;
                return ListView.builder(
                  itemCount: contacts.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    var color = getRandomColor();
                    return ContactItem(
                      contact: contacts[index],
                      color: color,
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => ContactShow(
                              color: color,
                              contact: contacts[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
              if (state is ContactStateLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return const Center(
                child: Text("No Contact Found"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
