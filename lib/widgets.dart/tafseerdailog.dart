import 'package:flutter/material.dart';

showTafseer(BuildContext context, tafsserayah,
    {String title = "التفسير الميسر"}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        //backgroundColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        insetPadding: EdgeInsets.all(1),
        child: Container(
          padding: EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width - 10,
          height: MediaQuery.of(context).size.height - 10,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 30,
                      color: Colors.green,
                    ),
                    onPressed: () {},
                  ),
                  Text(title,
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 36,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9, horizontal: 16),
                child: SelectableText(
                  tafsserayah,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
