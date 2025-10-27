import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teacherapp/router/routers.dart';

import 'logout_dialog.dart';

class CardItem {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  CardItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  });
}

class DrawerPage extends ConsumerWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    List<CardItem> cardItems = [
      // CardItem(
      //   imagePath:'assets/parents.png',
      //   title: 'My Profile',
      //   onTap: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (_) => rParentProfilePage()),
      //     );
      //   },
      // ),

      CardItem(
        imagePath: 'assets/logout.png',
        title: 'LogOut',
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => LogoutConfirmationDialog(),
          );
        },
      ),

      CardItem(
        imagePath: 'assets/password.png',
        title: 'Change Password',
        onTap: () {
          Navigator.of(context).pop(); // 👈 Closes the dialog first
          context.go(ChangePasswordRoute().location);
          // 👈 Then navigate using go_router
        },
      ),

      CardItem(
        imagePath: 'assets/ace.png',
        title: 'About Us',
        onTap: () {
          Navigator.of(context).pop(); // 👈 Closes the dialog first
          context.go(AboutUsScreenRoute().location);
        },
      ),

      CardItem(
        imagePath: 'assets/almanac.png',
        title: 'Change Academic Year',
        onTap: () {
          Navigator.of(context).pop(); // 👈 Closes the dialog first
          context.go(ChangeAcademicRoute().location);
        },
      ),

      //   // Add the new Share App card here
      //   CardItem(
      //     imagePath: 'assets/share.png', // Add an appropriate icon for sharing
      //     title: 'Share App',
      //     onTap: () {
      //       Share.share(
      //         'Download Evolvu: Smart Schooling App https://play.google.com/store/apps/details?id=in.aceventura.evolvuschool', // Replace with your app link
      //         subject: 'Parent App!',
      //       );
      //     },
      //   ),

      //   CardItem(
      //     imagePath: 'assets/ace.png',
      //     title: 'About Us',
      //     onTap: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (_) => AboutUsPage(academic_yr:academic_yr,shortName: shortName)),
      //       );
      //     },
      //   ),

      //   CardItem(
      //     imagePath: 'assets/ace.png',
      //     title: 'ID Card',
      //     onTap: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (_) => AboutUsPage(academic_yr:academic_yr,shortName: shortName)),
      //       );
      //     },
      //   ),
      //   // Add more CardItems here...
      // ];
    ];
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(top: 65, bottom: 0, left: 0, right: 0),
      child: Stack(
        clipBehavior: Clip.none,
        // This allows the Positioned widget to go outside the Stack's bounds
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 245, 241, 241),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: cardItems.map((cardItem) {
                  return InkWell(
                    onTap: cardItem.onTap,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(cardItem.imagePath, width: 45, height: 42),
                        SizedBox(height: 8),
                        Text(
                          cardItem.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Positioned(
            top: -50, // Adjust this value to place the button above the dialog
            right: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.close, color: Colors.black, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}