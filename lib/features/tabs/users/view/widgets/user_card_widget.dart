import 'package:flutter/material.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://iheitgacckotzfdtqybc.supabase.co/storage/v1/object/public/profileImages/profile_images/XyRqerSGlGhTvUUIX2jr7hjfNKO2/1743869511760.jpg',
          ),
        ),
        title: Text('Mohamed Osama'),
        subtitle: Text('23 years old'),
        trailing: FilledButton(
          onPressed: () {},
          child: Text(
            'more details',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ),
    );
  }
}
