import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/util/helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

import '../logic/providers/auth_provider.dart';

class CreateRequest extends StatefulWidget {
  const CreateRequest({Key? key}) : super(key: key);

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  final db = FirebaseFirestore.instance;
  late Authentication auth;

  @override
  void initState() {
    super.initState();
    auth = Provider.of<Authentication>(context, listen: false);

    // crudMethods.getData().then((results) {
    //   jobSnapshot = results;
    // });
  }

  // Text contorllers
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  String? category,
      title,
      authorName,
      address,
      description,
      phoneNumber,
      subjects;

  File? selectedImage;
  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // Future getImage() async {
  //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     selectedImage = File(image!.path);
  //   });
  // }

  uploadPost() async {
    if (selectedImage != null) {
      setState(() {
        isLoading = true;
      });
      //Uploading an Image to Firebase Storage

      Reference ref = FirebaseStorage.instance
          .ref()
          .child("jobImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      await ref.putFile(selectedImage!);
      ref.getDownloadURL().then((value) {
        //imageUrl = value;
      });
    } else {}
  }

  uploadRequest() {
    //showProgress(context, 'Creating Job', true);
    db.collection("tutorRequests").add(
      {
        //'imageUrl': ,
        'requestTitle': titleController.text.trim(),
        'subject': subjectController.text.trim(),
        'address': addressController.text.trim(),
        'author': authorController.text.trim(),
        'phoneNumber': phoneNumController.text.trim(),
      },
    );

    showSnackBar(context, "Request was Created Successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff404040),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Create",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Text(
              "Request",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // uploadJob();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.upload,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/logo_finder.png",
                        width: 150,
                        height: 150,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            key: formkey,
                            controller: titleController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: "Request Title",
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            onChanged: (val) {
                              title = val;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: subjectController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: "Interested Subject",
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            onChanged: (val) {
                              subjects = val;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: "Address",
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            onChanged: (val) {
                              address = val;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: authorController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: "Requester Name",
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            onChanged: (val) {
                              authorName = val;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: phoneNumController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: "Phone Number",
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            onChanged: (val) {
                              phoneNumber = val;
                            },
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurple,
                                fixedSize: Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                uploadRequest();
                              },
                              icon: Icon(Icons.add),
                              label: Text("Create Tutor Request"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
