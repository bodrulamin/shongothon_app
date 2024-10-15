import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shongothon/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final double defaultPadding = 16.0;

  final List<ItemData> items = [
    ItemData(Icons.home, 'Home'),
    ItemData(Icons.message_rounded, 'Chat'),
    ItemData(Icons.settings, 'Settings'),
    ItemData(Icons.person, 'Profile'),
    ItemData(Icons.logout, 'Logout'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: buildBody(),
      bottomNavigationBar: buildBottomNav(),
    );
  }

  Widget buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchData(); // Await if this function returns a Future
      },
      child: SafeArea(
        child: Obx(
          () => ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shongothon',
                        style: GoogleFonts.abel(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent, // Updated color
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.search, color: Colors.grey),
                            onPressed: () {},
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.blueAccent, // Updated color
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(defaultPadding),
              //   child: Text(
              //     'Online Users',
              //     style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w400,
              //       color: Colors.grey[700],
              //     ),
              //   ),
              // ),
              // buildOnlinePersons(),
              SizedBox(height: 20),
              ...controller.organizations.entries
                  .map((organization) => buildOrgCard(organization))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrgCard(MapEntry<dynamic, dynamic> organizationMap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    height: 100,
                    child: Image.network(organizationMap.value['logoUrl'])),
              ),
              SizedBox(height: 12),
              Center(
                child: Text(
                  organizationMap.key,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ...organizationMap.value['branches']
                  .map((b) => buildBranchList(b))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBranchList(String branchName) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      child: ListTile(
        onTap: () {},
        title: Text(branchName),
        leading: Icon(Icons.location_city, color: Colors.blueAccent),
      ),
    );
  }

  SingleChildScrollView buildOnlinePersons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(item.icon, size: 30, color: getRandomColor()),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Obx buildBottomNav() {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: (index) {
          controller.currentIndex.value = index;
          if (index == 4) {
            Get.offAllNamed(Routes.SIGNIN);
          }
        },
        elevation: 20,
        backgroundColor: Colors.white, // Lighter background
        selectedItemColor: Colors.blueAccent, // Updated color
        unselectedItemColor: Colors.grey[400],
        items: items
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.title,
                ))
            .toList(),
      ),
    );
  }
}

class ItemData {
  final IconData icon;
  final String title;

  ItemData(this.icon, this.title);
}

Color getRandomColor() {
  Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
