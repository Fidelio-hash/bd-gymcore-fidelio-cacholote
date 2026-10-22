-- Trabalho II de Tecnologias de Base de Dados
-- Tema: Sistema de Gestao de Ginasio - GymCore
-- Adaptacao academica baseada nos conceitos da base GymCore existente.
-- ATENCAO: este script apaga e recria APENAS gymcore_trabalho. Nao afecta gymcore.
DROP DATABASE IF EXISTS gymcore_trabalho;
CREATE DATABASE gymcore_trabalho CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gymcore_trabalho;
SET NAMES utf8mb4;

CREATE TABLE tenants (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 email VARCHAR(120) NOT NULL UNIQUE,
 estado ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
 criado_em DATE NOT NULL
) ENGINE=InnoDB;
CREATE TABLE branches (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 tenant_id INT UNSIGNED NOT NULL,
 nome VARCHAR(100) NOT NULL,
 cidade VARCHAR(80) NOT NULL,
 telefone VARCHAR(25),
 estado ENUM('ativa','inativa') NOT NULL DEFAULT 'ativa',
 FOREIGN KEY (tenant_id) REFERENCES tenants(id)
) ENGINE=InnoDB;
CREATE TABLE users (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 tenant_id INT UNSIGNED NOT NULL,
 branch_id INT UNSIGNED,
 nome VARCHAR(120) NOT NULL,
 email VARCHAR(120) NOT NULL UNIQUE,
 perfil ENUM('Administrador','Recepcionista','Instrutor','Gestor') NOT NULL,
 estado ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
 FOREIGN KEY (tenant_id) REFERENCES tenants(id),
 FOREIGN KEY (branch_id) REFERENCES branches(id)
) ENGINE=InnoDB;
CREATE TABLE members (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 tenant_id INT UNSIGNED NOT NULL,
 branch_id INT UNSIGNED NOT NULL,
 nome VARCHAR(120) NOT NULL,
 email VARCHAR(120) NOT NULL UNIQUE,
 telefone VARCHAR(25) NOT NULL,
 data_registo DATE NOT NULL,
 estado ENUM('ativo','suspenso','inativo') NOT NULL DEFAULT 'ativo',
 FOREIGN KEY (tenant_id) REFERENCES tenants(id),
 FOREIGN KEY (branch_id) REFERENCES branches(id)
) ENGINE=InnoDB;
CREATE TABLE plans (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 tenant_id INT UNSIGNED NOT NULL,
 nome VARCHAR(80) NOT NULL,
 duracao_dias INT UNSIGNED NOT NULL,
 preco DECIMAL(10,2) NOT NULL,
 estado ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
 FOREIGN KEY (tenant_id) REFERENCES tenants(id)
) ENGINE=InnoDB;
CREATE TABLE contracts (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 tenant_id INT UNSIGNED NOT NULL,
 member_id INT UNSIGNED NOT NULL,
 plan_id INT UNSIGNED NOT NULL,
 branch_id INT UNSIGNED NOT NULL,
 data_inicio DATE NOT NULL,
 data_fim DATE NOT NULL,
 estado ENUM('ativo','expirado','cancelado') NOT NULL DEFAULT 'ativo',
 FOREIGN KEY (tenant_id) REFERENCES tenants(id),
 FOREIGN KEY (member_id) REFERENCES members(id),
 FOREIGN KEY (plan_id) REFERENCES plans(id),
 FOREIGN KEY (branch_id) REFERENCES branches(id)
) ENGINE=InnoDB;
CREATE TABLE payments (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 tenant_id INT UNSIGNED NOT NULL,
 member_id INT UNSIGNED NOT NULL,
 branch_id INT UNSIGNED NOT NULL,
 valor DECIMAL(10,2) NOT NULL,
 data_pagamento DATE NOT NULL,
 metodo ENUM('Numerario','M-Pesa','E-Mola','Transferencia','POS') NOT NULL,
 estado ENUM('pago','pendente','anulado') NOT NULL DEFAULT 'pago',
 FOREIGN KEY (tenant_id) REFERENCES tenants(id),
 FOREIGN KEY (member_id) REFERENCES members(id),
 FOREIGN KEY (branch_id) REFERENCES branches(id)
) ENGINE=InnoDB;
CREATE TABLE class_types (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 tenant_id INT UNSIGNED NOT NULL,
 nome VARCHAR(80) NOT NULL,
 capacidade INT UNSIGNED NOT NULL,
 duracao_minutos INT UNSIGNED NOT NULL,
 estado ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
 FOREIGN KEY (tenant_id) REFERENCES tenants(id)
) ENGINE=InnoDB;
CREATE TABLE class_sessions (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 tenant_id INT UNSIGNED NOT NULL,
 class_type_id INT UNSIGNED NOT NULL,
 branch_id INT UNSIGNED NOT NULL,
 instructor_user_id INT UNSIGNED NOT NULL,
 data_aula DATE NOT NULL,
 hora_inicio TIME NOT NULL,
 vagas_disponiveis INT UNSIGNED NOT NULL,
 estado ENUM('agendada','realizada','cancelada') NOT NULL DEFAULT 'agendada',
 FOREIGN KEY (tenant_id) REFERENCES tenants(id),
 FOREIGN KEY (class_type_id) REFERENCES class_types(id),
 FOREIGN KEY (branch_id) REFERENCES branches(id),
 FOREIGN KEY (instructor_user_id) REFERENCES users(id)
) ENGINE=InnoDB;
CREATE TABLE bookings (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 tenant_id INT UNSIGNED NOT NULL,
 member_id INT UNSIGNED NOT NULL,
 session_id INT UNSIGNED NOT NULL,
 data_reserva DATE NOT NULL,
 estado ENUM('confirmada','presente','cancelada','falta') NOT NULL DEFAULT 'confirmada',
 FOREIGN KEY (tenant_id) REFERENCES tenants(id),
 FOREIGN KEY (member_id) REFERENCES members(id),
 FOREIGN KEY (session_id) REFERENCES class_sessions(id)
) ENGINE=InnoDB;


