import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          actions: [
            // DropdownButton(items: items, onChanged: onChanged),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: DropdownButton(
                alignment: Alignment.bottomLeft,
                enableFeedback: true,
                icon: Icon(Icons.more_vert_outlined, color: Colors.black),
                items: ['Modifier le Profil']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {},
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Container(
              height: Get.height * .40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/epa.jpg"),
                    radius: 60,
                    // child: DropdownButton(
                    //     items: ['Modifier le Profil']
                    //         .map<DropdownMenuItem<String>>((String value) {
                    //   return DropdownMenuItem<String>(
                    //     value: value,
                    //     child: Text(value),
                    //   );
                    // }).toList()),
                  ),
                  Text(
                    'Kadiongo ilunga',
                    style: Get.textTheme.titleLarge,
                  ),
                  Row(
                    children: [
                      MaterialButton(
                          onPressed: null, child: Text('Modifier le Profil'))
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: Get.height * .60,
              color: Colors.grey[200],
            )
          ],
        ),
      ),
    );
  }
}
