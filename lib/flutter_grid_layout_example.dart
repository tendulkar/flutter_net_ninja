import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

class WhiteTextSizedBox extends StatelessWidget {
  final String text;
  WhiteTextSizedBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Card(
        color: Colors.blueAccent,
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;

  SidebarItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        SizedBox(width: 20),
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(width: 10),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 18)),
      ]),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  SummaryCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(children: [
        CircleAvatar(
          backgroundColor: Colors.blueGrey[900],
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(value,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[700])),
          ],
        ),
      ]),
    );
  }
}

class DatatableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: DataTable(columns: const [
        DataColumn(label: Text("Order ID")),
        DataColumn(label: Text("Customer")),
        DataColumn(label: Text("Amount")),
        DataColumn(label: Text("Status")),
      ], rows: const [
        DataRow(cells: [
          DataCell(Text("#001")),
          DataCell(Text("Alice Johnson")),
          DataCell(Text("\$120.00")),
          DataCell(Text("Completed", style: TextStyle(color: Colors.green))),
        ]),
        DataRow(cells: [
          DataCell(Text("#002")),
          DataCell(Text("Bob Smith")),
          DataCell(Text("\$250.00")),
          DataCell(Text("Pending", style: TextStyle(color: Colors.orange))),
        ]),
        DataRow(cells: [
          DataCell(Text("#003")),
          DataCell(Text("Charlie Davis")),
          DataCell(Text("\$180.00")),
          DataCell(Text("Canceled", style: TextStyle(color: Colors.red))),
        ])
      ]),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: [
      Expanded(
        flex: 1,
        child: Container(
          color: Colors.blueGrey[900],
          child: Column(children: [
            SizedBox(height: 50),
            Text("Admin Panel",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            SidebarItem(icon: Icons.dashboard, label: "Dashboard"),
            SidebarItem(icon: Icons.person, label: "Users"),
            SidebarItem(icon: Icons.shopping_cart, label: "Orders"),
            SidebarItem(icon: Icons.settings, label: "Settings"),
          ]),
        ),
      ),
      Expanded(
        flex: 4,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Dashboard",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(Icons.person, color: Colors.white)),
            ]),
            SizedBox(height: 20),
            Flexible(
//                   flex: 2,
              child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 6 / 2,
                  children: [
                    SummaryCard(
                        title: "Total Sales",
                        value: "\$45,000",
                        icon: Icons.monetization_on),
                    SummaryCard(
                        title: "Users", value: "1,250", icon: Icons.people),
                    SummaryCard(
                        title: "Orders",
                        value: "350",
                        icon: Icons.shopping_cart),
                    SummaryCard(
                        title: "Revenue",
                        value: "\$120,000",
                        icon: Icons.attach_money),
                  ]),
            ),
            SizedBox(height: 20),
            Flexible(
//                     flex: 3,
              child: DatatableWidget(),
            ),
          ]),
        ),
      ),
    ]));
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text("Login",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  TextField(decoration: InputDecoration(labelText: "Email")),
                  SizedBox(height: 10),
                  TextField(
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true),
                  SizedBox(height: 20),
                  FractionallySizedBox(
                      widthFactor: 1.0,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Sign In'),
                      )),
                ]))));
  }
}

class GridViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Text("Above Grid"),
      SizedBox(
          height: 300,
          child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 7 / 2,
              children: List.generate(6, (index) {
                return Container(color: Colors.green);
              }))),
      Text("Below Grid"),
    ]));
  }
}

class LayoutContainerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      print(
          "Max width: ${constraints.maxWidth}, Max Height: ${constraints.maxHeight}");
      return Container(
          width: constraints.maxWidth,
          height: 300,
          color: Colors.green,
          child: Center(
              child: Text(
                  "Available Widths: ${constraints.minWidth.toStringAsFixed(0)} -  ${constraints.maxWidth.toStringAsFixed(0)}, Avaiable Height: ${constraints.minHeight.toStringAsFixed(0)} - ${constraints.maxHeight.toStringAsFixed(0)}")));
    });
  }
}

class LayoutContainerExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: LayoutContainerExample(),
      ),
    );
  }
}

class GridLayoutExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Center(
          child: GridViewExample(),
        ),
      ),
    );
  }
}
