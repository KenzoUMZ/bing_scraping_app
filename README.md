# google_scraping_app

A new Flutter project.

## Testes

Para executar os testes unitários e de widgets:

```bash
flutter test
```

Os testes incluem:
- `SearchInternetController`: verifica estados de sucesso e falha.
- `SearchResponseEntity`: valida parsing de JSON.
- `SearchPage` (widget test): garante renderização e fluxo de busca.

Gerar relatório de cobertura (opcional):

```bash
flutter test --coverage
```

Abra o HTML de cobertura (requer lcov instalado):

```bash
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```
