import 'package:flutter/material.dart';
/**
 * THIS THE CODE I FOUND FROM STACKOVER FLOW SOLUTION,
 * I DONT DELETED IT FOR FUTURE REFERNCE SO I NAMED IT 
 * TEST PAGE
 */

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) => FoundCourses();
}

class FoundCourses extends StatelessWidget {
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (_, index) => FoundCourseTile(index),
    );
  }
}

class FoundCourseTile extends StatefulWidget {
  final int number;

  const FoundCourseTile(this.number);

  @override
  _FoundCourseTileState createState() => _FoundCourseTileState();
}

class _FoundCourseTileState extends State<FoundCourseTile> {
  bool applied = false;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            // toggle state on tap
            onTap: () {
              setState(() => applied = !applied);
            },
            child: Container(
              height: 350,
              width: 170,
              decoration: BoxDecoration(
                // border: Border.all(color: Color(0xff940D5A)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(17.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 15.0),
                    blurRadius: 20.0,
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 10.0, left: 30.0, bottom: 3.0),
                    child: Text(
                      "${widget.number}",
                      style: TextStyle(
                          color: Color(0xff00315C),
                          fontSize: 14.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Instructor \nMahfuz A.",
                      style: TextStyle(
                        color: Color(0xff00315C),
                        fontSize: 12.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      // toggle state on tap
                      onPressed: () {
                        setState(() => applied = !applied);
                      },
                      // set color based on state
                      color: applied ? Colors.green : Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 65.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(17),
                              bottomLeft: Radius.circular(17))),
                      child: applied
                          ? Icon(Icons.abc)
                          : Text(
                              "Apply",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
