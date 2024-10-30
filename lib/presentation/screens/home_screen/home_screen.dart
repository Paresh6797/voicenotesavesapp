import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/constant_text.dart';
import '../../../core/constants/font_weight.dart';
import '../../../data/model/user.dart';
import '../../../logic/cubit/user_list/user_list_cubit.dart';
import '../../widgets/custom_text.dart';
import '../user_details_screen/user_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const CustomText(
          text: "User List",
          size: 20,
          fontWeight: medium,
          clr: black101010Color,
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: BlocBuilder<UserListCubit, UserListState>(
              builder: (context, offerState) {
                if (offerState is UserListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: theme00b894Color),
                  );
                } else if (offerState is UserListLoaded) {
                  if (offerState.users.isNotEmpty) {
                    return usersListBuild(offerState.users, context);
                  } else {
                    return usersListBuild(users.reversed.toList(), context);
                  }
                }
                return usersListBuild(users.reversed.toList(), context);
              },
            ),
          ),
        );
      }),
    );
  }

  Widget usersListBuild(List<User> users, BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(
            label: CustomText(
          text: "ID",
          size: 14,
          fontWeight: medium,
          clr: black101010Color,
        )),
        DataColumn(
            label: CustomText(
          text: "Name",
          size: 14,
          fontWeight: medium,
          clr: black101010Color,
        )),
        DataColumn(
            label: CustomText(
          text: "Email",
          size: 14,
          fontWeight: medium,
          clr: black101010Color,
        )),
        DataColumn(
            label: CustomText(
          text: "Phone Number",
          size: 14,
          fontWeight: medium,
          clr: black101010Color,
        )),
        DataColumn(
            label: CustomText(
          text: "Details",
          size: 14,
          fontWeight: medium,
          clr: black101010Color,
        )),
      ],
      rows: users.map((user) {
        return DataRow(cells: [
          DataCell(CustomText(
            text: "${user.id}",
            size: 14,
            fontWeight: normal,
            clr: black101010Color,
          )),
          DataCell(CustomText(
            text: user.name,
            size: 14,
            fontWeight: normal,
            clr: black101010Color,
          )),
          DataCell(CustomText(
            text: user.email,
            size: 14,
            fontWeight: normal,
            clr: black101010Color,
          )),
          DataCell(CustomText(
            text: user.phone,
            size: 14,
            fontWeight: normal,
            clr: black101010Color,
          )),
          DataCell(
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailScreen(user: user),
                  ),
                );
              },
              child: const CustomText(
                text: "Details",
                size: 14,
                fontWeight: normal,
                clr: black101010Color,
              ),
            ),
          ),
        ]);
      }).toList(),
    );
  }
}
