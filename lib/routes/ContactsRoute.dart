import 'package:cognizant_assessment/model/Contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/ContactsBloc.dart';

class ContactsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ContactsBloc>(
            create: (context) => ContactsBloc(),
          )
        ],
        child: ContactWidget(),
      ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  var contactItems = <Data>[];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final contactBloc = BlocProvider.of<ContactsBloc>(context);

    if (contactItems.isEmpty) contactBloc.add(FetchContactsEvent());

    print("widgetbuild");
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
        color: const Color(0xFFEFEBE9),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: TextField(
                onChanged: (value) {
                  contactBloc.add(SearchTextChangedEvent(value));
                },
                // controller: editingController,
                decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Contacts',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 22),
                ),
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<ContactsBloc, ContactsState>(
              builder: (context, state) {
                if (state is LoadingContactsState) {
                  return const Center(child: Text('Loading...'));
                } else if (state is LoadedContactsState) {
                  if (state.searchContactList.isNotEmpty) {
                    contactItems = state.searchContactList;
                  } else {
                    contactItems = state.contactList;
                  }
                  return _showContactListWidget(context);
                } else if (state is ErrorContactsState) {
                  return Center(child: Text('${state.error}'));
                } else {
                  return const Text('');
                }
              },
            ),
          ],
        ),
      ),
    ));
  }

  Widget _showContactListWidget(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: contactItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.pinkAccent),
                      child: Text(
                        contactItems[index].name.substring(0, 2).toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 2, right: 16, top: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contactItems[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              contactItems[index].email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}

/*
BlocBuilder<TextBloc, TextState>(builder: (context, state) {
if(state is TextUpdatedState){
contactItems = totalContactItems
    .where((item) => item.name.toLowerCase().contains(state.newText.toLowerCase()))
    .toList();
}*/
