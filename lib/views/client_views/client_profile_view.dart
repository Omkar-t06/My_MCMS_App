import 'package:flutter/material.dart';
import 'package:my_mcms/service/auth/auth_service.dart';
import 'package:my_mcms/service/cloud/Models/user_model.dart';
import 'package:my_mcms/service/cloud/firebase_cloud_storage.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';
import 'package:my_mcms/utils/widgets/custom_drawer.dart';
import 'package:my_mcms/utils/widgets/vertical_space.dart';

class ClientProfileView extends StatefulWidget {
  const ClientProfileView({super.key});

  @override
  State<ClientProfileView> createState() => _ClientProfileViewState();
}

class _ClientProfileViewState extends State<ClientProfileView> {
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
    return FutureBuilder(
      future: _fetchUserDetails(),
      builder: (context, snapshot) {
        return Scaffold(
            appBar: customAppBar(
              titleText: 'Profile',
            ),
            drawer: const CustomDrawer(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                if (snapshot.connectionState == ConnectionState.waiting)
                  const CircularProgressIndicator()
                else if (snapshot.hasError)
                  Text('Error: ${snapshot.error}')
                else if (snapshot.hasData)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: snapshot.data!.avatarUrl == null ||
                                snapshot.data!.avatarUrl == ''
                            ? const AssetImage(
                                'assets/images/profile_avatar_placeholder.png',
                              )
                            : NetworkImage(snapshot.data!.avatarUrl ?? ''),
                      ),
                      verticalSpace(5),
                      ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: Text(snapshot.data!.displayName),
                      ),
                      if (snapshot.data!.email != '')
                        ListTile(
                          leading: const Icon(Icons.mail_outline),
                          title: Text(snapshot.data!.email ?? ""),
                        ),
                      if (snapshot.data!.phoneNumber != '')
                        ListTile(
                          leading: const Icon(Icons.call),
                          title: Text(snapshot.data!.phoneNumber ?? ''),
                        ),
                      if (snapshot.data!.address != '')
                        ListTile(
                          leading: const Icon(Icons.location_on_outlined),
                          title: Text(snapshot.data!.phoneNumber ?? ''),
                        ),
                      if (snapshot.data!.address == '')
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.red,
                            leading: Icon(Icons.warning),
                            title: Text('Please update your profile'),
                          ),
                        )
                    ],
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.edit),
            ));
      },
    );
  }
}
