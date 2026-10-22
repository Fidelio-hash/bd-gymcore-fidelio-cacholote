# Modelo relacional — GymCore

Notação: **PK** = chave primária; **FK** = chave estrangeira.

1. **tenants** (`id` PK, nome, email UNIQUE, estado, criado_em)
2. **branches** (`id` PK, `tenant_id` FK → tenants.id, nome, cidade, telefone, estado)
3. **users** (`id` PK, `tenant_id` FK → tenants.id, `branch_id` FK → branches.id, nome, email UNIQUE, perfil, estado)
4. **members** (`id` PK, `tenant_id` FK → tenants.id, `branch_id` FK → branches.id, nome, email UNIQUE, telefone, data_registo, estado)
5. **plans** (`id` PK, `tenant_id` FK → tenants.id, nome, duracao_dias, preco, estado)
6. **contracts** (`id` PK, `tenant_id` FK → tenants.id, `member_id` FK → members.id, `plan_id` FK → plans.id, `branch_id` FK → branches.id, data_inicio, data_fim, estado)
7. **payments** (`id` PK, `tenant_id` FK → tenants.id, `member_id` FK → members.id, `branch_id` FK → branches.id, valor, data_pagamento, metodo, estado)
8. **class_types** (`id` PK, `tenant_id` FK → tenants.id, nome, capacidade, duracao_minutos, estado)
9. **class_sessions** (`id` PK, `tenant_id` FK → tenants.id, `class_type_id` FK → class_types.id, `branch_id` FK → branches.id, `instructor_user_id` FK → users.id, data_aula, hora_inicio, vagas_disponiveis, estado)
10. **bookings** (`id` PK, `tenant_id` FK → tenants.id, `member_id` FK → members.id, `session_id` FK → class_sessions.id, data_reserva, estado)

## Relacionamentos e cardinalidades
- tenants 1:N branches, users, members, plans, contracts, payments, class_types, class_sessions e bookings.
- branches 1:N users, members, contracts, payments e class_sessions.
- members 1:N contracts, payments e bookings.
- plans 1:N contracts.
- class_types 1:N class_sessions.
- users 1:N class_sessions como instrutores.
- class_sessions 1:N bookings.

Nesta versão, `bookings` é uma entidade associativa entre membros e sessões: cada reserva referencia exactamente um membro e uma sessão; um membro pode ter várias reservas e uma sessão pode receber várias reservas. A participação da reserva é total em ambos os relacionamentos, pois não existe reserva sem membro ou sessão. A participação dos membros e sessões é parcial, pois podem existir sem reservas.
