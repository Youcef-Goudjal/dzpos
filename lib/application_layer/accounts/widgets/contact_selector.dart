import 'package:contacts_service/contacts_service.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactSelector extends StatefulWidget {
  const ContactSelector({super.key});

  @override
  State<ContactSelector> createState() => _ContactSelectorState();
}

class _ContactSelectorState extends State<ContactSelector> {
  bool isSelectionMode = true;
  List<Contact> staticData = [];
  Map<int, bool> selectedFlag = {};
  @override
  void initState() {
    super.initState();
    requestContact().then((value) {
      staticData = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select accounts"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: staticData.length,
              itemBuilder: (context, index) {
                Contact data = staticData[index];
                selectedFlag[index] = selectedFlag[index] ?? false;
                bool isSelected = selectedFlag[index]!;
                return ListTile(
                  onTap: () => onTap(isSelected, index),
                  title: Text("${data.displayName}"),
                  subtitle: Text(
                      "${(data.phones?.isNotEmpty ?? false) ? data.phones?.first.value : ""}"),
                  leading: _buildSelectIcon(isSelected, data),
                );
              },
            ),
          ),
          10.heightBox,
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              onPressed: () {
                List<Contact> result = [];
                selectedFlag.forEach((key, value) {
                  if (value) {
                    result.add(staticData[key]);
                  }
                });
                Navigator.pop(context, result);
              },
              label: const Center(child: Text("Save")),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButton: _buildSelectAllButton(),
    );
  }

  Future<List<Contact>> requestContact() async {
    if (await Permission.contacts.request().isGranted) {
      print("permission is granted");
      final contacts = await ContactsService.getContacts(withThumbnails: false);
      return contacts;
    } else {
      throw Exception("Permission Not Granted");
    }
  }

  onTap(bool isSelected, int index) {
    if (isSelectionMode) {
      setState(() {
        selectedFlag[index] = !isSelected;
        isSelectionMode = selectedFlag.containsValue(true);
      });
    }
  }

  _buildSelectIcon(bool isSelected, Contact data) {
    if (isSelectionMode) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: Theme.of(context).primaryColor,
      );
    } else {
      return CircleAvatar(
        child: Text('${data.displayName?.substring(0, 2)}'),
      );
    }
  }

  _buildSelectAllButton() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    if (isSelectionMode) {
      return FloatingActionButton(
        onPressed: _selectAll,
        child: Icon(
          isFalseAvailable ? Icons.done_all : Icons.remove_done,
        ),
      );
    }
    return null;
  }

  void _selectAll() {}
}