INSERT INTO tenants (id, nome, email, estado, criado_em) VALUES
(1, 'GymCore Unidade 1', 'contacto1@gymcore.co.mz', 'ativo', '2026-01-01'),
(2, 'GymCore Unidade 2', 'contacto2@gymcore.co.mz', 'ativo', '2026-01-02'),
(3, 'GymCore Unidade 3', 'contacto3@gymcore.co.mz', 'ativo', '2026-01-03'),
(4, 'GymCore Unidade 4', 'contacto4@gymcore.co.mz', 'ativo', '2026-01-04'),
(5, 'GymCore Unidade 5', 'contacto5@gymcore.co.mz', 'ativo', '2026-01-05'),
(6, 'GymCore Unidade 6', 'contacto6@gymcore.co.mz', 'ativo', '2026-01-06'),
(7, 'GymCore Unidade 7', 'contacto7@gymcore.co.mz', 'ativo', '2026-01-07'),
(8, 'GymCore Unidade 8', 'contacto8@gymcore.co.mz', 'ativo', '2026-01-08'),
(9, 'GymCore Unidade 9', 'contacto9@gymcore.co.mz', 'ativo', '2026-01-09'),
(10, 'GymCore Unidade 10', 'contacto10@gymcore.co.mz', 'ativo', '2026-01-10'),
(11, 'GymCore Unidade 11', 'contacto11@gymcore.co.mz', 'ativo', '2026-01-11'),
(12, 'GymCore Unidade 12', 'contacto12@gymcore.co.mz', 'ativo', '2026-01-12'),
(13, 'GymCore Unidade 13', 'contacto13@gymcore.co.mz', 'ativo', '2026-01-13'),
(14, 'GymCore Unidade 14', 'contacto14@gymcore.co.mz', 'ativo', '2026-01-14'),
(15, 'GymCore Unidade 15', 'contacto15@gymcore.co.mz', 'ativo', '2026-01-15'),
(16, 'GymCore Unidade 16', 'contacto16@gymcore.co.mz', 'ativo', '2026-01-16'),
(17, 'GymCore Unidade 17', 'contacto17@gymcore.co.mz', 'ativo', '2026-01-17'),
(18, 'GymCore Unidade 18', 'contacto18@gymcore.co.mz', 'ativo', '2026-01-18'),
(19, 'GymCore Unidade 19', 'contacto19@gymcore.co.mz', 'ativo', '2026-01-19'),
(20, 'GymCore Unidade 20', 'contacto20@gymcore.co.mz', 'ativo', '2026-01-20');

