import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pos/generated/colors.gen.dart';

class SearchTextField extends StatefulWidget {
  final String? hintText;
  final void Function(BuildContext context, String querySearch)? onSearch;

  const SearchTextField({super.key, this.hintText, this.onSearch});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final _searchTextController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchTextController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {});
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (widget.onSearch != null) {
      _debounce = Timer(const Duration(milliseconds: 500), () {
        widget.onSearch!(context, query.toLowerCase());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchTextController,
      onChanged: _onSearchChanged,
      keyboardType: TextInputType.text,
      maxLines: 1,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: AppColors.charcoal500),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: const Icon(
            Icons.search_outlined,
            color: AppColors.charcoal700,
          ),
        ),
        suffixIcon: _searchTextController.text.isNotEmpty
            ? InkWell(
                onTap: () {
                  final query = _searchTextController.text;
                  if (query.isNotEmpty) {
                    _searchTextController.clear();

                    widget.onSearch!(context, '');
                    setState(() {});
                  }
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Icon(Icons.clear, color: AppColors.charcoal800),
                ),
              )
            : null,
      ),
    );
  }
}
