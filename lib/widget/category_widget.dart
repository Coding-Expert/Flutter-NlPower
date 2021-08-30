

import 'package:flutter/material.dart';
import 'package:nlpower/model/category.dart';
import 'package:nlpower/pages/category_detail.dart';
import 'package:nlpower/pages/new_post.dart';

class CategoryWidget extends StatefulWidget {

  final Category category;
  final String groupId;
  CategoryWidget({
    Key key,
    this.category,
    this.groupId
  }) : super(key: key);
  
  CategoryWidgetState createState ()=> CategoryWidgetState();
}

class CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostPage(
              //   groupId: widget.groupId,
              //   category: widget.category
              // )));
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetailPage(
                groupId: widget.groupId,
                category: widget.category
              )));
            },
            child:Container(
              width: 130,
              height: 40,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border(
                  bottom: BorderSide(color: Colors.blue,),
                  left: BorderSide(color: Colors.blue,),
                  top: BorderSide(color: Colors.blue,),
                  right: BorderSide(color: Colors.blue,),
                ),
              ),
              child: new Align(alignment: Alignment.center , child: Text(widget.category.title == null ? "xxx" : widget.category.title, style:TextStyle(color: Colors.black, fontSize: 16))),
            )
          ),
          SizedBox(width: 5.0,),
        ],
      )
      
    );
  }
  
}