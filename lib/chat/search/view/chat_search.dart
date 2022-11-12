import 'package:Petamin/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatSearchPage extends StatelessWidget {
  const ChatSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.colors.green,
          ),
        ),
        elevation: 0,
        title: TextFormField(
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          autofocus: true,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/1.jpg'),
                ),
                title: Text('John Doe'),
                subtitle: Text('Hello'),
                trailing: Text('12:00'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/2.jpg'),
                ),
                title: Text('Jane Doe'),
                subtitle: Text('Hello'),
                trailing: Text('12:00'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/3.jpg'),
                ),
                title: Text('John Doe'),
                subtitle: Text('Hello'),
                trailing: Text('12:00'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/4.jpg'),
                ),
                title: Text('Jane Doe'),
                subtitle: Text('Hello'),
                trailing: Text('12:00'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/5.jpg'),
                ),
                title: Text('John Doe'),
                subtitle: Text('Hello'),
                trailing: Text('12:00'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/6.jpg'),
                ),
                title: Text('Jane Doe'),
                subtitle: Text('Hello'),
                trailing: Text('12:00'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/7.jpg'),
                ),
                title: Text('John Doe'),
                subtitle: Text('Hello'),
                trailing: Text('12:00'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/8.jpg'),
                ),
                title: Text('Jane Doe'),
                subtitle: Text('Hello'),
                trailing: Text('12:00'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/9.jpg'),
                ),
                title: Text('John Doe'),
                subtitle: Text('Hello'),
                trailing: Text('12:00'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/10.jpg'),
                ),
                title: Text('Jane Doe'),
                subtitle: Text('Hello'),
                trailing: Text('12:00'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
