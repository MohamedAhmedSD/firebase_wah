import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  //* we should recive data ===================
  final notes; //* == snapshot.data!.docs[i],

  ViewNote({Key? key, this.notes}) : super(key: key);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Notes'),
      ),
      body: Container(
        child: Column(
          children: [
            //? ======= imageUrl , title , note
            Container(
              child: Image.network(
                "${widget.notes['imageurl']}",
                width: double.infinity,
                height: 300,
                fit: BoxFit.fill,
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "${widget.notes['title']}",
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "${widget.notes['note']}",
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
          ],
        ),
      ),
    );
  }
}
