import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../l10n/l10n.dart';
import '../core/color_values.dart';
import '../core/ui_constant.dart';

class CustomDropdownField extends StatefulWidget {
  const CustomDropdownField(
      {Key? key,
      this.isRequired = true,
      this.readOnly = false,
      this.showOptional = false,
      this.isDense = true,
      this.label,
      this.hint,
      this.icon,
      this.onChanged, required this.items, this.value})
      : super(key: key);
  final void Function(Object?)? onChanged;
  final bool isRequired, isDense, readOnly, showOptional;
  final String? label, value;
  final String? hint;
  final IconData? icon;
  final List<DropdownMenuItem<Object>> items;

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  final ValueNotifier<bool> _isEmpty = ValueNotifier<bool>(true);

  OutlineInputBorder _getBorder({Color color = ColorValues.grey10}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          RichText(
              text: TextSpan(
                  text: widget.label,
                  style: Theme.of(context).textTheme.displaySmall,
                  children: [
                if (widget.isRequired)
                  const TextSpan(
                      text: '*', style: TextStyle(color: ColorValues.danger50)),
                if (widget.showOptional)
                  TextSpan(
                      text: ' (${AppLocalizations.of(context).optional})', style: GoogleFonts.nunito(fontWeight: FontWeight.w600)),
              ])),
        if (widget.label != null) const SizedBox(height: 8),
        if (widget.readOnly) AbsorbPointer(child: _buildTextField()),
        if (!widget.readOnly) _buildTextField(),
      ],
    );
  }

  Widget _buildTextField() {
    return ValueListenableBuilder(
        valueListenable: _isEmpty,
        builder: (context, _, __) {
        return DropdownButtonFormField(
          icon: const Icon(UniconsLine.angle_down, size: 16, color: ColorValues.grey50),
          items: widget.items,
          onChanged: (v) {
            v.toString().isEmpty ? _isEmpty.value = true : _isEmpty.value = false;
            if (widget.onChanged != null) {
              widget.onChanged!(v);
            }
          },
          validator: (_) {
            return widget.value == null ? 'Tidak boleh kosong' : null;
          },
          isExpanded: true,
          padding: EdgeInsets.zero,
          style: Theme.of(context).textTheme.displaySmall,
          value: widget.value,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: UiConstant.contentPadding, vertical: 14),
            hintText: widget.hint,
            hintStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: ColorValues.grey50),
            filled: true,
            fillColor: Colors.white,
            border: _getBorder(),
            isDense: widget.isDense,
            focusedBorder: _getBorder(color: ColorValues.grey50),
            enabledBorder: _getBorder(),
            disabledBorder: _getBorder(),
            errorBorder: _getBorder(color: ColorValues.danger50),
            focusedErrorBorder: _getBorder(color: ColorValues.danger50),
            prefixIcon: widget.icon == null
                ? null
                : Icon(
                    widget.icon,
                    size: 16,
                    color: ColorValues.grey50,
                  ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 60,
            ),
          ),
        );
      }
    );
  }
}
