import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtask/controller/user_controller.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
import 'package:totalxtask/widgets/sort_tile.dart';

class SortBottomSheet
    extends StatelessWidget {
  const SortBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (
        context,
        userProvider,
        child,
      ) {
        return Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),

          decoration:
              const BoxDecoration(
            color: AppColors.white,

            borderRadius:
                BorderRadius.only(
              topLeft:
                  Radius.circular(28),
              topRight:
                  Radius.circular(28),
            ),
          ),

          child: Column(
            mainAxisSize:
                MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,

                  decoration:
                      BoxDecoration(
                    color: Colors.grey,
                    borderRadius:
                        BorderRadius.circular(
                      100,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              const Text(
                'Sort Users',

                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.w700,
                  color:
                      AppColors.textDark,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              SortTile(
                title:
                    'Age Ascending',

                onTap: () {
                  userProvider
                      .sortUsers(
                    SortType
                        .ageAscending,
                  );

                  Navigator.pop(
                    context,
                  );
                },
              ),

              const SizedBox(
                height: 12,
              ),

              SortTile(
                title:
                    'Age Descending',

                onTap: () {
                  userProvider
                      .sortUsers(
                    SortType
                        .ageDescending,
                  );

                  Navigator.pop(
                    context,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

