import 'package:donatelife/utils/appstyles.dart';
import 'package:donatelife/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Appstyles.mainColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 2,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/unnamed.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Blood Donation App",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Your Name..",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Your Email...",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Appstyles.mainColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    style: BorderStyle.solid,
                    width: 2,
                  )),
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.home,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text(
                            'Home',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.check_circle,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text(
                            'Donors Emailed!',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.handshake,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text(
                            'Same BG as me',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {},
                        ),
                        const Divider(
                          color: Colors.white,
                          height: 2,
                        ),
                        const Text(
                          "Blood Groups",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.handshake,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text(
                            'Same BG as me',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {},
                        ),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
