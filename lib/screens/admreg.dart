import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/model/admin_usermodel.dart';
import 'package:demoapp/screens/adminlogin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminRegistrationScreen extends StatefulWidget {
  const AdminRegistrationScreen({super.key});

  @override
  State<AdminRegistrationScreen> createState() =>
      AdminRegistrationScreenState();
}

class AdminRegistrationScreenState extends State<AdminRegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  //our form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final firstNameEditingController = TextEditingController();
  final secondEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final phonenoController = TextEditingController();
  final passoutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name Field
    final firstNameField = TextFormField(
        controller: firstNameEditingController,
        autofocus: false,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("First Name cannot be empty");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name Field
    final secondNameField = TextFormField(
        controller: secondEditingController,
        autofocus: false,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Last Name cannot be empty");
          }
          return null;
        },
        onSaved: (value) {
          secondEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email Field
    final emailField = TextFormField(
        controller: emailEditingController,
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }

          //reg expession for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //phoneno Field
    final phonenoField = TextFormField(
        controller: phonenoController,
        autofocus: false,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return ("First Name cannot be empty");
          }
          return null;
        },
        onSaved: (value) {
          phonenoController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone No",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    //Confirm password Field
    final passoutField = TextFormField(
        controller: passoutController,
        autofocus: false,
        keyboardType: TextInputType.datetime,
        validator: (value) {
          if (value!.isEmpty) {
            return ("First Name cannot be empty");
          }
          return null;
        },
        onSaved: (value) {
          passoutController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Passout",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    //SignUp Buttton
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text);
        },
        child: const Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/loginimg.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      firstNameField,
                      const SizedBox(
                        height: 20,
                      ),
                      secondNameField,
                      const SizedBox(
                        height: 20,
                      ),
                      emailField,
                      const SizedBox(
                        height: 20,
                      ),
                      phonenoField,
                      const SizedBox(
                        height: 20,
                      ),
                      passoutField,
                      const SizedBox(
                        height: 20,
                      ),
                      signUpButton,
                      const SizedBox(height: 15),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: "")
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e!.message)),
          );
        }
        return <dynamic>{};
      });
    }
  }

  postDetailsToFirestore() async {
    //calling our firest5ore
    //calling our user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    AdminUserModel userModel = AdminUserModel();

    //Writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondEditingController.text;
    userModel.phoneno = phonenoController.text;
    userModel.passout = passoutController.text;

    await firebaseFirestore
        .collection("test")
        .doc(user.uid)
        .set(userModel.toMap());

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account created successfully :)")),
    );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
        (route) => false);
  }
}
