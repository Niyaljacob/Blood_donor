import 'package:donatelife/features/authentication/domain/app_user.dart';
import 'package:donatelife/utils/appstyles.dart';
import 'package:donatelife/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserItem extends ConsumerWidget {
  const UserItem(this.appUser, {super.key});
  final AppUser appUser;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          appUser.type == 'Donor'
              ? 'assets/donar-rem.png'
              : 'assets/recipient-rem.png',
          height: SizeConfig.getProportionteHeight(80),
          width: SizeConfig.getProportionteWidth(80),
        ),
        title: Column(
          children: [
            Text(
              appUser.type.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
              ),
              
            ),
            Text(
              'Name: ${appUser.name}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
              ),
              
            ),
            Text(
              'Email: ${appUser.email}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
              ),
              
            ),
            Text(
              'phone: ${appUser.phoneNumber}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
              ),
              
            ),
            Text(
              'Blood Group: ${appUser.bloodGroup}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                
                fontSize: 14
              ),
              
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: (){}, 
          style: ElevatedButton.styleFrom(
            backgroundColor: Appstyles.mainColor,
          ),
          child: const Text("EMAIL")),
      ),
    );
  }
}
