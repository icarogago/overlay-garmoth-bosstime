# Garmoth Boss Timer (Rainmeter Skin)

## Sobre
Projeto autoral de **Icaro Gago**, mantido por **Icaro Gago**.

Este projeto é uma Skin para Rainmeter que exibe o cronômetro para os chefes mundiais do Black Desert Online (BDO), focado na precisão e simplicidade visual.

## Pré-requisitos
- [Rainmeter](https://www.rainmeter.net/) instalado (versão 4.5 ou superior recomendada).

## Instalação

1. **Baixe ou Clone este repositório**.
2. **Mova a pasta do projeto**:
   Crie a pasta `GarmothTimer` no diretório de Skins do seu Rainmeter.
   - Caminho padrão: `C:\Users\{SeuUsuario}\Documents\Rainmeter\Skins\`
3. **Carregue a Skin**:
   - Abra o gerenciador do Rainmeter.
   - Clique no botão "Atualizar tudo" (Refresh All).
   - Localize a pasta `GarmothTimer` na lista à esquerda.
   - Selecione o arquivo `GarmothTimer.ini` e clique em "Carregar" (Load).

## Estrutura de Arquivos
Para o correto funcionamento, certifique-se de que os arquivos estejam organizados desta forma:

```text
Rainmeter/
  Skins/
    GarmothTimer/
      ├── BossSchedule.lua   # Script Lua com a lógica dos horários e chefes
      ├── GarmothTimer.ini   # Arquivo principal de configuração visual
      └── README.md          # Documentação do projeto
```

## Personalização (Cores e Fontes)

Você pode personalizar a aparência da skin alterando as variáveis no arquivo de configuração.

1. Clique com o botão direito na Skin carregada na sua área de trabalho e escolha **"Editar skin"**.
2. O arquivo `GarmothTimer.ini` abrirá no seu editor de texto padrão.
3. Localize a seção `[Variables]` logo no início do arquivo.

### Variáveis Configuráveis

Você pode alterar os valores após o sinal de igual (`=`).

| Variável | Descrição | Exemplo de Valor |
|----------|-----------|------------------|
| `FontName` | Fonte padrão para textos normais | `Century Gothic` |
| `FontNameBold` | Fonte para textos em destaque/negrito | `Century Gothic` |
| `ColorRegion` | Cor do texto "Próximo BOSS" | `255,255,255,255` |
| `ColorTimer` | Cor do cronômetro de contagem regressiva | `255,0,0,255` |
| `ColorBg` | Cor de fundo da interface | `0,0,0,150` |

*Nota: As cores em Rainmeter geralmente seguem o padrão RGBA: `R,G,B,Alpha` (0-255).*

### Aplicando Mudanças
Após salvar o arquivo de texto:
1. Volte para a área de trabalho.
2. Clique com o botão direito na skin.
3. Escolha **"Atualizar skin"** (Refresh skin) para ver as mudanças.

---
**Créditos**
- Autor Original: **Icaro Gago**
- Mantenedor Atual: **Icaro Gago**
