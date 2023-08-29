import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:resolve/controller/auth_api.dart';
import 'package:resolve/controller/project_api.dart';

import '../config/config.dart';
import '../models/category_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _HomeState();
}

class _HomeState extends State<MainPage> {
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;
  TextEditingController _categoryName = TextEditingController();
  TextEditingController _categoryDescription = TextEditingController();

// ADD GET CATEGORIES
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          categorieDialog(context);
        },
        backgroundColor: const Color(0xFF598BB4),
        elevation: 10,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
                height: AppConst.getHeight(context) * 0.8,
                child: categoryList())),
      ),
    );
  }

  Widget categoryList() {
    return FutureBuilder<List<CategoryModel>>(
      future: ProjectApi.getCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
                height: 100, width: 100, child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.data!.isEmpty) {
            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Bienvenue, ',
                      style: TextStyle(fontSize: 26),
                    ),
                    Text(
                      'Iheb',
                      style: TextStyle(color: Color(0xFF598BB4), fontSize: 28),
                    )
                  ],
                ),
                SizedBox(
                  height: 250,
                ),
                Center(
                  child: Text('Pour créer une categorie, clickez sur +'),
                )
              ],
            );
          } else {
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      'Bienvenue, ',
                      style: TextStyle(fontSize: 26),
                    ),
                    Text(
                      'Iheb',
                      style: TextStyle(color: Color(0xFF598BB4), fontSize: 28),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final CategoryModel = snapshot.data![index];
                      final pic = (CategoryModel.image.split("\\"))[1];
                      print(pic);
                      return Card(
                          child: Column(
                        children: <Widget>[
                          ListTile(
                            //NAVIGATE TO PROJECTS LIST
                            onTap: () {},
                            leading: new Image.network(
                              "${AppConst.url}/uploads/${pic}",
                              fit: BoxFit.cover,
                              width: 100.0,
                            ),
                            title: Text(
                              CategoryModel.name,
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Description test',
                                      style: new TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal)),
                                  Text('Nbr Projets: ',
                                      style: new TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.normal)),
                                ]),
                          )
                        ],
                      ));
                      // ListTile(
                      //   title: Text(CategoryModel.name),
                      //   leading: CircleAvatar(
                      //       radius: 50,
                      //       backgroundColor: Colors.white,
                      //       child: Image.network(
                      //         "${AppConst.url}/uploads/${pic}",
                      //         height: 100,
                      //         width: 100,
                      //       )),
                      // );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }

  Future<dynamic> categorieDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                  title: const Text(
                    "Création d'une Categorie",
                    style: TextStyle(fontSize: 20),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('Nom du Categorie'),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: _categoryName,
                            maxLines: 1,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Description'),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: _categoryDescription,
                            maxLines: 1,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Choisir une image'),
                        const SizedBox(
                          height: 10,
                        ),
                        isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () async {
                                  try {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.any,
                                      allowMultiple: false,
                                    );
                                    if (result != null) {
                                      _fileName = result!.files.first.name;
                                      pickedFile = result!.files.first;
                                      fileToDisplay =
                                          File(pickedFile!.path.toString());
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: const Text(
                                  'Image',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize: const Size.fromHeight(50),
                                    backgroundColor: const Color(0xFF333A56)),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (pickedFile != null)
                          SizedBox(
                            height: 100,
                            width: 200,
                            child: Image.file(fileToDisplay!),
                          ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_categoryName.text.isNotEmpty &&
                                pickedFile != null) {
                              //AuthApi.loginUser(email: "ggsdsd@gmail.com", password: "fqfe");
                              ProjectApi.addCategory(
                                  categoryName: _categoryName.text,
                                  pickedFile: pickedFile!,
                                  fileToDisplay: fileToDisplay!);
                            }

                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Créer',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  )),
            ));
  }
}
