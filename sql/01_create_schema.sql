-- ====================================================================
-- 1. CRIAÇÃO DO SCHEMA
-- ====================================================================
CREATE SCHEMA IF NOT EXISTS arena_esportes;

-- Configura o caminho de busca para que os comandos abaixo 
-- criem as tabelas automaticamente dentro do novo schema.
SET search_path TO arena_esportes, public;


-- ====================================================================
-- 2. TABELAS INDEPENDENTES
-- ====================================================================

CREATE TABLE arena_esportes.jogador_mensalista (
    cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    data_nascimento DATE NOT NULL
);

CREATE TABLE arena_esportes.quadra (
    id_quadra SERIAL PRIMARY KEY,
    nome_quadra VARCHAR(50) NOT NULL,
    tipo_areia VARCHAR(30) NOT NULL
);

CREATE TABLE arena_esportes.professor (
    id_professor SERIAL PRIMARY KEY,
    nome_professor VARCHAR(100) NOT NULL
);

CREATE TABLE arena_esportes.equipamento_aluguel (
    id_equipamento SERIAL PRIMARY KEY,
    nome_equipamento VARCHAR(50) NOT NULL,
    preco_diaria DECIMAL(10,2) NOT NULL
);


-- ====================================================================
-- 3. TABELAS DOS ATRIBUTOS MULTIVALORADOS E 1:1
-- ====================================================================

CREATE TABLE arena_esportes.jogador_dias (
    cpf_jogador VARCHAR(14) REFERENCES arena_esportes.jogador_mensalista(cpf) ON DELETE CASCADE,
    dia_semana VARCHAR(20),
    PRIMARY KEY (cpf_jogador, dia_semana)
);

CREATE TABLE arena_esportes.professor_certificacoes (
    id_professor INT REFERENCES arena_esportes.professor(id_professor) ON DELETE CASCADE,
    certificacao VARCHAR(50),
    PRIMARY KEY (id_professor, certificacao)
);

CREATE TABLE arena_esportes.camera_transmissao (
    id_camera SERIAL PRIMARY KEY,
    modelo VARCHAR(50) NOT NULL,
    ip_rede VARCHAR(15) NOT NULL,
    id_quadra INT UNIQUE REFERENCES arena_esportes.quadra(id_quadra) ON DELETE CASCADE
);


-- ====================================================================
-- 4. TABELA DE MOVIMENTAÇÃO (1:N)
-- ====================================================================

CREATE TABLE arena_esportes.reserva_horario (
    id_reserva SERIAL PRIMARY KEY,
    data_reserva DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_termino TIME NOT NULL,
    cpf_jogador VARCHAR(14) REFERENCES arena_esportes.jogador_mensalista(cpf),
    id_quadra INT REFERENCES arena_esportes.quadra(id_quadra),
    id_professor INT REFERENCES arena_esportes.professor(id_professor) NULL
);


-- ====================================================================
-- 5. TABELA INTERMEDIÁRIA (N:N)
-- ====================================================================

CREATE TABLE arena_esportes.itens_reserva_equipamento (
    id_reserva INT REFERENCES arena_esportes.reserva_horario(id_reserva) ON DELETE CASCADE,
    id_equipamento INT REFERENCES arena_esportes.equipamento_aluguel(id_equipamento),
    quantidade INT NOT NULL,
    PRIMARY KEY (id_reserva, id_equipamento)
);
