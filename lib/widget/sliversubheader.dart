import 'dart:math';

import 'package:flutter/material.dart';

class SliverSubHeader extends StatefulWidget {

  final TabController cardController;
  SliverSubHeader({
    this.cardController
  });

  SliverSubHeadeState createState() => SliverSubHeadeState();
}

class SliverSubHeadeState extends State<SliverSubHeader> with TickerProviderStateMixin{

  
  int selected_tabIndex = 0;

  @override
  void initState(){
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 50,
        maxHeight: 50,
        child: Container(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: TabBar(
              controller: widget.cardController,
              labelColor: Colors.blue,
              // isScrollable: true,
              // onTap: onTabTapped,
              tabs: [
                Tab(child: Text("Following", style:TextStyle(color: selected_tabIndex == 0 ? Colors.blue : Colors.black)),),
                Tab(child: Text("Trending",style:TextStyle(color: selected_tabIndex == 1 ? Colors.blue : Colors.black)),),
                Tab(child: Text("New",style:TextStyle(color: selected_tabIndex == 2 ? Colors.blue : Colors.black)),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}