# Bing Scraping App

Aplicativo Flutter para realizar buscas na internet e exibir resultados de forma organizada.

## Requisitos

- Flutter SDK 3.29.0 ou superior
- Dart SDK
- Android Studio / Xcode (para desenvolvimento mobile)
- FVM (opcional, para gerenciamento de versões do Flutter)

## Instalação

1. Clone o repositório:

```bash
git clone https://github.com/KenzoUMZ/bing_scraping_app.git
cd bing_scraping_app
```

2. Instale as dependências:

```bash
flutter pub get
```
## Executando o App

Para executar o app em desenvolvimento (recomendado):

```bash
flutter run --no-enable-impeller
```

> **Nota:** A flag `--no-enable-impeller` desabilita o Impeller renderer, que pode causar problemas com alguns efeitos visuais como blur.


### Selecionar dispositivo específico

Liste os dispositivos disponíveis:

```bash
flutter devices
```

Execute em um dispositivo específico:

```bash
flutter run -d <device_id>
```

### Plataformas suportadas

**Android:**
```bash
flutter run -d android
```

**iOS (apenas macOS):**
```bash
flutter run -d ios
```

## Build

### Android APK

```bash
flutter build apk --release
```

O APK será gerado em: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (para Google Play)

```bash
flutter build appbundle --release
```

### iOS (apenas macOS)

```bash
flutter build ios --release
```

## Testes

Para executar os testes:

```bash
flutter test
```

## Troubleshooting

### Erro de dependências

```bash
flutter clean
flutter pub get
```

### Erro de build no Android

```bash
cd android
./gradlew clean
cd ..
flutter build apk
```

### Erro de build no iOS

```bash
cd ios
pod deintegrate
pod install
cd ..
flutter build ios
```
