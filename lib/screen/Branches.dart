// import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../Colors.dart/MxColors.dart';
import 'QR_Scanner.dart';

class Data {
  final String name;
  final int id;

  Data({required this.name, required this.id});
}

class BranchScreen extends StatefulWidget {
  const BranchScreen({super.key});

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  List<Data> allBranches = [];
  List<Data> filteredBranches = [];
  String searchQuery = ''; //Step 1:
  // String query = ''; //Step 2
  @override
  void initState() {
    super.initState();
    getAllBranches().then((branches) {
      setState(() {
        allBranches = branches;
        filteredBranches = branches;
      });
    });
  }

  Future<List<Data>> getAllBranches() async {
    const url = "https://api.mixayexpress.com/api/dropships_all";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var jsonArray = jsonData['data'];

      List<Data> branches = [];
      for (var jsonBranchNamesModel in jsonArray) {
        var branch = Data(
            name: jsonBranchNamesModel['name'], id: jsonBranchNamesModel['id']);
        branches.add(branch);
      }
      return branches;
    } else {
      throw Exception('Failed to load branches ${response.statusCode}');
    }
  }

  void filterBranches(String query) {
    getAllBranches().then((branches) {
      setState(() {
        allBranches = branches;
        filteredBranches = allBranches
            .where((branch) =>
                branch.name.toLowerCase().contains(query.toLowerCase()) ||
                branch.id.toString().contains(query))
            .toList();
      });
    }).catchError((error) {
      print('Error fetching branches: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MxColors.mainColorRed,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Scaffold(
          backgroundColor: MxColors.mainColorWhite,
          appBar: AppBar(
            backgroundColor: MxColors.mainColorWhite,
            title: const Text(
              "เลือกสาขา",
              style: TextStyle(
                fontSize: 25,
                color: MxColors.titleColorBlack,
              ),
            ),
            iconTheme: const IconThemeData(color: MxColors.titleColorBlack),
            centerTitle: true,
            elevation: 0,
            leading: filteredBranches.length != allBranches.length
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: MxColors.mainColorRed,
                    ),
                    onPressed: () {
                      setState(() {
                        filteredBranches = allBranches;
                      });
                    },
                  )
                : null,
            // leading: Image.asset('assets/images/logo.png'),
          ),
          body: FutureBuilder<List<Data>>(
            future: getAllBranches(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(MxColors.mainColorRed),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                // List<Data> branches = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      color: MxColors.mainColorWhite,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 20),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 20),
                          cursorColor: MxColors.subtitleColorBlue,
                          decoration: InputDecoration(
                            hintText: 'ค้นหา...',
                            hintStyle: const TextStyle(
                                color: MxColors.hintStyleColorGrey),
                            filled: true,
                            fillColor: MxColors.mainColorWhite,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 0),
                            prefixIcon: const Icon(Icons.search),
                            prefixIconColor: MxColors.iconColorGrey,
                            // suffixIcon: IconButton(
                            //   icon: const Icon(Icons.search),
                            //   color: const Color.fromRGBO(244, 31, 31, 1),
                            //   iconSize: 35,
                            //   onPressed: () {
                            //     filterBranches(query);
                            //   },
                            // ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: MxColors
                                    .mainColorRed, // Set the border color here
                                width:
                                    2.0, // Set the border width here (optional)
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: MxColors
                                    .mainColorRed, // Set the border color here
                                width:
                                    1, // Set the border width here (optional)
                              ),
                            ),
                          ),
                          onSubmitted: (value) {
                            // setState(() {
                            //   query = value;
                            // });
                            filterBranches(value);
                          },
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 7,
                    // ),
                    Expanded(
                      child: filteredBranches.isEmpty
                          ? const Center(
                              child: Text(
                                'No information found.',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: MxColors.hintStyleColorGrey),
                              ), // Step 2: Display a message when no information is found
                            )
                          : ListView.builder(
                              itemCount: filteredBranches.length,
                              itemBuilder: (context, index) {
                                var branch = filteredBranches[index];
                                return Card(
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                        backgroundColor:
                                            MxColors.mainColorWhite,
                                        child: Icon(
                                          Icons.store_rounded,
                                          size: 30,
                                          color: MxColors.mainColorRed,
                                        )),
                                    // iconColor: Colors.white,
                                    title: Row(
                                      children: [
                                        Text(
                                          branch.id.toString(),
                                          style: const TextStyle(
                                              fontSize: 22,
                                              color:
                                                  MxColors.subtitleColorBlue),
                                        ),
                                        const SizedBox(
                                            width:
                                                12), // Adjust the width as needed to create spacing between id and name
                                        Expanded(
                                          child: Text(
                                            branch.name,
                                            style: const TextStyle(
                                                fontSize: 22,
                                                color:
                                                    MxColors.titleColorBlack),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const QRCodeScannerScreen()),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('No data available'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