INSERT INTO branches (id, tenant_id, nome, cidade, telefone, estado) VALUES
(1, 1, 'Filial GymCore 1', 'Beira', '+258 84 100 0001', 'ativa'),
(2, 2, 'Filial GymCore 2', 'Maputo', '+258 84 100 0002', 'ativa'),
(3, 3, 'Filial GymCore 3', 'Nampula', '+258 84 100 0003', 'ativa'),
(4, 4, 'Filial GymCore 4', 'Chimoio', '+258 84 100 0004', 'ativa'),
(5, 5, 'Filial GymCore 5', 'Tete', '+258 84 100 0005', 'ativa'),
(6, 6, 'Filial GymCore 6', 'Beira', '+258 84 100 0006', 'ativa'),
(7, 7, 'Filial GymCore 7', 'Maputo', '+258 84 100 0007', 'ativa'),
(8, 8, 'Filial GymCore 8', 'Nampula', '+258 84 100 0008', 'ativa'),
(9, 9, 'Filial GymCore 9', 'Chimoio', '+258 84 100 0009', 'ativa'),
(10, 10, 'Filial GymCore 10', 'Tete', '+258 84 100 0010', 'ativa'),
(11, 11, 'Filial GymCore 11', 'Beira', '+258 84 100 0011', 'ativa'),
(12, 12, 'Filial GymCore 12', 'Maputo', '+258 84 100 0012', 'ativa'),
(13, 13, 'Filial GymCore 13', 'Nampula', '+258 84 100 0013', 'ativa'),
(14, 14, 'Filial GymCore 14', 'Chimoio', '+258 84 100 0014', 'ativa'),
(15, 15, 'Filial GymCore 15', 'Tete', '+258 84 100 0015', 'ativa'),
(16, 16, 'Filial GymCore 16', 'Beira', '+258 84 100 0016', 'ativa'),
(17, 17, 'Filial GymCore 17', 'Maputo', '+258 84 100 0017', 'ativa'),
(18, 18, 'Filial GymCore 18', 'Nampula', '+258 84 100 0018', 'ativa'),
(19, 19, 'Filial GymCore 19', 'Chimoio', '+258 84 100 0019', 'ativa'),
(20, 20, 'Filial GymCore 20', 'Tete', '+258 84 100 0020', 'ativa');

