# Gemini Terminal Prompt

Este projeto permite que você interaja com a API Gemini diretamente pelo terminal, salvando cada prompt enviado, a resposta recebida e a data/hora em um banco de dados PostgreSQL local. Também é possível consultar o histórico de interações.

## Sobre a API

- **API utilizada:** Gemini (Google Generative Language API)
- **Recurso:** Geração de conteúdo textual a partir de prompts enviados pelo usuário.
- **Documentação oficial:** https://ai.google.dev/gemini-api/docs

## Funcionalidades

- Envio de prompts para a API Gemini via terminal
- Armazenamento do prompt, resposta e data em banco PostgreSQL
- Consulta ao histórico de interações

## Como usar

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/Bruno0M/gemini_rb.git
   cd gemini_rb
   ```

2. **Instale as dependências:**

   ```bash
   bundle install
   ```

3. **Configure a variável de ambiente:**

   Crie um arquivo `.env` na raiz do projeto com sua chave de API:
   
   ```env
   GOOGLE_API_KEY=seu_api_key_aqui
   ```

4. **Configure o banco de dados:**

   Certifique-se de ter um PostgreSQL rodando localmente com um banco chamado `gemini_db` e usuário/senha `postgres`.

5. **Execute o script:**

   Para enviar um prompt:
   
   ```bash
   ruby gemini_rb.rb "Seu prompt aqui"
   ```

   Para consultar o histórico:
   
   ```bash
   ruby gemini_rb.rb --history
   ```

## Estrutura do Projeto

- `gemini_rb.rb`: Script principal para execução via terminal.
- `lib/app.rb`: Lógica principal de integração entre API, banco e terminal.
- `lib/gemini_client.rb`: Cliente para consumo da API Gemini.
- `lib/database.rb`: Classe para conexão e operações com o banco PostgreSQL.

## Dependências Utilizadas

- `pg`: Conexão com banco de dados PostgreSQL
- `httparty`: Consumo de APIs HTTP
- `dotenv`: Carregamento de variáveis de ambiente
