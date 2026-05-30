# sistema_restaurante (RestoTab)

Sistema de gestión de restaurantes multiplataforma (Flutter).

## Requisitos

- [FVM](https://fvm.app/documentation/getting-started/installation) (Flutter Version Management)
- Git

No hace falta tener Flutter instalado globalmente: FVM descarga y usa la versión definida en `.fvmrc`.

## Clonar y ejecutar en cualquier máquina

```bash
git clone <url-del-repo>
cd sistema_restaurante

# Instalar FVM (elige uno)
dart pub global activate fvm
# Windows (Chocolatey): choco install fvm
# macOS (Homebrew): brew tap leoafarias/fvm && brew install fvm

fvm install
fvm flutter pub get
fvm flutter run
```

La versión de Flutter del proyecto está fijada en [`.fvmrc`](.fvmrc) (actualmente **3.44.0**). Tras `fvm install`, se crea el enlace `.fvm/flutter_sdk` apuntando a ese SDK (no se sube al repositorio).

## Comandos habituales

Prefija los comandos de Flutter/Dart con `fvm`:

| Sin FVM global | Con FVM en el proyecto |
|----------------|-------------------------|
| `flutter pub get` | `fvm flutter pub get` |
| `flutter run` | `fvm flutter run` |
| `flutter test` | `fvm flutter test` |
| `dart run build_runner build` | `fvm dart run build_runner build` |

## IDE

### VS Code / Cursor

El proyecto incluye [`.vscode/settings.json`](.vscode/settings.json) con `dart.flutterSdkPath` en `.fvm/flutter_sdk`. Después de `fvm install`, recarga la ventana del editor (**Developer: Reload Window**).

### Android Studio

1. **File → Settings → Languages & Frameworks → Flutter**
2. Flutter SDK path: ruta absoluta a `<proyecto>/.fvm/flutter_sdk`
3. Tras cambiar de versión con `fvm use`, vuelve a seleccionar esa ruta si el IDE no detecta el cambio.

## Cambiar la versión de Flutter del proyecto

```bash
fvm use 3.44.0
git add .fvmrc
git commit -m "chore: pin Flutter 3.44.0"
```

Comparte el commit de `.fvmrc` para que el resto del equipo use la misma versión al hacer `fvm install`.

## Verificación

```bash
fvm flutter --version
fvm flutter doctor
```