INSERT INTO users (id, tenant_id, branch_id, nome, email, perfil, estado) VALUES
(1, 1, 1, 'Amelia Macuacua', 'amelia.macuacua@gymcore.co.mz', 'Administrador', 'ativo'),
(2, 2, 2, 'Bento Cossa', 'bento.cossa@gymcore.co.mz', 'Recepcionista', 'ativo'),
(3, 3, 3, 'Celina Mucavele', 'celina.mucavele@gymcore.co.mz', 'Instrutor', 'ativo'),
(4, 4, 4, 'Dario Matusse', 'dario.matusse@gymcore.co.mz', 'Gestor', 'ativo'),
(5, 5, 5, 'Ernesto Bila', 'ernesto.bila@gymcore.co.mz', 'Administrador', 'ativo'),
(6, 6, 6, 'Fatima Jamal', 'fatima.jamal@gymcore.co.mz', 'Recepcionista', 'ativo'),
(7, 7, 7, 'Gabriel Nhantumbo', 'gabriel.nhantumbo@gymcore.co.mz', 'Instrutor', 'ativo'),
(8, 8, 8, 'Helena Sitoe', 'helena.sitoe@gymcore.co.mz', 'Gestor', 'ativo'),
(9, 9, 9, 'Ismael Macamo', 'ismael.macamo@gymcore.co.mz', 'Administrador', 'ativo'),
(10, 10, 10, 'Joana Chivambo', 'joana.chivambo@gymcore.co.mz', 'Recepcionista', 'ativo'),
(11, 11, 11, 'Kito Manjate', 'kito.manjate@gymcore.co.mz', 'Instrutor', 'ativo'),
(12, 12, 12, 'Lidia Mbanze', 'lidia.mbanze@gymcore.co.mz', 'Gestor', 'ativo'),
(13, 13, 13, 'Mario Chongo', 'mario.chongo@gymcore.co.mz', 'Administrador', 'ativo'),
(14, 14, 14, 'Nadia Tembe', 'nadia.tembe@gymcore.co.mz', 'Recepcionista', 'ativo'),
(15, 15, 15, 'Osvaldo Muianga', 'osvaldo.muianga@gymcore.co.mz', 'Instrutor', 'ativo'),
(16, 16, 16, 'Paula Zandamela', 'paula.zandamela@gymcore.co.mz', 'Gestor', 'ativo'),
(17, 17, 17, 'Quirino Langa', 'quirino.langa@gymcore.co.mz', 'Administrador', 'ativo'),
(18, 18, 18, 'Rosa Mabunda', 'rosa.mabunda@gymcore.co.mz', 'Recepcionista', 'ativo'),
(19, 19, 19, 'Samuel Cumbane', 'samuel.cumbane@gymcore.co.mz', 'Instrutor', 'ativo'),
(20, 20, 20, 'Teresa Mondlane', 'teresa.mondlane@gymcore.co.mz', 'Gestor', 'ativo');

INSERT INTO members (id, tenant_id, branch_id, nome, email, telefone, data_registo, estado) VALUES
(1, 1, 1, 'Amelia Macuacua', 'membro01@exemplo.co.mz', '+258 86 200 0001', '2026-02-01', 'ativo'),
(2, 2, 2, 'Bento Cossa', 'membro02@exemplo.co.mz', '+258 86 200 0002', '2026-02-02', 'ativo'),
(3, 3, 3, 'Celina Mucavele', 'membro03@exemplo.co.mz', '+258 86 200 0003', '2026-02-03', 'ativo'),
(4, 4, 4, 'Dario Matusse', 'membro04@exemplo.co.mz', '+258 86 200 0004', '2026-02-04', 'suspenso'),
(5, 5, 5, 'Ernesto Bila', 'membro05@exemplo.co.mz', '+258 86 200 0005', '2026-02-05', 'ativo'),
(6, 6, 6, 'Fatima Jamal', 'membro06@exemplo.co.mz', '+258 86 200 0006', '2026-02-06', 'ativo'),
(7, 7, 7, 'Gabriel Nhantumbo', 'membro07@exemplo.co.mz', '+258 86 200 0007', '2026-02-07', 'ativo'),
(8, 8, 8, 'Helena Sitoe', 'membro08@exemplo.co.mz', '+258 86 200 0008', '2026-02-08', 'suspenso'),
(9, 9, 9, 'Ismael Macamo', 'membro09@exemplo.co.mz', '+258 86 200 0009', '2026-02-09', 'ativo'),
(10, 10, 10, 'Joana Chivambo', 'membro10@exemplo.co.mz', '+258 86 200 0010', '2026-02-10', 'ativo'),
(11, 11, 11, 'Kito Manjate', 'membro11@exemplo.co.mz', '+258 86 200 0011', '2026-02-11', 'ativo'),
(12, 12, 12, 'Lidia Mbanze', 'membro12@exemplo.co.mz', '+258 86 200 0012', '2026-02-12', 'suspenso'),
(13, 13, 13, 'Mario Chongo', 'membro13@exemplo.co.mz', '+258 86 200 0013', '2026-02-13', 'ativo'),
(14, 14, 14, 'Nadia Tembe', 'membro14@exemplo.co.mz', '+258 86 200 0014', '2026-02-14', 'ativo'),
(15, 15, 15, 'Osvaldo Muianga', 'membro15@exemplo.co.mz', '+258 86 200 0015', '2026-02-15', 'ativo'),
(16, 16, 16, 'Paula Zandamela', 'membro16@exemplo.co.mz', '+258 86 200 0016', '2026-02-16', 'suspenso'),
(17, 17, 17, 'Quirino Langa', 'membro17@exemplo.co.mz', '+258 86 200 0017', '2026-02-17', 'ativo'),
(18, 18, 18, 'Rosa Mabunda', 'membro18@exemplo.co.mz', '+258 86 200 0018', '2026-02-18', 'ativo'),
(19, 19, 19, 'Samuel Cumbane', 'membro19@exemplo.co.mz', '+258 86 200 0019', '2026-02-19', 'ativo'),
(20, 20, 20, 'Teresa Mondlane', 'membro20@exemplo.co.mz', '+258 86 200 0020', '2026-02-20', 'suspenso');

