import 'package:cognizant_assessment/model/Contact.dart';
import 'package:cognizant_assessment/routes/CircularChartRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  var _contactItems = <Data>[];
  late MediaQueryData _mediaQuery;
  late ContactsBloc _contactBloc;

  @override
  Widget build(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    _contactBloc = BlocProvider.of<ContactsBloc>(context);

    if (_contactItems.isEmpty) _contactBloc.add(FetchContactsEvent());

    return Scaffold(
        body: SafeArea(
      child: Container(
        height: _mediaQuery.size.height,
        width: _mediaQuery.size.width,
        color: const Color(0xFFEFEBE9),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _showSearchTextField(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
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
            _prepareContactBlocBuilder(),
          ],
        ),
      ),
    ));
  }

  Widget _showSearchTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: TextField(
        onChanged: (value) {
          _contactBloc.add(SearchTextChangedEvent(value));
        },
        // controller: editingController,
        decoration: const InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)))),
      ),
    );
  }

  Widget _showContactListWidget(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _contactItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                child: InkWell(
                  onTap: () {
                    Get.to(CircularChartRoute());
                  },
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
                          _contactItems[index]
                              .name
                              .substring(0, 2)
                              .toUpperCase(),
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
                                _contactItems[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _contactItems[index].email,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
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
                ),
              );
            }));
  }

  BlocBuilder _prepareContactBlocBuilder() {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        if (state is LoadingContactsState) {
          return const Center(
              child: Text('Loading...',
                  style: TextStyle(fontSize: 18, color: Colors.black87)));
        } else if (state is LoadedContactsState) {
          if (state.searchContactList.isNotEmpty) {
            _contactItems = state.searchContactList;
          } else {
            _contactItems = state.contactList;
          }
          return _showContactListWidget(context);
        } else if (state is ErrorContactsState) {
          return Center(
              child: Text(state.error,
                  style: const TextStyle(fontSize: 16, color: Colors.black87)));
        } else {
          return const Text('');
        }
      },
    );
  }
}
