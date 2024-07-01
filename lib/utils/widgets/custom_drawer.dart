import 'package:flutter/material.dart';
import 'package:my_mcms/service/auth/auth_service.dart';
import 'package:my_mcms/service/cloud/Models/user_model.dart';
import 'package:my_mcms/service/cloud/firebase_cloud_storage.dart';
import 'package:my_mcms/utils/message_widget/show_log_out_dialog.dart';
import 'package:my_mcms/utils/widgets/vertical_space.dart';
import 'package:my_mcms/views/auth_view/login_view.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late final FirebaseCloudStorage _userService;
  final _user = AuthService.firebase().currentUser;

  @override
  void initState() {
    _userService = FirebaseCloudStorage();
    super.initState();
  }

  Future<UserModel> _fetchUserDetails() async {
    if (_user != null) {
      return await _userService.getUser(uid: _user.uid);
    } else {
      throw Exception("User not logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<UserModel>(
        future: _fetchUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            UserModel userDetails = snapshot.data!;
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    children: [
                      const Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            'assets/images/profile_avatar_placeholder.png',
                          ),
                        ),
                      ),
                      verticalSpace(5),
                      Align(
                        alignment: AlignmentDirectional.bottomStart,
                        child: Text(
                          'Hello ${userDetails.displayName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.favorite_border_outlined),
                  title: Text('Favorites'),
                ),
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text('Logout'),
                  onTap: () async {
                    final shouldLogOut = await showLogOutDialog(context);
                    if (shouldLogOut ?? false) {
                      await AuthService.firebase().logOut();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginView.route, (route) => false);
                    }
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No user details available'),
            );
          }
        },
      ),
    );
  }
}
