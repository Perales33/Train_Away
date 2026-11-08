import 'package:flutter/material.dart';
import 'package:train_away/theme/app_colors.dart';

// Widget reutilizable para los campos desplegables de los formularios
// (Origen, Destino, Clase, Personas, Horarios).
class FormDropdown<T> extends StatefulWidget {
  const FormDropdown({
    required this.value,
    required this.values,
    required this.onChanged,
    this.hint,
    super.key,
  });

  final T value;
  final List<T> values;
  final ValueChanged<T?> onChanged;
  final String? hint;

  @override
  State<FormDropdown<T>> createState() => _FormDropdownState<T>();
}

// Clase que gestiona el estado y desplazamiento de los desplegables
class _FormDropdownState<T> extends State<FormDropdown<T>> {
  // Controlador para la posición del dropdown y hace comportarse como un scroll
  final ScrollController _menuScrollController = ScrollController();

  // Libera el controlador cuando se elimine el widget, es decir, cuando se cierre
  @override
  void dispose() {
    _menuScrollController.dispose();
    super.dispose();
  }

  // Construye el Widget empleado para los desplegables y la barra de desplazamiento.
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth;
      final items = widget.values
          .map<Widget>(
            (item) => SizedBox(
              width: width,
              child: MenuItemButton(
                onPressed: () => widget.onChanged(item),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item?.toString() ?? 'N/A',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList();
      final menuChildren = widget.values.length > 5
          ? <Widget>[
              SizedBox(
                width: width,
                height: 5 * 48,
                child: Scrollbar(
                  controller: _menuScrollController,
                  thumbVisibility: true,
                  trackVisibility: true,
                  thickness: 6,
                  radius: const Radius.circular(8),
                  child: ListView(
                    controller: _menuScrollController,
                    padding: EdgeInsets.zero,
                    children: items,
                  ),
                ),
              ),
            ]
          : items;

      return MenuAnchor(
        alignmentOffset: const Offset(0, 4),
        crossAxisUnconstrained: false,

        style: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(AppColors.white),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 4),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.navy, width: 2),
            ),
          ),
        ),

        menuChildren: menuChildren,
        builder: (context, controller, child) => SizedBox(
          width: width,
          child: InkWell(
            onTap: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },

            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),

              decoration: BoxDecoration(
                border: Border.all(color: AppColors.navy, width: 2.5),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.hint != null && widget.value.toString().isEmpty
                          ? widget.hint!
                          : widget.value.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.darkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.navy,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
