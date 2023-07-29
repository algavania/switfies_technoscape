import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/routes/router.gr.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';

import '../../core/shared_data.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final PanelController _panelController = PanelController();
  final ValueNotifier<Widget> _panelContent = ValueNotifier(const SizedBox.shrink());

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      SharedData.setStatusBarColorWhite(context);
    });
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: _panelContent,
          builder: (context, _, __) {
          return SlidingUpPanel(
            controller: _panelController,
            minHeight: 0,
            maxHeight: 90.h,
            backdropTapClosesPanel: false,
            color: ColorValues.slidingPanelBackground,
            backdropEnabled: true,
            backdropColor: ColorValues.grey90,
            backdropOpacity: 0.32,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            boxShadow: [
              BoxShadow(color: ColorValues.grey50.withOpacity(0))
            ],
            panel: _panelContent.value,
            body: AutoTabsScaffold(
              routes: [
                HomeRoute(openPanel: _openPanel, closePanel: _closePanel),
                const ActivityRoute(),
                const NotificationsRoute(),
                const ArticleRoute(),
                const ProfileRoute(),
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
                        icon: const Icon(Iconsax.notification_bing5),
                        label: AppLocalizations.of(context).notifications,
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
            ),
          );
        }
      )
    );
  }

  void _openPanel(Widget content) {
    _panelContent.value = content;
    _panelController.open();
  }

  void _closePanel() {
    _panelController.close();
  }
}
