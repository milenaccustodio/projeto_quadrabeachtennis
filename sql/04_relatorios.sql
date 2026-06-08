SET search_path TO arena_esportes, public;

-- --------------------------------------------------------------------
-- Query 1: Lista de jogadores e suas respectivas reservas (1:N)
-- Filtro: Apenas reservas a partir de junho de 2026. Ordenado por data.
-- --------------------------------------------------------------------
SELECT j.nome, j.sobrenome, r.data_reserva, r.hora_inicio, r.id_quadra
FROM arena_esportes.jogador_mensalista j
INNER JOIN arena_esportes.reserva_horario r ON j.cpf = r.cpf_jogador
WHERE r.data_reserva >= '2026-06-01'
ORDER BY r.data_reserva ASC, r.hora_inicio ASC;

-- --------------------------------------------------------------------
-- Query 2: Atributo Derivado - Lista de jogadores com cálculo de IDADE
-- Filtro: Apenas jogadores com mais de 30 anos. Ordenado da maior para menor idade.
-- --------------------------------------------------------------------
SELECT cpf, nome, sobrenome, data_nascimento,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_nascimento)) AS idade_jogador
FROM arena_esportes.jogador_mensalista
WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_nascimento)) > 30
ORDER BY idade_jogador DESC;

-- --------------------------------------------------------------------
-- Query 3: Relacionamento 1:1 - Quadras e suas Câmeras de Transmissão
-- Filtro: Câmeras do modelo 'Intelbras'. Ordenado pelo nome da quadra.
-- --------------------------------------------------------------------
SELECT q.id_quadra, q.nome_quadra, c.modelo, c.ip_rede
FROM arena_esportes.quadra q
INNER JOIN arena_esportes.camera_transmissao c ON q.id_quadra = c.id_quadra
WHERE c.modelo LIKE '%Intelbras%'
ORDER BY q.nome_quadra ASC;

-- --------------------------------------------------------------------
-- Query 4: Relacionamento N:N - Equipamentos alugados por Reserva
-- Filtro: Quantidade de itens alugados maior ou igual a 2. Ordenado por quantidade.
-- --------------------------------------------------------------------
SELECT ir.id_reserva, eq.nome_equipamento, ir.quantidade, eq.preco_diaria
FROM arena_esportes.itens_reserva_equipamento ir
INNER JOIN arena_esportes.equipamento_aluguel eq ON ir.id_equipamento = eq.id_equipamento
WHERE ir.quantidade >= 2
ORDER BY ir.quantidade DESC;

-- --------------------------------------------------------------------
-- Query 5: Reservas de horários que possuem professor intermediando
-- Filtro: Filtrando apenas pelo professor de ID 1. Ordenado por horário.
-- --------------------------------------------------------------------
SELECT r.id_reserva, r.data_reserva, r.hora_inicio, p.nome_professor
FROM arena_esportes.reserva_horario r
INNER JOIN arena_esportes.professor p ON r.id_professor = p.id_professor
WHERE p.id_professor = 1
ORDER BY r.hora_inicio ASC;

-- --------------------------------------------------------------------
-- Query 6: Atributo Multivalorado - Dias de preferência dos Jogadores
-- Filtro: Jogadores que jogam de 'Sábado'. Ordenado pelo nome.
-- --------------------------------------------------------------------
SELECT j.nome, j.sobrenome, jd.dia_semana
FROM arena_esportes.jogador_mensalista j
INNER JOIN arena_esportes.jogador_dias jd ON j.cpf = jd.cpf_jogador
WHERE jd.dia_semana = 'Sábado'
ORDER BY j.nome ASC;

-- --------------------------------------------------------------------
-- Query 7: Atributo Multivalorado - Certificações dos Professores
-- Filtro: Certificações focadas em 'Beach Tennis'. Ordenado pelo professor.
-- --------------------------------------------------------------------
SELECT p.nome_professor, pc.certificacao
FROM arena_esportes.professor p
INNER JOIN arena_esportes.professor_certificacoes pc ON p.id_professor = pc.id_professor
WHERE pc.certificacao LIKE '%Beach Tennis%'
ORDER BY p.nome_professor ASC;

-- --------------------------------------------------------------------
-- Query 8: Cruzamento total - Jogador, Quadra reservada e Professor escalado
-- Filtro: Apenas para a quadra de ID 1 ou 2. Ordenado por data.
-- --------------------------------------------------------------------
SELECT r.id_reserva, j.nome AS jogador, q.nome_quadra, COALESCE(p.nome_professor, 'Sem Professor') AS professor
FROM arena_esportes.reserva_horario r
INNER JOIN arena_esportes.jogador_mensalista j ON r.cpf_jogador = j.cpf
INNER JOIN arena_esportes.quadra q ON r.id_quadra = q.id_quadra
LEFT JOIN arena_esportes.professor p ON r.id_professor = p.id_professor
WHERE q.id_quadra IN (1, 2)
ORDER BY r.data_reserva DESC;

-- --------------------------------------------------------------------
-- Query 9: Tipo de Areia mais utilizado/disponível nas quadras da Arena
-- Filtro: Apenas quadras com tipo de areia 'Quartzosa'. Ordenado por nome.
-- --------------------------------------------------------------------
SELECT id_quadra, nome_quadra, tipo_areia
FROM arena_esportes.quadra
WHERE tipo_areia LIKE '%Quartzosa%'
ORDER BY nome_quadra ASC;

-- --------------------------------------------------------------------
-- Query 10: Faturamento estimado por item alugado nas reservas
-- Filtro: Onde o valor total do aluguel do item ultrapasse R$ 20,00. Ordenado pelo total.
-- --------------------------------------------------------------------
SELECT ir.id_reserva, eq.nome_equipamento, ir.quantidade, eq.preco_diaria,
       (ir.quantidade * eq.preco_diaria) AS faturamento_estimado_item
FROM arena_esportes.itens_reserva_equipamento ir
INNER JOIN arena_esportes.equipamento_aluguel eq ON ir.id_equipamento = eq.id_equipamento
WHERE (ir.quantidade * eq.preco_diaria) > 20.00
ORDER BY faturamento_estimado_item DESC;