INSERT INTO plans (id, tenant_id, nome, duracao_dias, preco, estado) VALUES
(1, 1, 'Mensal', 30, 1500, 'ativo'),
(2, 2, 'Trimestral', 90, 4000, 'ativo'),
(3, 3, 'Semestral', 180, 7500, 'ativo'),
(4, 4, 'Anual', 365, 14000, 'ativo'),
(5, 5, 'Mensal', 30, 1500, 'ativo'),
(6, 6, 'Trimestral', 90, 4000, 'ativo'),
(7, 7, 'Semestral', 180, 7500, 'ativo'),
(8, 8, 'Anual', 365, 14000, 'ativo'),
(9, 9, 'Mensal', 30, 1500, 'ativo'),
(10, 10, 'Trimestral', 90, 4000, 'ativo'),
(11, 11, 'Semestral', 180, 7500, 'ativo'),
(12, 12, 'Anual', 365, 14000, 'ativo'),
(13, 13, 'Mensal', 30, 1500, 'ativo'),
(14, 14, 'Trimestral', 90, 4000, 'ativo'),
(15, 15, 'Semestral', 180, 7500, 'ativo'),
(16, 16, 'Anual', 365, 14000, 'ativo'),
(17, 17, 'Mensal', 30, 1500, 'ativo'),
(18, 18, 'Trimestral', 90, 4000, 'ativo'),
(19, 19, 'Semestral', 180, 7500, 'ativo'),
(20, 20, 'Anual', 365, 14000, 'ativo');

INSERT INTO contracts (id, tenant_id, member_id, plan_id, branch_id, data_inicio, data_fim, estado) VALUES
(1, 1, 1, 1, 1, '2026-03-01', '2027-03-01', 'ativo'),
(2, 2, 2, 2, 2, '2026-03-02', '2027-03-02', 'ativo'),
(3, 3, 3, 3, 3, '2026-03-03', '2027-03-03', 'expirado'),
(4, 4, 4, 4, 4, '2026-03-04', '2027-03-04', 'ativo'),
(5, 5, 5, 5, 5, '2026-03-05', '2027-03-05', 'ativo'),
(6, 6, 6, 6, 6, '2026-03-06', '2027-03-06', 'ativo'),
(7, 7, 7, 7, 7, '2026-03-07', '2027-03-07', 'expirado'),
(8, 8, 8, 8, 8, '2026-03-08', '2027-03-08', 'ativo'),
(9, 9, 9, 9, 9, '2026-03-09', '2027-03-09', 'ativo'),
(10, 10, 10, 10, 10, '2026-03-10', '2027-03-10', 'ativo'),
(11, 11, 11, 11, 11, '2026-03-11', '2027-03-11', 'expirado'),
(12, 12, 12, 12, 12, '2026-03-12', '2027-03-12', 'ativo'),
(13, 13, 13, 13, 13, '2026-03-13', '2027-03-13', 'ativo'),
(14, 14, 14, 14, 14, '2026-03-14', '2027-03-14', 'ativo'),
(15, 15, 15, 15, 15, '2026-03-15', '2027-03-15', 'expirado'),
(16, 16, 16, 16, 16, '2026-03-16', '2027-03-16', 'ativo'),
(17, 17, 17, 17, 17, '2026-03-17', '2027-03-17', 'ativo'),
(18, 18, 18, 18, 18, '2026-03-18', '2027-03-18', 'ativo'),
(19, 19, 19, 19, 19, '2026-03-19', '2027-03-19', 'expirado'),
(20, 20, 20, 20, 20, '2026-03-20', '2027-03-20', 'ativo');

