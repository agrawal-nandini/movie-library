import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:movie_library/utilities/colors.dart';
import '../utilities/text.dart';

class AddNotePage extends StatefulWidget {
  final String id;
  AddNotePage({required this.id});

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  String title = "";
  String desc = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: kCarousalCard,
          title: const HeadingText(
            text: 'Movie Library',
            color: Colors.white,
            size: 30,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: add,
          backgroundColor: kCarousalCard,
          child: const Icon(
            Icons.save_alt,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            // color: kNotes,
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            InputDecoration.collapsed(hintText: 'Title'),
                        style: GoogleFonts.outfit(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (val) {
                          title = val;
                        },
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          // keyboardType: TextInputType.multiline,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Your Note',
                          ),
                          style: GoogleFonts.outfit(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                          onChanged: (val) {
                            desc = val;
                          },
                          maxLines: null,
                          minLines: null,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    var data = {
      'content': desc,
      'date': DateFormat.yMMMd().add_jm().format(DateTime.now()).toString(),
      'note_title': title,
      'id': widget.id,
    };

    FirebaseFirestore.instance
        .collection(widget.id)
        .add(data)
        .catchError((error) => print('Failed to add note!'));

    Navigator.pop(context);
  }
}
