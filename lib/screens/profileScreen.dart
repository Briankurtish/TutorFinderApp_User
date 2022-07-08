import 'package:finder_app/screens/aboutApp_screen.dart';
import 'package:finder_app/screens/account_screen.dart';
import 'package:finder_app/screens/contactUs.dart';
import 'package:finder_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../logic/providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Authentication auth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = Provider.of<Authentication>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Profile",
            style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: Center(
          // Profile Pic
          child: Column(
            children: [
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // const CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //       "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
                    // ),
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: Container(
                    //     height: 46,
                    //     width: 46,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       shape: BoxShape.circle,
                    //       border: Border.all(color: Colors.deepPurple),
                    //     ),
                    //     child: Icon(Icons.camera_alt),
                    //   ),
                    // ),
                    Image.asset(
                      "assets/logo_finder.png",
                      width: 500,
                      height: 500,
                    ),
                  ],
                ),
              ),
              // Profile Menu
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountScreen()));
                  },
                  child: Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.person_outline,
                            color: Colors.deepPurple,
                            size: 25,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              "My Acoount",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactUsScreen()));
                  },
                  child: Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.contact_phone_outlined,
                            color: Colors.deepPurple,
                            size: 25,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              "Contact Us",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AboutAppScreen()));
                  },
                  child: Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.info_outline,
                            color: Colors.deepPurple,
                            size: 25,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              "About App",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.help_center,
                          color: Colors.deepPurple,
                          size: 25,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            "Help Center",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    auth.logout();
                  },
                  child: Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.logout_outlined,
                            color: Colors.deepPurple,
                            size: 25,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              "Log Out ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
