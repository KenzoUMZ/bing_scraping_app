import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../../../core/components/buttons/ui_button.dart';
import '../../../core/components/text_form_field/ui_text_form_field.dart';
import '../../../core/core.dart';
import '../../domain_layer/domain_layer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final SearchInternetController _controller;
  late final TextEditingController _searchTextController;
  bool isButtonDisabled = true;

  @override
  void initState() {
    super.initState();

    _controller = GetIt.I.get<SearchInternetController>();
    _searchTextController =
        TextEditingController()..addListener(() {
          setState(() {
            isButtonDisabled = _searchTextController.text.isEmpty;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchInternetController, SearchInternetState>(
        bloc: _controller,
        builder: (_, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageController(
                'assets/images/google_logo_large.svg',
                width: 240,
              ),
              const Gap(32),
              UiTextFormField(
                prefixIcon: ImageController(
                  'assets/images/google_logo_small.png',
                ).addMargin(const EdgeInsets.all(6)),
                controller: _searchTextController,
                placeholder: 'Search',
                withShadow: true,
              ),
              const Gap(24),
              UiButton(
                label: 'Search',
                suffixIcon: Icon(
                  Icons.search,
                  color:
                      isButtonDisabled
                          ? UiColors.iconLight
                          : UiColors.textMuted,
                ).addMargin(const EdgeInsets.only(left: 8)),
                width: 0.5 * MediaQuery.sizeOf(context).width,
                labelColor:
                    isButtonDisabled ? UiColors.textMuted : UiColors.textStrong,
                backgroundColor: UiColors.bgWhite,
                borderColor: UiColors.strokeMuted,
                isDisabled: isButtonDisabled,
                onPressed: () async {
                  final query = _searchTextController.text.trim();
                  await _controller.search(searchTerm: query);
                  NavigatorSingleton.I.pushNamedAndRemoveUntil(
                    '/results',
                    arguments: state.searchResponse,
                  );
                },
              ),
            ],
          ).addPadding(const EdgeInsets.symmetric(horizontal: 16));
        },
      ),
    );
  }
}