INSERT INTO payments (id, tenant_id, member_id, branch_id, valor, data_pagamento, metodo, estado) VALUES
(1, 1, 1, 1, 1500, '2026-04-01', 'Numerario', 'pago'),
(2, 2, 2, 2, 4000, '2026-04-02', 'M-Pesa', 'pago'),
(3, 3, 3, 3, 7500, '2026-04-03', 'E-Mola', 'pago'),
(4, 4, 4, 4, 14000, '2026-04-04', 'Transferencia', 'pendente'),
(5, 5, 5, 5, 1500, '2026-04-05', 'POS', 'pago'),
(6, 6, 6, 6, 4000, '2026-04-06', 'Numerario', 'pago'),
(7, 7, 7, 7, 7500, '2026-04-07', 'M-Pesa', 'pago'),
(8, 8, 8, 8, 14000, '2026-04-08', 'E-Mola', 'pendente'),
(9, 9, 9, 9, 1500, '2026-04-09', 'Transferencia', 'pago'),
(10, 10, 10, 10, 4000, '2026-04-10', 'POS', 'pago'),
(11, 11, 11, 11, 7500, '2026-04-11', 'Numerario', 'pago'),
(12, 12, 12, 12, 14000, '2026-04-12', 'M-Pesa', 'pendente'),
(13, 13, 13, 13, 1500, '2026-04-13', 'E-Mola', 'pago'),
(14, 14, 14, 14, 4000, '2026-04-14', 'Transferencia', 'pago'),
(15, 15, 15, 15, 7500, '2026-04-15', 'POS', 'pago'),
(16, 16, 16, 16, 14000, '2026-04-16', 'Numerario', 'pendente'),
(17, 17, 17, 17, 1500, '2026-04-17', 'M-Pesa', 'pago'),
(18, 18, 18, 18, 4000, '2026-04-18', 'E-Mola', 'pago'),
(19, 19, 19, 19, 7500, '2026-04-19', 'Transferencia', 'pago'),
(20, 20, 20, 20, 14000, '2026-04-20', 'POS', 'pendente');

INSERT INTO class_types (id, tenant_id, nome, capacidade, duracao_minutos, estado) VALUES
(1, 1, 'Musculacao funcional', 20, 60, 'ativo'),
(2, 2, 'Spinning', 18, 45, 'ativo'),
(3, 3, 'Zumba', 25, 50, 'ativo'),
(4, 4, 'Yoga', 15, 60, 'ativo'),
(5, 5, 'Pilates', 16, 50, 'ativo'),
(6, 6, 'Musculacao funcional', 20, 60, 'ativo'),
(7, 7, 'Spinning', 18, 45, 'ativo'),
(8, 8, 'Zumba', 25, 50, 'ativo'),
(9, 9, 'Yoga', 15, 60, 'ativo'),
(10, 10, 'Pilates', 16, 50, 'ativo'),
(11, 11, 'Musculacao funcional', 20, 60, 'ativo'),
(12, 12, 'Spinning', 18, 45, 'ativo'),
(13, 13, 'Zumba', 25, 50, 'ativo'),
(14, 14, 'Yoga', 15, 60, 'ativo'),
(15, 15, 'Pilates', 16, 50, 'ativo'),
(16, 16, 'Musculacao funcional', 20, 60, 'ativo'),
(17, 17, 'Spinning', 18, 45, 'ativo'),
(18, 18, 'Zumba', 25, 50, 'ativo'),
(19, 19, 'Yoga', 15, 60, 'ativo'),
(20, 20, 'Pilates', 16, 50, 'ativo');

