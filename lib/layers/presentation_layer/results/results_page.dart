import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/core.dart';
import '../../domain_layer/domain_layer.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late final SearchInternetController _controller;

  @override
  void initState() {
    super.initState();

    _controller = GetIt.I.get<SearchInternetController>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchInternetController, SearchInternetState>(
      bloc: _controller,
      builder: (_, state) {
        final response = state.searchResponse;
        final results = response?.results ?? [];
        return Scaffold(
          backgroundColor: UiColors.bgSoft,
          appBar: AppBar(
            title: Text(response?.searchTerm ?? 'Results'),
            centerTitle: true,
          ),
          body: SafeArea(
            child:
                results.isEmpty
                    ? Center(
                      child: Text(
                        response == null
                            ? 'No search data.'
                            : 'No results found for "${response.searchTerm ?? ''}"',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                    : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      itemCount: results.length,
                      separatorBuilder: (context, index) => Gap(8),
                      itemBuilder: (_, index) {
                        final item = results[index];
                        return ListTile(
                          tileColor: UiColors.bgWhite,
                          title: Text(
                            item.title ?? item.url ?? 'No title',
                            style: UiTextStyle.body16(
                              color: UiColors.secondaryBase,
                              // decoration: TextDecoration.underline,
                            ),
                          ),
                          subtitle: Text(item.url ?? '', maxLines: 2,),
                          onTap: () async {
                            await _openUrl(item.url);
                          },
                        );
                      },
                    ),
          ),
        );
      },
    );
  }
}

extension on _ResultsPageState {
  Future<void> _openUrl(String? url) async {
    if (url == null || url.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('URL inválida')));
      }
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('URL inválida')));
      }
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o link')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Erro ao abrir o link')));
      }
    }
  }
}
