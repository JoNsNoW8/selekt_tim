import 'package:flutter/material.dart';
import 'package:selekt_tim/screens/admin/account_detail.dart';
import 'package:selekt_tim/services/worker_service.dart';

class WorkerAccountsScreen extends StatefulWidget {
  const WorkerAccountsScreen({super.key});

  @override
  State<WorkerAccountsScreen> createState() => _WorkerAccountsScreenState();
}

class _WorkerAccountsScreenState extends State<WorkerAccountsScreen> {
  void _refreshList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upravljanje Radnicima')),
      body: FutureBuilder<List<dynamic>>(
        future: UserService().getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return Center(child: Text('Greška: ${snapshot.error}'));
          
          final users = snapshot.data ?? [];
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: const CircleAvatar(backgroundColor: Color(0xFF922627), child: Icon(Icons.person, color: Colors.white)),
                title: Text('${user['ime']} ${user['prezime']}'),
                subtitle: Text(user['username']),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserDetailScreen(user: user)),
                  );
                  _refreshList();
                },
              );
            },
          );
        },
      ),
    );
  }
}