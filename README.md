# Train Away

Aplicación móvil desarrollada con Flutter para crear reservas de tren. Permite elegir el trayecto, indicar los pasajeros y las opciones del viaje, seleccionar fecha y hora, revisar el resumen y confirmar la reserva.

## Funcionalidades

- Selección de origen y destino entre estaciones disponibles. No se puede elegir la misma estación para ambos, pudiendo ser las opciones.
- Selección de entre 1 y 8 pasajeros y de categoría ('1ª clase' y '2ª clase').
- Selección de opciones adicionales del viaje (equipaje, servicio restaurante y coche cama).
- Calendario en español con fechas disponibles desde el mes actual y selección de hora predifinidas para todos los días.
- Revisión de los datos antes de confirmar y pantalla de confirmación de reserva de cita.
- El logo reinicia el flujo y restaura los valores iniciales.
- Carga de los datos de la aplicación desde un sistema de mock para simular una base de datos.

> La aplicación muestra un flujo de reserva de demostración. No conecta con un servicio de reservas ni compra billetes, todo se realiza desde el archivo mock_service.dart y las clases dentro de la
> carpeta models.

## Flujo general de páginas

El flujo de la aplicación se estructura en diferentes pasos que se establecen desde la actividad de Penpot: 

> Pantalla de formulario → Pantalla de selección de fecha y hora → Pantalla del resumen de la reserva → Pantalla de la confirmación de la reserva. 

Cada pantalla se comunica con la siguiente a través de los datos seleccionados por el usuario (origen, destino, pasajeros, categoría, opciones, fecha y hora), pasándose mediante el Navigator de Flutter como resultado de la pantalla anterior.


```bash
Formulario de reserva <──────────────(No)──────────┐
│                                                  │
└──> Selección de fecha y hora del tren            │
     │                                             │
     └──> Previsualización de la reserva           │
          │                                        │
          └──> Diálogo de confirmación ────────────┘
               │
              (Sí)
               └──> Confirmación de reserva completada
```

## Gestión de estado y navegación

La aplicación gestiona el estado de la reserva mediante variables propias de la pantalla principal y un enum con diferentes valores (ReservationStep: form, summary, success) que determina qué pantalla se muestra en cada momento. 

El uso de Navigator permite abrir la pantalla de selección de fecha y hora para recibir el resultado (DateTimeSelection) y continuar el flujo.

Finalmente, el logo de la aplicación nos reinicia el flujo restaurando la aplicación a los valores iniciales, ya que no deja de tratarse de un mock visual, que sirve como muestra al cliente.

### Paso de parámetros entre pantallas

La comunicación entre pantallas se realiza mediante el estado de la pantalla principal (ConfirmationPage definida en main.dart) y el retorno de resultados a través del Navigator de Flutter.
 
- Del formulario a la selección de fecha y hora: los datos del viaje (origen, destino, pasajeros, categoría y opciones) se almacenan en las variables del estado de la pantalla principal y se envían a FormPage como parámetros. Al pulsar la acción principal ("Reservar"), la pantalla principal abre la pantalla de selección de fecha y hora mediante Navigator.push, para recibir el resultado (DateTimeSelection) una vez el usuario confirma la fecha y la hora.

- De la selección al resumen: la pantalla de fecha y hora devuelve los datos seleccionados (que son la fecha y la hora) al cerrar la ruta mediante Navigator.pop, momento en el que la pantalla principal los recibe y avanza al estado summary, mostrando la ReservationConfirmedPage con todos los datos del viaje.

- Del resumen a la confirmación: la pantalla de resumen muestra los datos recibidos y, mediante el botón de acción, abre el ConfirmationDialog. Si el usuario confirma, la aplicación avanza al estado success (pantalla de éxito); si cancela, vuelve al estado form.

- De la confirmación al reinicio: al finalizar este flujo (éxito o cancelación por parte del cliente), y el logo de la aplicación reinicia el flujo restaurando los valores iniciales.


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
┌── android/                # Configuracion para Android
├── assets/                 # Fuentes e imagenes
│   ├── fonts/              # Tipografías de la aplicación
│   └── img/                # Icono y recursos gráficos
├── ios/                    # Configuracion para iOS
├── lib/                    # Codigo Dart de la aplicacion
│   ├── main.dart           # Inicio y flujo principal
│   ├── pages/              # Pantallas y dialogo de reserva
│   ├── theme/              # Colores de la aplicacion
│   ├── models/             # Clases estáticas para cargar los datos
│   ├── mocks/              # Mock para poder recuperar los datos
│   └── widgets/            # Componentes reutilizables
│    
├── linux/                  # Configuracion para Linux
├── macos/                  # Configuracion para macOS
├── test/                   # Pruebas del proyecto
├── web/                    # Configuracion y recursos web
├── windows/                # Configuracion para Windows
├── .gitignore              # Archivos excluidos de Git
├── analysis_options.yaml   # Reglas de analisis de Dart
├── pubspec.yaml            # Dependencias y recursos del proyecto
├── pubspec.lock            # Versiones instaladas de dependencias
└── README.md               # Documentacion del proyecto
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

## Bibliografía

- [Documentación oficial de Flutter](https://docs.flutter.dev/)
- [Internacionalización y localización en Flutter](https://docs.flutter.dev/ui/internationalization)
- [Clase Navigator de Flutter](https://api.flutter.dev/flutter/widgets/Navigator-class.html)
- [Guía de inicio de SfDateRangePicker de Syncfusion](https://help.syncfusion.com/flutter/daterangepicker/getting-started)
- [Introducción al lenguaje Dart](https://dart.dev/language)
- [Clase MaterialApp de Flutter](https://api.flutter.dev/flutter/material/MaterialApp-class.html)
- [Paquete syncfusion_localizations](https://pub.dev/packages/syncfusion_localizations)