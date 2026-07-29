# Databricks Course + BookStore Lab

Repositório de estudos sobre **Databricks**, **Spark SQL**, **Delta Lake** e **Data Engineering**, contendo:

- 📚 Material de apoio utilizado durante o curso **Databricks Certified Data Engineer Associate**
- 🚀 Projeto prático **BookStore Lab**, desenvolvido para consolidar os conceitos aprendidos.

---

# Estrutura do Repositório

```
databricks-course/
│
├── BookStore-Lab/
│   ├── 01_Setup
│   ├── 02_SQL
│   ├── 03_Streaming
│   └── 00 - Menu.sql
│
├── course/
│   ├── 1- Databricks Lakehouse Platform
│   ├── 2- ELT with Spark SQL and Python
│   ├── 3- Incremental Data Processing
│   ├── 4- Production Pipelines
│   ├── 5- Data Governance
│   ├── Includes
│   └── Labs
│
└── README.md
```

---

# BookStore Lab

O **BookStore Lab** é um laboratório independente criado para praticar os principais conceitos do Databricks utilizando um cenário fictício de uma livraria.

O projeto foi desenvolvido como complemento ao curso e possui notebooks organizados de forma didática.

## Conteúdo

### 01 - Setup

- Criação do catálogo
- Criação do Schema
- Criação das tabelas Delta
- Carga inicial de dados

### 02 - SQL

- User Defined Functions
- Views
- Validation Queries
- MERGE INTO
- Window Functions
- Higher Order Functions

### 03 - Streaming

- Structured Streaming
- Cleanup

Cada notebook contém:

- 📖 Introdução
- 🎯 Objetivo
- 🧠 Conceito
- 📝 Sintaxe
- 💡 Exemplos
- ▶️ Execução
- 🧪 Exercícios
- ✅ Solução
- 📌 Resumo
- 🚀 Desafio

---

# Course

A pasta **course** contém o material utilizado durante o estudo do curso **Databricks Certified Data Engineer Associate**.

Os notebooks foram preservados praticamente na estrutura original para facilitar o acompanhamento das aulas.

Principais assuntos:

- Lakehouse
- Delta Lake
- Spark SQL
- PySpark
- Streaming
- Delta Live Tables
- Data Governance
- Unity Catalog

---

# Tecnologias

- Databricks
- Apache Spark
- Spark SQL
- Delta Lake
- PySpark
- Git
- GitHub

---

# Objetivos

Este repositório foi criado para:

- Consolidar conhecimentos em Databricks.
- Servir como laboratório para novos experimentos.
- Documentar a evolução dos estudos.
- Disponibilizar exemplos práticos para consulta.
- Compor um portfólio de Engenharia de Dados.

---

# Pré-requisitos

- Conta no Databricks Community Edition ou Workspace.
- Git.
- GitHub.
- Conhecimentos básicos de SQL.

---

# Como utilizar

Clone o repositório:

```bash
git clone https://github.com/data-labs-reginaldo/databricks-course.git
```

Importe o repositório para o Databricks utilizando **Repos**.

Execute os notebooks seguindo a ordem numérica.

---

# Autor

**Reginaldo**

Data Engineer

---

# Licença

Este projeto é destinado para fins educacionais.
-- ==============================================================================================================================
Depois de concluir o curso, podemos evoluir o BookStore-Lab para incluir os tópicos que ainda faltam para a certificação, como:
-- ==============================================================================================================================
Bronze / Silver / Gold
Auto Loader
Delta Live Tables
Unity Catalog
Workflows
Jobs
Data Quality
Performance (OPTIMIZE, ZORDER, VACUUM, Time Travel)
Views materializadas e métricas

