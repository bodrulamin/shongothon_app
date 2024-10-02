import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shongothon/flavors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final List<ItemData> items = [
    ItemData(Icons.home, 'Home'),
    ItemData(Icons.favorite, 'Favorites'),
    ItemData(Icons.settings, 'Settings'),
    ItemData(Icons.person, 'Profile'),
    ItemData(Icons.camera, 'Camera'),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    const defaultPadding = 8.0;
    return Scaffold(
      appBar: AppBar(
              ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: defaultPadding,top: 40,bottom: 40),
                child: Text(
                  'Shongothon',
                  style: TextStyle(fontSize: 40, color: Colors.deepPurple),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  'My Tools',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: items
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Islami Chattra Andolan Bangladesh',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
              ...items
                  .map((item) => Padding(
                        padding:
                            const EdgeInsets.only(left: 25, top: 10, right: 10),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ))
                  .toList(),            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Islami Andolan Bangladesh',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
              ...items
                  .map((item) => Padding(
                        padding:
                            const EdgeInsets.only(left: 25, top: 10, right: 10),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ))
                  .toList(),
              Obx(() => Column(
                  children: controller.orgNames.map((f) => Text(f)).toList())),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalGrid extends StatelessWidget {
  final List<ItemData> items = [
    ItemData(Icons.home, 'Home'),
    ItemData(Icons.favorite, 'Favorites'),
    ItemData(Icons.settings, 'Settings'),
    ItemData(Icons.person, 'Profile'),
    ItemData(Icons.camera, 'Camera'),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) {
          return Container(
            width: 100,
            height: 100, // Adjust the width as needed
            child: GridTile(
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                ),
              ),
              child: Icon(
                item.icon,
                size: 50,
                color: Colors.blue,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ItemData {
  final IconData icon;
  final String title;

  ItemData(this.icon, this.title);
}
