// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutable, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/models/tutor_jobs.dart';
import 'package:finder_app/screens/create_request.dart';
import 'package:finder_app/screens/job_posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finder_app/data/categories.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../logic/providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final categoryContainer = Category.generateCategory();
  late Authentication auth;

  List<TutorJobsModel> jobItems = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = Provider.of<Authentication>(context, listen: false);
    fetchRecords();
  }

  fetchRecords() async {
    var records =
        await FirebaseFirestore.instance.collection("tutorJobs").get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map(
          (jobItem) => TutorJobsModel(
            uid: jobItem.id,
            jobTitle: jobItem['jobTitle'],
            subjects: jobItem['subject'],
            description: jobItem['description'],
            address: jobItem['address'],
            author: jobItem['author'],
            phoneNumber: jobItem['phoneNumber'],
          ),
        )
        .toList();

    setState(() {
      jobItems = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: Colors.deepPurple,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<Authentication>(builder: (_, auth, __) {
                          return Text(
                            'Hello ' + auth.loggedUser!.username,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          );
                        }),
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                          },
                          child: GestureDetector(
                            onTap: () {
                              auth.logout();
                            },
                            child: Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Welcome to FindTutor where you can get to any tutor you wish from home!",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 270,
                          child: TextField(
                            //controller: _emailController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Find Tutor",
                              hintStyle: TextStyle(color: Colors.deepPurple),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Search",
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  fixedSize: Size(200, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateRequest()));
                },
                icon: Icon(Icons.add),
                label: Text("Create Tutor Request"),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Tutor Offers",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => JobPosts()));
                    },
                    child: Text(
                      "See all",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Recent Tutor Jobs
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: jobItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: ((context) => JobDetails())));
                      },
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.deepPurple),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          leading: CircleAvatar(
                            child: Text(
                              jobItems[index].jobTitle[0],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            backgroundColor: Colors.deepPurple,
                          ),
                          title: Text(
                            jobItems[index].jobTitle,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Contact: " + jobItems[index].phoneNumber,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.green),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // const SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Categories",
            //         style: TextStyle(
            //           fontSize: 25,
            //           color: Colors.black,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       const SizedBox(height: 10),
            //       Container(
            //         height: 200,
            //         width: double.maxFinite,
            //         //margin: const EdgeInsets.only(left: 20),
            //         child: ListView.builder(
            //             itemCount: categoryContainer.length,
            //             scrollDirection: Axis.horizontal,
            //             itemBuilder: (_, index) {
            //               return Container(
            //                 margin: const EdgeInsets.only(right: 20),
            //                 child: Column(
            //                   children: [
            //                     Container(
            //                       //margin: const EdgeInsets.only(right: 50),
            //                       width: 150,
            //                       height: 200,
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(20),
            //                         color: Colors.greenAccent,
            //                       ),
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(20),
            //                         child: Text("Primary Level"),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               );
            //             }),
            //       ),
            //     ],
            //   ),
            // ),

            //Featured tutors

            const SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             "Requested Tutors",
            //             style: TextStyle(
            //               fontSize: 25,
            //               color: Colors.black,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           Text(
            //             "See all",
            //             style: TextStyle(
            //                 color: Colors.deepPurple,
            //                 fontWeight: FontWeight.bold),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 20),
            //       Container(
            //         height: 200,
            //         width: double.maxFinite,
            //         //margin: const EdgeInsets.only(left: 20),
            //         child: ListView.builder(
            //             itemCount: 6,
            //             scrollDirection: Axis.horizontal,
            //             itemBuilder: (_, index) {
            //               return Container(
            //                 margin: const EdgeInsets.only(right: 20),
            //                 child: Column(
            //                   children: [
            //                     Container(
            //                       //margin: const EdgeInsets.only(right: 50),
            //                       width: 150,
            //                       height: 200,
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(20),
            //                         color: Colors.orangeAccent,
            //                       ),
            //                       child: Padding(
            //                         padding: const EdgeInsets.only(
            //                             left: 40, top: 50, bottom: 60, right: 40),
            //                         // Button Delete
            //                         child: Column(
            //                           children: [
            //                             Padding(
            //                               padding:
            //                                   const EdgeInsets.only(bottom: 20),
            //                               child: Text(
            //                                 "Mr John",
            //                                 style: TextStyle(
            //                                   color: Colors.deepPurple,
            //                                   fontWeight: FontWeight.bold,
            //                                 ),
            //                               ),
            //                             ),
            //                             GestureDetector(
            //                               child: Container(
            //                                 height: 50,
            //                                 width: 70,
            //                                 decoration: BoxDecoration(
            //                                   color: Colors.white,
            //                                   borderRadius:
            //                                       BorderRadius.circular(10),
            //                                 ),
            //                                 child: Padding(
            //                                   padding:
            //                                       const EdgeInsets.only(top: 7),
            //                                   child: Text(
            //                                     "Delete Request",
            //                                     style: TextStyle(
            //                                       color: Colors.red,
            //                                       fontWeight: FontWeight.bold,
            //                                       fontSize: 15,
            //                                     ),
            //                                     textAlign: TextAlign.center,
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               );
            //             }),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
