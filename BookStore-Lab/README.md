# 📚 BookStore Lab

Um laboratório prático desenvolvido para estudar os principais recursos do **Databricks**, **Apache Spark**, **Spark SQL** e **Delta Lake**, utilizando um cenário fictício de uma livraria.

O projeto foi criado como complemento ao curso **Databricks Certified Data Engineer Associate**, porém evoluiu para um laboratório independente com foco em boas práticas de Engenharia de Dados.

---

# 🎯 Objetivos

Este laboratório tem como objetivo praticar conceitos utilizados no dia a dia de um Data Engineer, incluindo:

- Criação de tabelas Delta
- Carga de dados
- Spark SQL
- User Defined Functions (UDF)
- Views
- Validation Queries
- MERGE INTO
- Window Functions
- Higher Order Functions
- Structured Streaming
- Organização de projetos Databricks
- Versionamento utilizando Git e GitHub

---

# 🏗 Arquitetura do Projeto

```
BookStore-Lab
│
├── 00 - Menu.sql
│
├── 01_Setup
│   ├── 01 - Create Structures and Tables.sql
│   ├── 02 - Load Books.sql
│   ├── 03 - Load Customers.sql
│   ├── 04 - Load Orders.sql
│   └── 05 - Load Orders Updates.sql
│
├── 02_SQL
│   ├── 06 - Create User Defined Functions.sql
│   ├── 07 - Create Views.sql
│   ├── 08 - Validation Queries.sql
│   ├── 09 - Merge Into.sql
│   ├── 10 - Window Functions.sql
│   └── 11 - Higher Order Functions.sql
│
└── 03_Streaming
    ├── 12 - Streaming.sql
    └── 13 - Cleanup.sql
```

---

# 📖 Conteúdo

## 📦 01 - Setup

Preparação completa do ambiente.

- Criação do catálogo
- Criação do Schema
- Criação das tabelas Delta
- Carga de livros
- Carga de clientes
- Carga de pedidos
- Carga de atualizações

---

## 💻 02 - SQL

Exemplos práticos utilizando Spark SQL.

- SQL UDF
- Views
- Validation Queries
- MERGE INTO
- Window Functions
- Higher Order Functions

---

## 🌊 03 - Streaming

Introdução ao processamento incremental.

- Structured Streaming
- Cleanup do ambiente

---

# 📑 Estrutura dos Notebooks

Todos os notebooks seguem exatamente o mesmo padrão didático.

```
📖 Introdução

🎯 Objetivo

🧠 Conceito

📝 Sintaxe

💡 Exemplos

▶️ Execução

🧪 Exercícios

✅ Solução

📌 Resumo

🚀 Desafio
```

Esse formato foi criado para facilitar o estudo progressivo dos recursos do Databricks.

---

# 🗂 Modelo de Dados

O laboratório utiliza quatro tabelas principais.

| Tabela | Descrição |
|---------|-----------|
| books | Catálogo de livros |
| customers | Cadastro de clientes |
| orders | Pedidos realizados |
| orders_updates | Atualizações utilizadas no MERGE INTO |

---

# 🚀 Tecnologias

- Databricks
- Apache Spark
- Spark SQL
- Delta Lake
- Structured Streaming
- Git
- GitHub

---

# ▶ Como executar

## 1. Clonar o repositório

```bash
git clone https://github.com/data-labs-reginaldo/databricks-course.git
```

---

## 2. Importar no Databricks

Criar um **Repo** conectado ao GitHub e clonar este repositório.

---

## 3. Executar os notebooks

A ordem recomendada é:

```
01_Setup

↓

02_SQL

↓

03_Streaming
```

---

# 🎓 Competências praticadas

Durante este laboratório são praticados conceitos como:

- Data Lakehouse
- Delta Tables
- Spark SQL
- Data Modeling
- ETL
- ELT
- Arrays
- Structs
- JSON
- Incremental Processing
- Streaming
- Data Validation

---

# 📚 Público-alvo

Este laboratório é indicado para:

- Engenheiros de Dados
- Analistas de Dados
- Cientistas de Dados
- Estudantes de Databricks
- Pessoas em preparação para a certificação Databricks Data Engineer Associate

---

# 🛣 Roadmap

## ✔ Concluído

- Estrutura do projeto
- Setup
- SQL
- Streaming
- GitHub Integration

## 🚧 Próximas melhorias

- Diagramas da arquitetura
- Modelo entidade-relacionamento
- Screenshots
- Pipeline Bronze / Silver / Gold
- Unity Catalog
- Delta Live Tables
- Workflows
- CI/CD

---

# 🤝 Contribuições

Sugestões e melhorias são sempre bem-vindas.

Caso encontre algum problema, fique à vontade para abrir uma Issue ou enviar um Pull Request.

---

# 👨‍💻 Autor

**Reginaldo**

Data Engineer

---

# 📄 Licença

Este projeto foi desenvolvido para fins de estudo e demonstração prática dos recursos do Databricks e Apache Spark.