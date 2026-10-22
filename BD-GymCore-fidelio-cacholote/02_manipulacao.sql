-- Trabalho II - GymCore: manipulacao dos dados
USE gymcore_trabalho;

-- SELECT 1: membros activos, por ordem alfabetica.
SELECT id, nome, email, telefone FROM members WHERE estado = 'ativo' ORDER BY nome ASC;

-- SELECT 2: pagamentos a partir de 4000 MT, do mais recente para o mais antigo.
SELECT id, member_id, valor, data_pagamento, metodo FROM payments WHERE valor >= 4000 ORDER BY data_pagamento DESC;

-- SELECT 3: aulas agendadas, ordenadas por data e hora.
SELECT id, class_type_id, data_aula, hora_inicio, vagas_disponiveis FROM class_sessions WHERE estado = 'agendada' ORDER BY data_aula, hora_inicio;

-- JOIN 1: contratos com nome do membro e plano contratado.
SELECT c.id AS contrato, m.nome AS membro, p.nome AS plano, c.data_inicio, c.data_fim, c.estado
FROM contracts c JOIN members m ON m.id = c.member_id JOIN plans p ON p.id = c.plan_id ORDER BY c.id;

-- JOIN 2: reservas com membro, aula e tipo de aula.
SELECT b.id AS reserva, m.nome AS membro, ct.nome AS aula, cs.data_aula, cs.hora_inicio, b.estado
FROM bookings b JOIN members m ON m.id = b.member_id JOIN class_sessions cs ON cs.id = b.session_id JOIN class_types ct ON ct.id = cs.class_type_id ORDER BY cs.data_aula;

-- UPDATE 1: actualizar o telefone do membro 1.
UPDATE members SET telefone = '+258 84 555 0001' WHERE id = 1;

-- UPDATE 2: actualizar o estado do pagamento 4 para pago.
UPDATE payments SET estado = 'pago' WHERE id = 4;

-- DELETE: eliminar uma reserva de teste; nao tem tabelas dependentes nesta modelacao.
DELETE FROM bookings WHERE id = 20;

-- TESTE DE INTEGRIDADE: executar separadamente para observar o erro de chave estrangeira.
-- O member_id 99999 nao existe em members, pelo que a FK deve rejeitar a insercao.
-- INSERT INTO bookings (tenant_id, member_id, session_id, data_reserva, estado)
-- VALUES (1, 99999, 1, '2026-10-20', 'confirmada');
