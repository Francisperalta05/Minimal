import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tots_test/src/bloc/users_bloc/users_bloc.dart';
import 'package:tots_test/src/extensions/navigation.dart';
import 'package:tots_test/src/extensions/sizer.dart';
import 'package:tots_test/src/screens/home/add_edit_user.dart';
import 'package:tots_test/src/utils/images_path.dart';

import '../../utils/colors.dart';
import '../widgets/green_background.dart';

class HomeList extends StatefulWidget {
  const HomeList({super.key});
  static const String routeName = "/home_list";

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  final refreshController = RefreshController();
  @override
  void initState() {
    context.read<UserBloc>().add(GetUserList());
    super.initState();
  }

  void _onRefresh() {
    context.read<UserBloc>().add(GetUserList());
    Future.delayed(const Duration(milliseconds: 500),
        () => refreshController.refreshCompleted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -300.h,
              left: -250.w,
              child: CircleBackground(
                size: 500.0.w,
              ),
            ),
            Positioned(
              top: 200.w,
              right: -50.w,
              child: CircleBackground(
                size: 300.0.w,
              ),
            ),
            Positioned(
              bottom: -550.w,
              right: -300.w,
              child: CircleBackground(
                size: 700.0.w,
              ),
            ),
            Positioned(
              bottom: -400.w,
              left: -550.w,
              child: CircleBackground(
                size: 700.0.w,
              ),
            ),
            Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: Image(
                    image: const AssetImage(AppImages.minimal),
                    width: 128.w,
                  ),
                ),
                Expanded(
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      final users = state.userListTotal;

                      return SmartRefresher(
                        onRefresh: _onRefresh,
                        enablePullDown: true,
                        header: const WaterDropHeader(),
                        controller: refreshController,
                        child: ListView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          children: [
                            SizedBox(height: 30.h),
                            Text(
                              "CLIENTS",
                              style: TextStyle(
                                color: color434545,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.w,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(
                              height: 36.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) => context
                                          .read<UserBloc>()
                                          .add(SearchUsers(value)),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(.62),
                                          fontSize: 13.w,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        hintText: "Search...",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15.w),
                                  ElevatedButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (_) => const AddEditUser(
                                                title: "Add new client",
                                                isEditting: false,
                                              ));
                                    },
                                    child: const Text("ADD NEW"),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            if (state.loadingUsers)
                              Shimmer.fromColors(
                                baseColor: colorE4F353,
                                highlightColor: Colors.white,
                                child: Column(
                                  children: List.generate(
                                    5,
                                    (index) => Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(bottom: 16.h),
                                      padding: EdgeInsets.all(45.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ...List.generate(
                              users.length,
                              (index) => Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 50.w,
                                      height: 50.w,
                                      child: const CircleAvatar(
                                        child: Icon(Icons.person_2_outlined),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Text.rich(
                                        TextSpan(
                                          text:
                                              "${users[index].firstname} ${users[index].lastname}\n",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.w,
                                            color: color0D0D0D,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: users[index].email,
                                                style: TextStyle(
                                                  color: color434545,
                                                  fontSize: 12.w,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Transform.rotate(
                                      angle: pi / 2,
                                      child: PopupMenuButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        color: color0D1111,
                                        onSelected: (value) {},
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              onTap: () => showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (_) => AddEditUser(
                                                        title: "Edit client",
                                                        isEditting: true,
                                                        user: users[index],
                                                      )),
                                              value: users[index],
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 12.w),
                                                  Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.w,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        AlertDialog.adaptive(
                                                          content: Text(
                                                            "Are you sure you want to remove ${users[index].firstname} ${users[index].lastname}?",
                                                            style: TextStyle(
                                                              fontSize: 20.w,
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed:
                                                                  context.pop,
                                                              child: const Text(
                                                                  "Cancel"),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                context.pop();
                                                                context
                                                                    .read<
                                                                        UserBloc>()
                                                                    .removeUser(
                                                                        users[index]
                                                                            .id!);
                                                              },
                                                              child: const Text(
                                                                  "Continue"),
                                                            ),
                                                          ],
                                                        ));
                                              },
                                              value: users[index],
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.clear,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 12.w),
                                                  Text(
                                                    "Remove",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.w,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ];
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (!state.loadingUsers)
                              ElevatedButton(
                                onPressed: () => context
                                    .read<UserBloc>()
                                    .add(AddMoreToList()),
                                child: const Text("LOAD MORE"),
                              ),
                            SizedBox(
                              height:
                                  MediaQuery.paddingOf(context).bottom + 50.h,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
