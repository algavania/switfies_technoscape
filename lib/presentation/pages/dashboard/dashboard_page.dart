import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/routes/router.gr.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorValues.surface,
    ));

    return Scaffold(
      body: AutoTabsScaffold(
        routes: const [
          HomeRoute(),
          ActivityRoute(),
          ArticleRoute(),
          ProfileRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return CustomShadow(
            isShadowAbove: true,
            child: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Iconsax.home5),
                  label: AppLocalizations.of(context).home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Iconsax.activity5),
                  label: AppLocalizations.of(context).activity,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Iconsax.document_text5),
                  label: AppLocalizations.of(context).article,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Iconsax.frame5),
                  label: AppLocalizations.of(context).profile,
                ),
              ],
            ),
          );
        },
      )
    );
  }
}