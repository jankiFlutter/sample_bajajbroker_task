import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'usr_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
 List<Map<dynamic,dynamic>> globalUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchUsers();
    });


  }

 Future<void> fetchUsers() async {
   const url = 'https://mocki.io/v1/66181e8d-f42c-4cc4-8f77-aa72c573b3a9';

   try {
     final response = await http.get(Uri.parse(url));
     debugPrint('Raw response: ${response.body}'); // ✅ print raw JSON

     if (response.statusCode == 200) {
       final data = json.decode(response.body);
       debugPrint('Decoded data: $data'); // ✅ print decoded map
       debugPrint('Users list: ${data['users']}'); // ✅ print just the user list

       globalUsers = data['users']  ; // 🔸 store globally
       debugPrint('Janki data: $globalUsers');

       setState(() {
         isLoading = false; // rebuild UI with data
       });
     } else {
       debugPrint('Failed status code: ${response.statusCode}');
       throw Exception('Failed to load data');
     }
   } catch (e) {
     debugPrint('Error: $e');
     setState(() {
       isLoading = false;
     });
   }
 }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: globalUsers.length,
        itemBuilder: (context, index) {
          final user = globalUsers[index];
          final firstLetter =
          user['name'][0].toString().split(" ").first[0];
          return ListTile(
            leading: CircleAvatar(child: Text(firstLetter)),
            title: Text(user['name']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserDetailScreen(user: user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
