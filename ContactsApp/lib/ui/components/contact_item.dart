import 'package:contacts_app/data/source/network/model/Contact.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Color color;
  final Function()? onClick;
  late final String name;

  ContactItem(
      {super.key, required this.contact, required this.color, this.onClick}) {
    handleName();
  }

  void handleName() {
    bool firstNameEmpty = contact.firstName?.isNotEmpty ?? false;
    bool lastNameEmpty = contact.lastName?.isNotEmpty ?? false;
    String firstName = contact.firstName ?? "";
    String lastName = contact.lastName ?? "";
    name = (firstNameEmpty || lastNameEmpty)
        ? "$firstName $lastName"
        : contact.phone.toString();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Center(
                child: Text(
                  name[0],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
