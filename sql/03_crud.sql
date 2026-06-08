INSERT INTO arena_esportes.jogador_mensalista (cpf, nome, sobrenome, data_nascimento)
VALUES ('999.888.777-66', 'Carlos', 'Eduardo', '1994-03-15');

-- ====================================================================
-- R (Read): Consultar os dados do jogador que acabou de ser criado
-- ====================================================================
SELECT * FROM arena_esportes.jogador_mensalista 
WHERE cpf = '999.888.777-66';

-- ====================================================================
-- U (Update): Atualizar o sobrenome do jogador criado
-- ====================================================================
UPDATE arena_esportes.jogador_mensalista 
SET sobrenome = 'Eduardo Silva' 
WHERE cpf = '999.888.777-66';

-- ====================================================================
-- D (Delete): Excluir o jogador do banco de dados
-- ====================================================================
DELETE FROM arena_esportes.jogador_mensalista 
WHERE cpf = '999.888.777-66';


esse é o proximo
