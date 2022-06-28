import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_library/utilities/colors.dart';

class NotesWidget extends StatefulWidget {
  final String id;
  const NotesWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection(widget.id)
          .get()
          .catchError((error) => print('Error in getting data')),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map data =
                  snapshot.data?.docs[index].data() as Map<dynamic, dynamic>;
              return Container(
                padding: EdgeInsets.all(4),
                child: Card(
                  color: kNotes,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data["note_title"],
                              style: GoogleFonts.outfit(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  var ref =
                                      snapshot.data?.docs[index].reference;
                                  ref?.delete();
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.clear,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          data["content"],
                          style: GoogleFonts.outfit(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          data["date"],
                          style: GoogleFonts.outfit(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container(
              // child: Center(
              //   child: Text(
              //     'No Notes',
              //     style: GoogleFonts.outfit(
              //       color: Colors.black,
              //       fontSize: 28,
              //     ),
              //   ),
              // ),
              );
        }
      },
    );
  }
}
