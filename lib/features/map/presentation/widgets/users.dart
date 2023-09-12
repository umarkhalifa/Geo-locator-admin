import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:land_survey/core/constants/sizes.dart';
import 'package:land_survey/features/map/presentation/providers/users_provider.dart';
import 'package:solar_icons/solar_icons.dart';

class UsersIcon extends StatelessWidget {
  const UsersIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
            context: context,
            builder: (context) => const UsersBottomSheet(),
            useSafeArea: true,
            isScrollControlled: true);
      },
      child: Row(
        children: [
          const SizedBox(
            height: 45,
            width: 45,
            child: Icon(
              SolarIconsOutline.user,
              color: Colors.blue,
              size: 30,
            ),
          ),
          gapW20,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Number of Users",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16, height: 1),
              ),
              Consumer(builder: (context, ref, child) {
                final users = ref.watch(fetchUsersNotifier);
                return Text("${users.length} users");
              })
            ],
          ),
          const Spacer(),
          const Icon(SolarIconsOutline.arrowRight)
        ],
      ),
    );
  }
}

class UsersBottomSheet extends ConsumerWidget {
  const UsersBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(fetchUsersNotifier);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height),
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
          ),
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            top: 25,
            bottom: 25,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Spacer(),
                  const Text(
                    "Users",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(SolarIconsOutline.closeSquare),
                  ),
                ],
              ),
              ListView.separated(
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      const SizedBox(
                        height: 45,
                        width: 45,
                        child: Icon(
                          SolarIconsOutline.user,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                      gapW20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            users[index].email ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                height: 1),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, __) {
                  return gapH16;
                },
                itemCount: users.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
