import 'package:flutter/material.dart';

// void main() {
//   runApp(SliverListGridExampleApp());
// }

class SingleChildScrollViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: List.generate(
          50, (index) => ListTile(title: Text("Item ${index + 1}"))),
    ));
  }
}

class ScrollWithLazyLoadExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: 200,
        floating: true,
        pinned: false,
        flexibleSpace: FlexibleSpaceBar(
          title: Text("SliverAppBar"),
          background: Image.network(
              'https://picsum.photos/seed/seed_42/200/300',
              fit: BoxFit.cover),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(title: Text("Item ${index + 1}")),
          childCount: 50,
        ),
      ),
    ]);
  }
}

class SliverListGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
//       physics: ClampingScrollPhysics(),
//       physics: NeverScrollableScrollPhysics(),
//       physics: AlwaysScrollableScrollPhysics(),
        physics: PageScrollPhysics(),
        slivers: [
          SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text("Mixed Slivers"),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                          'https://picsum.photos/seed/seed_10/600/600',
                          fit: BoxFit.cover),
                      Container(
                          decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.white.withOpacity(0.5),
                            Colors.transparent
                          ],
                        ),
                      ))
                    ],
                  ),
                  collapseMode: CollapseMode.parallax,
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                    StretchMode.blurBackground,
                  ])),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(title: Text("Item ${index + 1}")),
            childCount: 100,
          )),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  color: Colors.green,
                  child: Center(
                      child: Text("Grid Item ${index + 1}",
                          style: TextStyle(color: Colors.white))),
                );
              },
              childCount: 24,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
          ),
        ]);
  }
}

class SliverListGridExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: SliverListGridExample()),
    );
  }
}
