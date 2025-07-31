# 🔐 Configuración Segura de Firebase

Este documento explica cómo configurar los secretos de Firebase de manera segura para evitar exponer claves API en el repositorio.

## 🚨 Archivos Sensibles

Los siguientes archivos contienen información sensible y NO deben subirse a GitHub:

- `google-services.json` (Android)
- `GoogleService-Info.plist` (iOS)
- `firebase_options.dart` (generado automáticamente)
- `.env` (variables de entorno)

## 📋 Pasos para Configurar los Secretos

### 1. Crear el archivo .env

Crea un archivo `.env` en la raíz del proyecto con el siguiente contenido:

```env
# Firebase Configuration
# Web
FIREBASE_WEB_API_KEY=AIzaSyCECC0QtckzdzmY3uZmxIcwvm2XVjt1aq0
FIREBASE_WEB_APP_ID=1:836656395960:web:142713e1739cb7b91ae64d
FIREBASE_WEB_AUTH_DOMAIN=turnosya-test.firebaseapp.com

# Android
FIREBASE_ANDROID_API_KEY=AIzaSyCiAiUR9DGHbHTFY7ukQjmb61wVvsmYz3Q
FIREBASE_ANDROID_APP_ID=1:836656395960:android:5e29c71c30bbf4f81ae64d

# iOS
FIREBASE_IOS_API_KEY=AIzaSyA_bbCuvvuW5FWEeLHnBqMK4tIsTwNAcsg
FIREBASE_IOS_APP_ID=1:836656395960:ios:a46cdaf854778ed01ae64d
FIREBASE_IOS_BUNDLE_ID=com.example.proyectoPrueba

# Windows
FIREBASE_WINDOWS_API_KEY=AIzaSyCECC0QtckzdzmY3uZmxIcwvm2XVjt1aq0
FIREBASE_WINDOWS_APP_ID=1:836656395960:web:48402e00844cefe11ae64d

# Common
FIREBASE_PROJECT_ID=turnosya-test
FIREBASE_MESSAGING_SENDER_ID=836656395960
FIREBASE_STORAGE_BUCKET=turnosya-test.firebasestorage.app
```

### 2. Instalar dependencias

Ejecuta el siguiente comando para instalar flutter_dotenv:

```bash
flutter pub get
```

### 3. Verificar .gitignore

Asegúrate de que el archivo `.gitignore` incluya las siguientes líneas:

```gitignore
# SECURITY: Firebase and sensitive files
google-services.json
GoogleService-Info.plist
firebase_options.dart
.env
*.keystore
*.jks
key.properties
```

## 🔧 Configuración para CI/CD

### GitHub Actions

Si usas GitHub Actions, agrega los secretos en Settings > Secrets and variables > Actions:

```yaml
# .github/workflows/flutter.yml
name: Flutter CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.8.1'
      - run: flutter pub get
      - run: flutter test
      - run: flutter build apk
        env:
          FIREBASE_WEB_API_KEY: ${{ secrets.FIREBASE_WEB_API_KEY }}
          FIREBASE_ANDROID_API_KEY: ${{ secrets.FIREBASE_ANDROID_API_KEY }}
          FIREBASE_IOS_API_KEY: ${{ secrets.FIREBASE_IOS_API_KEY }}
          FIREBASE_PROJECT_ID: ${{ secrets.FIREBASE_PROJECT_ID }}
          # ... otros secretos
```

### Variables de Entorno en Build

Para builds de producción, puedes usar variables de entorno:

```bash
flutter build apk --dart-define=FIREBASE_WEB_API_KEY=your_key_here
```

## 🛡️ Validación de Seguridad

### Pre-commit Hook (Opcional)

Instala `gitleaks` para escanear secretos:

```bash
# macOS
brew install gitleaks

# Windows
choco install gitleaks

# Linux
wget -qO- https://gitleaks.io/install.sh | sh
```

Configura el hook:

```bash
# .git/hooks/pre-commit
#!/bin/sh
gitleaks detect --source . --verbose
```

## 🚨 Respuesta de Emergencia

Si accidentalmente expones secretos:

1. **Inmediatamente**: Rota todas las credenciales comprometidas
2. **Audita**: Revisa todos los logs de acceso
3. **Notifica**: Fuerza re-autenticación para usuarios afectados
4. **Documenta**: Registra el incidente y las acciones tomadas

## 📝 Notas Importantes

- Nunca commits archivos `.env` con valores reales
- Usa diferentes claves para desarrollo y producción
- Revisa regularmente los permisos de las claves API
- Considera usar Firebase App Check para mayor seguridad

## 🔍 Verificación

Para verificar que todo está configurado correctamente:

1. Ejecuta `flutter run` - debe funcionar sin errores
2. Verifica que `.env` no aparece en `git status`
3. Confirma que `firebase_options.dart` está en `.gitignore`

## 📞 Soporte

Si tienes problemas con la configuración:

1. Verifica que todas las variables de entorno están definidas
2. Asegúrate de que `flutter_dotenv` está instalado
3. Confirma que el archivo `.env` está en la raíz del proyecto
4. Revisa que `FirebaseConfig.initialize()` se llama en `main()` 