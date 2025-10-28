import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/components/user_model2.dart';
import 'package:demoapp/screens/adminlogin_screen.dart';
import 'package:demoapp/screens/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlumniReg extends StatefulWidget {
  const AlumniReg({super.key});

  @override
  State<AlumniReg> createState() => _AlumniRegState();
}

class _AlumniRegState extends State<AlumniReg> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final firstNameEditingController = TextEditingController();
  final secondEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final contactEditingController = TextEditingController();
  final usertypeEditingController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final imageEditingController = TextEditingController();
  final Storage storage = Storage();

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      // Handle the selected image
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = '${picked.toLocal()}'.split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

    final secondNameField = TextFormField(
        controller: secondEditingController,
        autofocus: false,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("last Name cannot be empty");
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

//email
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

    final dateControllerrr = TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: ' Passout Year',
        prefixIcon: GestureDetector(
          onTap: () => _selectDate(context),
          child: const Icon(Icons.calendar_today),
        ),
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
    );
//user type

// ... rest of your code ...

    final imagePickerButton = ElevatedButton(
      onPressed: _pickImage,
      child: const Text('Select Image'),
    );

    final selectedImageField = TextFormField(
      controller: imageEditingController,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.image),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Selected Image",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    Column(
      children: [
        // Other form fields
        const SizedBox(height: 20),
        imagePickerButton,
        const SizedBox(height: 20),
        selectedImageField,
      ],
    );
    final submitButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          postDetailsToFirestore();
        },
        child: const Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

//button

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
                      dateControllerrr,
                      const SizedBox(height: 15),
                      imagePickerButton,
                      const SizedBox(
                        height: 20,
                      ),
                      submitButton,
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    if (user != null) {
      UserModel2 userModel = UserModel2();
      userModel.email = emailEditingController.text; // Correctly retrieve email
      userModel.uid = user.uid;
      userModel.firstName = firstNameEditingController.text;
      userModel.secondName = secondEditingController.text;
      userModel.date = _dateController.text;
      userModel.usertype = "alumni";

      // Upload image to Firebase Storage if needed

      // Save user details to Firestore
      await firebaseFirestore
          .collection("AlumniData")
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
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error")),
        );
      }
    }
  }
}
