# Projeto - Sistema de Gestão de Arena Beach Tennis (ArenaSand)

## Cenário

A ArenaSand é um complexo esportivo focado na locação de quadras e aulas de Beach Tennis. Para modernizar sua gestão, a empresa necessita de um sistema de banco de dados capaz de controlar seus clientes, as reservas de quadras, a escala de professores e a locação de equipamentos esportivos.

### Entidades do Sistema

* Jogador_Mensalista
* Quadra
* Camera_Transmissao
* Reserva_Horario
* Professor
* Equipamento_Aluguel

### Tipos de Atributos Utilizados

#### Simples

* Data de nascimento
* Tipo de areia
* IP de rede

#### Compostos

* Nome completo (Nome + Sobrenome)

#### Multivalorados

* Dias disponíveis
* Certificações

#### Derivados

* Idade
* Valor com desconto

#### Chave

* CPF
* ID_Quadra
* ID_Camera
* ID_Reserva
* ID_Professor
* ID_Equipamento

### Relacionamentos

#### 1:1

* Quadra ↔ Camera_Transmissao

#### 1:N

* Jogador_Mensalista ↔ Reserva_Horario
* Quadra ↔ Reserva_Horario

#### N:N

* Reserva_Horario ↔ Equipamento_Aluguel

---

## Modelagem Conceitual

O modelo conceitual foi desenvolvido utilizando o Modelo Entidade-Relacionamento (MER), contemplando todas as entidades, atributos e relacionamentos exigidos.

### DER

Adicionar aqui o arquivo ou imagem do DER.

---

## Modelagem Lógica

O modelo lógico foi desenvolvido a partir do DER, contendo os tipos de dados, chaves primárias (PK) e chaves estrangeiras (FK) necessárias para a implementação do banco de dados.

Adicionar aqui a imagem do Modelo Lógico.

---

## Modelagem Física

O banco de dados foi implementado utilizando PostgreSQL no Supabase.

Os scripts SQL encontram-se na pasta:

```text
sql/
├── 01_create_schema.sql
├── 02_insert_dados.sql
├── 03_crud.sql
└── 04_relatorios.sql
```

---

## CRUD

### Create

Inserção de um novo jogador no banco de dados.

### Read

Consulta dos dados do jogador inserido.

### Update

Atualização do sobrenome do jogador.

### Delete

Exclusão do jogador cadastrado.

Adicionar os prints do CRUD.

---

## Relatórios

Foram desenvolvidas 10 consultas SQL utilizando:

* SELECT
* WHERE
* ORDER BY
* JOINs entre tabelas

Consultas implementadas:

1. Jogadores e reservas realizadas.
2. Cálculo de idade dos jogadores.
3. Quadras e câmeras de transmissão.
4. Equipamentos alugados por reserva.
5. Reservas com professor associado.
6. Dias preferenciais dos jogadores.
7. Certificações dos professores.
8. Cruzamento entre jogador, quadra e professor.
9. Tipos de areia das quadras.
10. Faturamento estimado por aluguel de equipamentos.

Adicionar os prints das consultas realizadas.

---

## Tecnologias Utilizadas

* PostgreSQL
* Supabase
* GitHub
* SQL

---

## Autora

Milena

