import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ImagePicker extends StatefulWidget {
  ImagePicker({Key key, @required this.images, @required this.reset, @required this.selected}) : super(key: key);
  final List<String> images;
  final Function(String) selected;
  final VoidCallback reset;

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  ValueNotifier<String> current = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(0),
        content: Builder(
          builder: (context) {
            var width = MediaQuery.of(context).size.width - 25;
            var height = MediaQuery.of(context).size.height - 30;
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: NeumorphicText(
                      'Select Icon',
                      style: NeumorphicStyle(
                        color: Color(0xFF7D9DFD)
                      ),
                      textStyle: NeumorphicTextStyle(
                        fontFamily: GoogleFonts.dosis().fontFamily,
                        fontSize: 28
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(widget.images.length, (index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ValueListenableBuilder<String>(
                                valueListenable: current,
                                builder: (context, currentString, child) {
                                  return InkWell(
                                    onTap: () {
                                      current.value = widget.images[index];
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: currentString == widget.images[index] ? Color(0xFF7D9DFD) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          widget.images[index]
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              widget.reset();
                            }, 
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 18
                              ),
                            )
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              widget.selected(current.value);
                            }, 
                            child: Text(
                              'Select',
                              style: TextStyle(
                                fontSize: 18
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        )
      )
    );
  }
}