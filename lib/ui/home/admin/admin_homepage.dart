import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/models/course.dart';
import 'package:new_digitendance/app/models/institution.dart';
import 'package:new_digitendance/app/utilities.dart';
import 'package:new_digitendance/ui/authentication/login/login_page.dart';
import 'package:new_digitendance/ui/home/admin/courses_page.dart';
import 'package:new_digitendance/ui/shared/shimmers.dart';

import '../../authentication/state/auth_state.dart';
import '../../authentication/state/authentication_notifier.dart';
import 'state/admin_state.dart';

class AdminAppHomePage extends ConsumerWidget {
  AdminAppHomePage({Key? key}) : super(key: key);

  var thisRef;

  late BuildContext _context;
  var notifier;

  Widget? onError(Object error, StackTrace? stackTrace) {}

  Widget onLoading() => const BusyShimmer();

  Widget? onData(Iterable<Course> data) {
    // data.map((event) => event.docs.map((e) => Course.fromMap(e.data())));
    var coursesList = data.toList();

    Utils.log('printing onData ${data.toString()}');
    // Institution institution = Institution.fromJson

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'get inst title',
            // instutution.title!,
            // style: Theme.of(context).textTheme.headline3),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Wrap(
            alignment: WrapAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const HomeMenuCard(
                iconData: Icons.auto_stories,
                title: 'Courses',
              ),
              const HomeMenuCard(
                // assetName: 'student.jpg',
                iconData: Icons.people,
                title: 'Students',
              ),
              const HomeMenuCard(
                // assetName: 'faculty.png',
                iconData: Icons.school,
                title: 'Faculty',
              ),
              const HomeMenuCard(
                // assetName: 'about.png',
                iconData: Icons.info,
                title: 'About Digitendance',
              ),
              const HomeMenuCard(
                // assetName: 'settings.png',
                iconData: Icons.settings,
                title: 'Settings',
              ),
              const HomeMenuCard(
                // assetName: 'reports.jpg',
                iconData: Icons.bar_chart_sharp,
                title: 'Reports',
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              notifier.signOut();
            },
            child: Text('Log out ')),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // thisRef = ref;
    final allAdminCourses = ref.watch(allCoursesStreamProvider);
    AuthenticationNotifier notifier =
        thisRef.read(authenticationNotifierProvider.notifier);
    thisRef = ref;
    _context = context;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                // AuthenticationNotifier notifier =
                //     thisRef.read(authenticationNotifierProvider.notifier);
                notifier.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => LoginPage())));
              },
              icon: const Icon(Icons.logout),
              iconSize: 40,
            ),
          ],
        ),
        body: Center(
          child: Center(
            child: allAdminCourses.when(
                data: onData, error: onError, loading: onLoading),
          ),
        ));

    // ListView.builder(itemBuilder: (context,index){return ListTile(title: Text(availableCourses![index].courseTitle!),);}),
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     const Text('Admin Home'),
    //     ElevatedButton(
    //         onPressed: () {
    //           thisRef.read(authStateNotifierProvider.notifier).signOut();
    //           Navigator.of(context).pushReplacement(
    //             MaterialPageRoute(
    //               builder: ((context) => LoginPage()),
    //             ),
    //           );
    //         },
    //         child: const Text('Log out ')),
    // ],
    // );
  }
}

class HomeMenuCard extends StatelessWidget {
  const HomeMenuCard({Key? key, required this.iconData, required this.title})
      : super(key: key);

  // final String assetName;
  final IconData iconData;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.20,
        margin: EdgeInsets.all(8),
        height: 220,
        child: InkWell(
          hoverColor: Colors.purple.shade300,
          splashColor: Colors.purple.shade100,
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CoursesPage()));
          },
          child: Card(
            // shape: Bordersh(),
            elevation: 25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  size: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
