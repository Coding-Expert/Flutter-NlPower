import 'package:flutter/material.dart';
import 'package:nlpower/model/category.dart';
import 'package:nlpower/module/post_module.dart';
import 'package:nlpower/pages/new_post.dart';
import 'package:nlpower/widget/category_widget.dart';
import 'package:nlpower/widget/following.dart';
import 'package:nlpower/widget/sliversubheader.dart';

class CommunityPage extends StatefulWidget {
  CommunityPageState createState() => CommunityPageState();
}

class CommunityPageState extends State<CommunityPage>
    with TickerProviderStateMixin {
  TabController _cardController;
  List<Category> category_list = [];
  String current_level = "Explore";
  String current_groupId;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: 3);
    getInfo();
  }

  Future<void> getInfo() async {
    loading = true;
    await PostModule.getGroupId(current_level).then((id) {
      setState(() {
        if (id != null) {
          current_groupId = id;
        }
        PostModule.getCategoryList(current_level).then((list) {
          setState(() {
            if (list.length > 0) {
              for (int i = 0; i < list.length; i++) {
                category_list.add(list[i]);
              }
            }
            loading = false;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Community"),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new RadialGradient(
                radius: MediaQuery.of(context).size.width / 50,
                colors: [
                  Color.fromRGBO(89, 0, 224, 1),
                  Color.fromRGBO(109, 42, 128, 1),
                ],
              ),
            ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/edit_profile.jpg"),
                    fit: BoxFit.cover)),
            child: loading == false
                ? CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        // width: MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            for (var category in category_list)
                                              CategoryWidget(
                                                  category: category,
                                                  groupId: current_groupId),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(10.0),
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            child: Image.asset(
                                              'assets/activate.png',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Expanded(
                                              child: Container(
                                                  child: Text(
                                                      'Post to global feed...',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16)))),
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              commonPost();
                                              // Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostPage(
                                              //   groupId: current_groupId,
                                              // )));
                                            },
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SliverSubHeader(
                        cardController: _cardController,
                      ),
                      SliverToBoxAdapter(
                          child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Expanded(
                              child: TabBarView(
                                  controller: _cardController,
                                  children: [
                                    Container(
                                      child: FollowingWidget(),
                                    ),
                                    Container(
                                      child: Text('Trending'),
                                    ),
                                    Container(
                                      child: Text('New'),
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      )),
                      SliverFillRemaining(
                        child: Container(),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )));
  }

  // void onTabTapped(int index) {
  //  setState(() {
  //    selected_tabIndex = index;
  //  });
  // }

  void commonPost() {
    int common_categoryIndex = 0;
    for (int i = 0; i < category_list.length; i++) {
      if (category_list[i].title == "Κοινότητα") {
        common_categoryIndex = i;
        break;
      }
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewPostPage(
                groupId: current_groupId,
                category: category_list[common_categoryIndex],
                onRefreshPage: (result) {
                  if (result == "success") {}
                })));
  }
}
