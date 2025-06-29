import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_tasks/view/my_settings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                title: Text(
                  'P O C K E T S \nT A S K S',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                title: Text('H O M E', style: GoogleFonts.inter()),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                title: Text('S E T T I N G S', style: GoogleFonts.inter()),
                leading: Icon(Icons.settings),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MySettings()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
