import 'package:demoapp/components/colors.dart';
import 'package:demoapp/components/drawer_screen.dart';
import 'package:demoapp/screens/profile_screen.dart';
import 'package:demoapp/screens/add_post_screen.dart';
import 'package:demoapp/screens/chat_screen.dart';
import 'package:demoapp/screens/updatescreen.dart';
import 'package:demoapp/screens/view_job.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbRef = FirebaseDatabase.instance.ref().child('Posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
        title: const Text(
          'Feeds',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: dbRef.child('Post List'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 4.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                    (snapshot.value
                                        as Map<dynamic, dynamic>)['profileUrl'],
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProfileScreen()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            (snapshot.value as Map<dynamic,
                                                dynamic>)['profileUrl'],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                '  Posted By ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                (snapshot.value
                                    as Map<dynamic, dynamic>)['uEmail'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey.shade300.withValues(alpha: 1),
                          ),
                          ClipRRect(
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * .25,
                              placeholder: 'assets/obs5.png',
                              image: (snapshot.value
                                  as Map<dynamic, dynamic>)['pImage'],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              (snapshot.value
                                  as Map<dynamic, dynamic>)['pTitle'],
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              (snapshot.value
                                  as Map<dynamic, dynamic>)['pDescription'],
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        barColor: fourthcolor,
        controller: FloatingBottomBarController(initialIndex: 1),
        bottomBar: [
          BottomBarItem(
            icon: const Icon(
              Icons.home,
              size: 30,
            ),
            iconSelected: const Icon(Icons.home, color: primarycolor, size: 30),
            title: 'Home',
            dotColor: primarycolor,
            onTap: (value) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          BottomBarItem(
            icon: const Icon(Icons.chat, size: 30),
            iconSelected: const Icon(Icons.chat, color: primarycolor, size: 30),
            title: 'Discussion',
            dotColor: primarycolor,
            onTap: (value) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ChatScreen()));
            },
          ),
          BottomBarItem(
            icon: const Icon(Icons.person_search, size: 30),
            iconSelected:
                const Icon(Icons.person_search, color: primarycolor, size: 30),
            title: 'View Jobs',
            dotColor: primarycolor,
            onTap: (value) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const JobListPage()));
            },
          ),
          BottomBarItem(
            icon: const Icon(Icons.notifications_on_rounded, size: 30),
            iconSelected: const Icon(Icons.notifications_on_rounded,
                color: primarycolor, size: 30),
            title: 'Updates',
            dotColor: primarycolor,
            onTap: (value) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UpdateScreen()));
            },
          ),
        ],
        bottomBarCenterModel: BottomBarCenterModel(
          centerBackgroundColor: primarycolor,
          centerIcon: const FloatingCenterButton(
            child: Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
          centerIconChild: [
            FloatingCenterButtonChild(
                child: const Icon(
                  Icons.add_a_photo,
                  color: AppColors.white,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddPostScreen()));
                }),
          ],
        ),
      ),
    );
  }
}

class RepostPage1 extends StatelessWidget {
  final Map<dynamic, dynamic> post;

  const RepostPage1({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: post['pTitle']);
    final TextEditingController descriptionController =
        TextEditingController(text: post['pDescription']);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Repost Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            Image.network(
              post['pImage'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final newPost = {
                    'pTitle': titleController.text,
                    'pDescription': descriptionController.text,
                    'pImage': post['pImage'],
                    'profileUrl': post['profileUrl'],
                    'uEmail': post['uEmail'],
                    'isReposted': true,
                  };
                  FirebaseDatabase.instance
                      .ref()
                      .child('Posts')
                      .child('Post List')
                      .push()
                      .set(newPost)
                      .then((_) {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  });
                },
                child: const Text("Repost"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RepostPage extends StatelessWidget {
  final Map<dynamic, dynamic> post;

  const RepostPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: post['pTitle']);
    final TextEditingController descriptionController =
        TextEditingController(text: post['pDescription']);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Repost Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            Image.network(
              post['pImage'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final newPost = {
                    'pTitle': titleController.text,
                    'pDescription': descriptionController.text,
                    'pImage': post['pImage'],
                    'profileUrl': post['profileUrl'],
                    'uEmail': post['uEmail'],
                    'isReposted': true,
                  };
                  FirebaseDatabase.instance
                      .ref()
                      .child('Posts')
                      .child('Post List')
                      .push()
                      .set(newPost)
                      .then((_) {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  });
                },
                child: const Text("Repost"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