INSERT INTO class_sessions (id, tenant_id, class_type_id, branch_id, instructor_user_id, data_aula, hora_inicio, vagas_disponiveis, estado) VALUES
(1, 1, 1, 1, 1, '2026-11-01', '07:00:00', 11, 'agendada'),
(2, 2, 2, 2, 2, '2026-11-02', '08:00:00', 12, 'realizada'),
(3, 3, 3, 3, 3, '2026-11-03', '09:00:00', 13, 'agendada'),
(4, 4, 4, 4, 4, '2026-11-04', '10:00:00', 14, 'cancelada'),
(5, 5, 5, 5, 5, '2026-11-05', '11:00:00', 15, 'agendada'),
(6, 6, 6, 6, 6, '2026-11-06', '12:00:00', 16, 'realizada'),
(7, 7, 7, 7, 7, '2026-11-07', '13:00:00', 17, 'agendada'),
(8, 8, 8, 8, 8, '2026-11-08', '14:00:00', 18, 'cancelada'),
(9, 9, 9, 9, 9, '2026-11-09', '15:00:00', 19, 'agendada'),
(10, 10, 10, 10, 10, '2026-11-10', '16:00:00', 10, 'realizada'),
(11, 11, 11, 11, 11, '2026-11-11', '17:00:00', 11, 'agendada'),
(12, 12, 12, 12, 12, '2026-11-12', '06:00:00', 12, 'cancelada'),
(13, 13, 13, 13, 13, '2026-11-13', '07:00:00', 13, 'agendada'),
(14, 14, 14, 14, 14, '2026-11-14', '08:00:00', 14, 'realizada'),
(15, 15, 15, 15, 15, '2026-11-15', '09:00:00', 15, 'agendada'),
(16, 16, 16, 16, 16, '2026-11-16', '10:00:00', 16, 'cancelada'),
(17, 17, 17, 17, 17, '2026-11-17', '11:00:00', 17, 'agendada'),
(18, 18, 18, 18, 18, '2026-11-18', '12:00:00', 18, 'realizada'),
(19, 19, 19, 19, 19, '2026-11-19', '13:00:00', 19, 'agendada'),
(20, 20, 20, 20, 20, '2026-11-20', '14:00:00', 10, 'cancelada');

INSERT INTO bookings (id, tenant_id, member_id, session_id, data_reserva, estado) VALUES
(1, 1, 1, 1, '2026-10-01', 'confirmada'),
(2, 2, 2, 2, '2026-10-02', 'presente'),
(3, 3, 3, 3, '2026-10-03', 'confirmada'),
(4, 4, 4, 4, '2026-10-04', 'falta'),
(5, 5, 5, 5, '2026-10-05', 'confirmada'),
(6, 6, 6, 6, '2026-10-06', 'presente'),
(7, 7, 7, 7, '2026-10-07', 'confirmada'),
(8, 8, 8, 8, '2026-10-08', 'falta'),
(9, 9, 9, 9, '2026-10-09', 'confirmada'),
(10, 10, 10, 10, '2026-10-10', 'presente'),
(11, 11, 11, 11, '2026-10-11', 'confirmada'),
(12, 12, 12, 12, '2026-10-12', 'falta'),
(13, 13, 13, 13, '2026-10-13', 'confirmada'),
(14, 14, 14, 14, '2026-10-14', 'presente'),
(15, 15, 15, 15, '2026-10-15', 'confirmada'),
(16, 16, 16, 16, '2026-10-16', 'falta'),
(17, 17, 17, 17, '2026-10-17', 'confirmada'),
(18, 18, 18, 18, '2026-10-18', 'presente'),
(19, 19, 19, 19, '2026-10-19', 'confirmada'),
(20, 20, 20, 20, '2026-10-20', 'falta');