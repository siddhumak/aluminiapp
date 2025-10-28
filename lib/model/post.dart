// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/model/user_model.dart';
import 'package:flutter/material.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Post extends StatefulWidget {
  final String uid;
  final String email;
  final String firstName;
  final String secondName;
  final String profile;
  final dynamic likes;

  const Post({
    super.key,
    required this.uid,
    required this.email,
    required this.firstName,
    required this.secondName,
    required this.profile,
    required this.likes,
  });

//receive data from server
  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      uid: doc['uid'],
      email: doc['email'],
      firstName: doc['firstName'],
      secondName: doc['secondName'],
      profile: doc['profile'],
      likes: doc['likes'],
    );
  }

  int getLikeCount(likes) {
    if (likes == null) {
      return 0;
    }
    int count = 0;
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  void initState() {
    getUsers();
    super.initState();
  }

  getUsers() {
    usersRef.get().then((QuerySnapshot snapshot) {
      // Process user data from snapshot.docs
      // Removed unused variable 'doc' to fix linter warning
    });
  }

  int get likeCount => widget.getLikeCount(widget.likes);

  buildPostHeader() {
    return FutureBuilder(
        future: usersRef.doc(widget.uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          UserModel user = UserModel.fromMap(snapshot.data);
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.profile.toString()),
              backgroundColor: Colors.grey,
            ),
            title: GestureDetector(
              onTap: () {
                // Show profile
              },
              child: Text(
                "${user.firstName} ${user.secondName}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Text(widget.email),
            trailing: IconButton(
              onPressed: () {
                // Delete post
              },
              icon: const Icon(Icons.more_vert),
            ),
          );
        });
  }

  buildPostImage() {
    return GestureDetector(
        onDoubleTap: () {
          // Like post
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.network(widget.profile),
          ],
        ));
  }

  buildPostFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
            GestureDetector(
              onTap: () {
                // Like post
              },
              child: const Icon(
                Icons.favorite_border,
                size: 28.0,
                color: Colors.red,
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 20.0)),
            GestureDetector(
              onTap: () {
                // Show comments
              },
              child: Icon(
                Icons.chat,
                size: 28.0,
                color: Colors.blue[900],
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(
                "$likeCount likes",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildPostHeader(),
        buildPostImage(),
        buildPostFooter()
      ],
    );
  }
}
