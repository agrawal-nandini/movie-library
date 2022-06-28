import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_library/screens/add_note.dart';
import 'package:movie_library/utilities/colors.dart';
import 'package:movie_library/utilities/text.dart';
import 'package:movie_library/widgets/banner.dart';
import 'package:movie_library/widgets/notes.dart';
import 'package:truncate/truncate.dart';

class DescriptionPage extends StatefulWidget {
  String name = "Loading", desc, banner, rating, launchDate, poster;
  var id;
  DescriptionPage(
      {Key? key,
      required this.name,
      required this.desc,
      required this.banner,
      required this.rating,
      required this.poster,
      required this.launchDate,
      required this.id})
      : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNotePage(
                  id: widget.id.toString(),
                ),
              ),
            ).then((value) {
              setState(() {});
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: kCarousalCard,
        ),
        backgroundColor: const Color(0xFFF7FFF7),
        body: Container(
          alignment: Alignment.center,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                child: BannerImage(
                  bannerUrl: widget.banner,
                  rating: widget.rating,
                ),
              ),
              Container(
                // flex: 5,
                // height: 400,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 6.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.name,
                      style: GoogleFonts.outfit(
                        color: Colors.black,
                        fontSize: 36,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 6.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: HeadingText(
                      text: 'Coming On ${widget.launchDate}',
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 6.0),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 200,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.poster),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                truncator(widget.desc, 190, CutStrategy()),
                                style: GoogleFonts.outfit(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 6.0,
                    right: 6.0,
                    top: 2.0,
                    bottom: 4.0,
                  ),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'My Notes',
                      style: GoogleFonts.outfit(
                        color: Colors.black,
                        fontSize: 34,
                      ),
                    ),
                  ),
                ),
              ),
              NotesWidget(
                id: widget.id.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
