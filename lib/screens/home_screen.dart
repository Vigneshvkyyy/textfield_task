// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/placesupply_textfield.dart';
import 'package:flutter_application_1/widgets/text_textfield.dart';
import 'package:flutter_application_1/widgets/customername_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isView = false;
  late final TextEditingController nameController;
  late final TextEditingController numberController;
  late final TextEditingController supplyController;

  final List<String> _products = [
    'ajay',
    'bala',
    'raj',
    'vignesh',
    'mani',
    'ezhil',
  ];
  List<String> _filteredProducts = [];

  final List<Map<String, String>> _userList = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    numberController = TextEditingController();
    supplyController = TextEditingController();
  }

  void _filterProducts(String query) {
    query = query.toLowerCase();
    setState(() {
      _filteredProducts = _products.where((product) {
        return product.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text("Task"),
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                //===================================================================================//

                TextAndTextFieldWidget(
                  controller: numberController,
                  labelText: 'Invoice Number',
                ),
                //==================================================================================//
                SizedBox(
                  height: size.height * 0.03,
                ),
                //=====================================================================================//
                SizedBox(
                  // color: Colors.grey,
                  height: size.height * 0.28,
                  child: Stack(
                    children: [
                      CustomTextField(
                        labelText: 'Customer Name',
                        controller: nameController,
                        onChanged: (value) {
                          _filterProducts(value);
                          setState(() {});
                        },
                        isView: isView,
                        onTap: () {
                          setState(() {
                            isView = true;
                          });
                        },
                      ),
                      Positioned(
                        top: size.height * 0.15,
                        left: 0,
                        right: 0,
                        child: CustomSupplyTextField(
                          labelText: "Place of Supply",
                          controller: supplyController,
                          isView: true,
                        ),
                      ),
                      if (nameController.text.isNotEmpty &&
                          _filteredProducts.isNotEmpty)
                        Positioned(
                          top: size.height * 0.1,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: size.height * 0.2,
                            color: Colors.black,
                            child: ListView.builder(
                              itemCount: _filteredProducts.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    _filteredProducts[index],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      nameController.text =
                                          _filteredProducts[index];
                                      _filteredProducts.clear();
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                //=====================================================================================//
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                           ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form submitted successfully')),
                    );
                          print('Form is valid');
                        }
                        if (nameController.text.isEmpty |
                                numberController.text.isEmpty ||
                            supplyController.text.isEmpty) {
                          print('Form is Not Valid');
                        } else {
                          _userList.add({
                            'Name': nameController.text,
                            'Number': numberController.text,
                            'Supply': supplyController.text,
                          });
                          nameController.clear();
                          numberController.clear();
                          supplyController.clear();
                         
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.person_add_alt_outlined,
                      size: 24.0,
                      color: Colors.blue,
                    ),
                    label: const Text(
                      'Create Customer',
                      style: TextStyle(color: Colors.blue),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black,
                      ),
                    ),
                  ),
                ),
                //=====================================================================================//
                const Divider(),
                //=====================================================================================//

                SizedBox(
                  height: size.height * 0.02,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      columns: const [
                        DataColumn(label: Text("Invoice Number")),
                        DataColumn(label: Text('Customer Name')),
                        DataColumn(label: Text('Place of Supply')),
                      ],
                      rows:
                          _userList
                              .map(
                                (user) => DataRow(cells: [
                                  DataCell(Text(user['Number'] ?? '')),
                                  DataCell(Text(user['Name'] ?? '')),
                                  DataCell(Text(user['Supply'] ?? '')),
                                ]),
                              )
                              .toList()),
                ),
                //=====================================================================================//
              ],
            ),
          ),
        ),
      ),
    );
  }
}
