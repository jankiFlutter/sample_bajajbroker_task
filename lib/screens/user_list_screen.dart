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
     if (response.statusCode == 200) {
       final Map<String, dynamic> data = json.decode(response.body);
       print(data);
       final Map<String, dynamic> usersList = data['users'];

       globalUsers = usersList as List<Map>;

       setState(() {
         isLoading = false;
       });

       //  Show SnackBar if no data
       if (globalUsers.isEmpty) {
         ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('No data to display')),
         );
       }
     } else {
       throw Exception('Failed to load data');
     }
   } catch (e) {
     debugPrint('Error: $e');
     setState(() {
       isLoading = false;
     });

     // 🔸 Show error snackbar
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Error: ${e.toString()}')),
     );
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
