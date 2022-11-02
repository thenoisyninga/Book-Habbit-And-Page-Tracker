import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AddBookMarkDialogue extends StatefulWidget {
  const AddBookMarkDialogue({super.key, required this.addNewBookMarkCallback, required this.bookmarkAlreadyExistsCheckCallback});

  final Function(String bookName, int totalPages) addNewBookMarkCallback;
  final Function(String bookName) bookmarkAlreadyExistsCheckCallback;

  @override
  State<AddBookMarkDialogue> createState() => _AddBookMarkDialogueState();
}

class _AddBookMarkDialogueState extends State<AddBookMarkDialogue> {
  TextEditingController _bookNameController = TextEditingController();
  TextEditingController _totalPagesController = TextEditingController();
  String? bookNameError;
  String? totalPagesError;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text(
        "Add New Bookmark",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white
        ),
      ),
      content: SizedBox(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            // BookName Input
            TextField(
              controller: _bookNameController,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Book Name',
                errorText: bookNameError,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  )
                ),
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  ),
                ),
              ),
              
            ),

            // Total Pages Input
            TextField(
              controller: _totalPagesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: totalPagesError,
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Total Pages',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  )
                ),
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  ),
                ),
              ),
            ),

            // Add Button
            ElevatedButton(
              child: Text("Add"),

              onPressed: () {
                // Verify Inputs
                var totalPagesCheck = num.tryParse(_totalPagesController.text);
                bookNameError = null;
                totalPagesError = null;
                
                if (!widget.bookmarkAlreadyExistsCheckCallback(_bookNameController.text) && totalPagesCheck != null){
                  widget.addNewBookMarkCallback(
                    _bookNameController.text,
                    int.parse(_totalPagesController.text),
                  );

                  Navigator.pop(context);

                } else {
                  if (widget.bookmarkAlreadyExistsCheckCallback(_bookNameController.text)) {
                    setState(() {
                      bookNameError = "This book already exists.";
                    });
                  }

                  if (totalPagesCheck == null) {
                    setState(() {
                      totalPagesError = "This isnt a number.";
                    });
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}