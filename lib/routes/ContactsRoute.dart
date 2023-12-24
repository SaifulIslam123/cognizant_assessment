import 'package:cognizant_assessment/model/Contact.dart';
import 'package:cognizant_assessment/network/Result.dart' as result;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/DataBloc.dart';

/*
class ContactsRoute extends StatefulWidget {
  const ContactsRoute({super.key});

  @override
  State<StatefulWidget> createState() => _ContactsRoute();
}

class _ContactsRoute extends State<ContactsRoute> {
  TextEditingController editingController = TextEditingController();

  final List<String> entries = <String>['Samir', 'Karima', 'Adil', 'aadil','Saiful','khalid','jon dow','rubel'];
  var contactItems = <String>[];

  @override
  void initState() {
    entries.sort((a, b) => a.toUpperCase().compareTo(b.toUpperCase()));
    contactItems = entries;
    super.initState();
  }

  void filterSearchResults(String query) {
    setState(() {
      contactItems = entries
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
        color: const Color(0xFFEFEBE9),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16,bottom: 16),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)))),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Contacts',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 22),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
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
                                  color: Colors.cyan),
                              child: const Text('B'),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 2, right: 16, top: 16, bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contactItems[index],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'test@gmail.com',
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
                    }))
          ],
        ),
      ),
    ));
  }
}
*/

class ContactsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => DataBloc(),
        child: ContactWidget(),
      ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataBloc = BlocProvider.of<DataBloc>(context).add(FetchDataEvent());
    return Scaffold(
      body: Center(
        child: BlocBuilder<DataBloc, DataState>(
          builder: (context, state) {
            if (state is InitialDataState) {
              return const Text('Loading...');
            } else if (state is LoadedDataState) {
              Contact contact = (state.data as result.Result).data as Contact;
              contact.data?.forEach((element) {
                print("${element.name} \n");
              });
              return Text('Data: ${contact.data?.length}');
            } else if (state is ErrorDataState) {
              return Text('${state.error}');
            } else {
              return const Text('');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // dataBloc.add(FetchDataEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
