import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../models/search_user_model.dart';
import '../profile/user_profile_screen.dart';

class ExploreScreen extends StatefulWidget {

  @override
  State<ExploreScreen> createState() =>
      _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final AuthService _authService = AuthService();

final TextEditingController _searchController =
    TextEditingController();

List<SearchUserModel> users = [];

bool loading = false;
Future<void> search(String value) async {

  if (value.trim().isEmpty) {
    setState(() {
      users = [];
    });
    return;
  }

  setState(() {
    loading = true;
  });

  users = await _authService.searchUsers(value);

  setState(() {
    loading = false;
  });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              TextField(
  controller: _searchController,
  onChanged: search,
  decoration: const InputDecoration(
    hintText: "Search people...",
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(),
  ),
),
const SizedBox(height: 20),

if (loading)
  const Center(
    child: CircularProgressIndicator(),
  ),

Expanded(
  child: ListView.builder(
    itemCount: users.length,
    itemBuilder: (context, index) {
      final user = users[index];

      return Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              user.name[0].toUpperCase(),
            ),
          ),
          title: Text(user.name),
          subtitle: Text(user.email),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => UserProfileScreen(
        userId: user.id,
      ),
    ),
  );
},
        ),
      );
    },
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}