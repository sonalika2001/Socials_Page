import 'dart:ui';
import 'blur.dart';
import 'package:flutter/material.dart';

class InstagramContainer extends StatefulWidget {
  final Color colour;
  final IconData icon;
  final bool enabled;
  Widget child;
  Widget igtvChild;

  InstagramContainer({
    @required this.colour,
    this.icon,
    this.enabled = false,
    @required this.child,
    @required this.igtvChild,
  });

  @override
  _InstagramContainerState createState() => _InstagramContainerState();
}

class _InstagramContainerState extends State<InstagramContainer>
    with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                child: (!widget.enabled)
                    ?
                    //   Blur(
                    // opacity: 0.95,
                    // blur: 0.6,
                    // shade: Colors.grey[500],
                    // child:
                    widget.child
                    // )
                    : Scaffold(
                        backgroundColor: Color(0xFF1B1C21),
                        body: Column(
                          children: [
                            Container(
                                height: 60,
                                //  margin: EdgeInsets.only(left: 60),
                                child: TabBar(
                                  tabs: [
                                    Container(
                                      width: 70.0,
                                      child: new Text(
                                        'POSTS',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      width: 70.0,
                                      child: new Text(
                                        'IGTV',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                  unselectedLabelColor: const Color(0xffacb3bf),
                                  indicatorColor: Colors.pinkAccent,
                                  labelColor: Colors.white,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorWeight: 3.0,
                                  indicatorPadding: EdgeInsets.all(10),
                                  isScrollable: false,
                                  controller: _tabController,
                                )),
                            Expanded(
                              child: Container(
                                child: TabBarView(
                                    controller: _tabController,
                                    children: <Widget>[
                                      widget.child,
                                      widget.igtvChild,
                                    ]),
                              ),
                            )
                          ],
                        ),
                      )),
          ),
          (!widget.enabled)
              ? Align(
                  alignment: Alignment.center,
                  child: Icon(
                    widget.icon,
                    size: 70,
                    color: widget.colour,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF1B1C21),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
