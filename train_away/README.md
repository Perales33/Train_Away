# Train Away

Aplicación móvil desarrollada con Flutter para crear reservas de tren. Permite elegir el trayecto, indicar los pasajeros y las opciones del viaje, seleccionar fecha y hora, revisar el resumen y confirmar la reserva.

## Funcionalidades

- Selección de origen y destino entre estaciones disponibles. No se puede elegir la misma estación para ambos, pudiendo ser las opciones.
- Selección de entre 1 y 8 pasajeros y de categoría ('1ª clase' y '2ª clase') (Véase documento: [`form_page.dart`](lib/pages/form_page.dart)).
- Selección de opciones adicionales del viaje (equipaje, servicio restaurante y coche cama).
- Calendario en español con fechas disponibles desde el mes actual y selección de hora predifinidas para todos los días (Véase documento: [`hour_selection.dart`](lib/widgets/hour_selection.dart#13)).
- Revisión de los datos antes de confirmar y pantalla de confirmación de reserva de cita.
- El logo reinicia el flujo y restaura los valores iniciales.

> La aplicación muestra un flujo de reserva de demostración. No conecta con un servicio de reservas ni compra billetes. <br>Para cargar las estaciones y categorías se realiza desde el propio código mediante un Array.

### Código relacionado con las funcionalidades

- [Flujo principal de carga de datos](lib/main.dart#L52)
- [Selección de origen](lib/pages/form_page.dart#L47)
- [Selección de destino](lib/pages/form_page.dart#L59)
- [Selección de pasajeros](lib/pages/form_page.dart#L73)
- [Selección de categoría](lib/pages/form_page.dart#L87)
- [Opciones extra](lib/pages/form_page.dart#L102)
- [Selección fecha](lib/pages/date_time_page.dart)
- [Selección de horas](lib/widgets/hour_selection.dart)
- [Resumen de la reserva](lib/pages/reservation_confirmed.dart)
- [Diálogo de confirmación](lib/pages/confirmation_dialog.dart)
- [Pantalla de reserva completada](lib/pages/success_page.dart)


## Flujo general de páginas

```bash
Formulario de reserva <──────────────────(No)────────────┐
|                                                        |
└──> Selección de fecha y hora del tren                  |
     |                                                   |
     └──> Previsualización de los datos de la reserva    |
          |                                              |
          └──> Dialogo para confirmación de la reserva ──┘
               |
              (Sí)
               └──> Confirmación de reservada completada
```

## Requisitos

- Flutter instalado y configurado.
- Un emulador, dispositivo móvil o navegador web siendo todos compatibles con Flutter.

Comprueba la instalación con:

```bash
flutter doctor
```

## Ejecutar

Desde la carpeta `train_away`:

```bash
flutter pub get
flutter run
```

Para ejecutar en un dispositivo concreto, consulta los destinos disponibles y selecciona su identificador:

```bash
flutter devices
flutter run -d <device>
```

## Estructura del proyecto

```text
lib/
├── main.dart                  # Configuración de la app y flujo de pantallas
├── pages/                     # Formulario, fecha/hora, resumen y confirmación
├── theme/                     # Colores de la aplicación
└── widgets/                   # Componentes reutilizables
assets/
├── fonts/                     # Tipografías de la aplicación
└── img/                       # Icono y recursos gráficos
```

## Dependencias principales

- `syncfusion_flutter_datepicker`: Calendario para seleccionar la fecha, habiendose precreado (sin la necesidad de alargar el código para hacer un calendario a mano). Usado en la página `date_time_page.dart`.
- `syncfusion_localizations`: Localización del calendario, para poder traducir todo el contenido del calendario al lenguaje del propio sistema.  Usado en la página `main.dart`.
- `flutter_localizations`: Localización de componentes Flutter, permitiendo delegar en el sistema el tipo de traducción que va a usar. Usado en la página `main.dart`. 

## Configuración del icono

El proyecto configura `flutter_launcher_icons` en `pubspec.yaml`. Para volver a generar los iconos de Android e iOS después de cambiar la imagen configurada:

```bash
dart run flutter_launcher_icons
```

## Elementos reutilizables

Para poder generar las diferentes pantallas del proyecto, se ha creado la carpeta widgets que alberga los diferentes elementos reutilizables para la aplicación:
- `app_banner.dart`: Navbar de la aplicación.
- `app.bottom_button.dart`: Footer de la aplicación.
- `form_dropdown.dart`: Estilos y creación de los elementos tipo desplegable del menú del formulario de reserva.
- `form_field_label.dart`: Estilos de los labels del formulario
- `hour_selection.dart`: Selector de horarios para la pantalla `date_time_page.dart`.

Además, de la carpeta widgets, se utiliza la carpeta theme para poder definir de forma prederteminada los colores que usará la aplicación.
- `app_colors.dart`: Tema principal de la aplicación.