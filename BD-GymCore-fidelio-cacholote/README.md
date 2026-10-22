# Trabalho II — Tecnologias de Base de Dados
## Sistema de Gestão de Ginásio — GymCore

Estudante: Fidelio Ricardo Cacholote
Curso: Licenciatura em Informática — 2.º ano  
Disciplina: Tecnologias de Base de Dados

## 1. Descrição do problema
A gestão de um ginásio envolve o controlo de unidades/filiais, utilizadores, membros, planos de adesão, contratos, pagamentos e aulas colectivas. Quando estes dados são registados de forma dispersa, torna-se difícil consultar a situação de cada membro, confirmar pagamentos, acompanhar contratos e organizar as aulas. O GymCore pretende centralizar estes processos numa base de dados relacional, permitindo registar, consultar, actualizar e eliminar informação de forma consistente. Esta versão académica utiliza conceitos e entidades da base GymCore existente, numa base separada chamada `gymcore_trabalho`, para não alterar os dados da aplicação original.

## 2. Objectivo do sistema web futuro
Desenvolver uma aplicação web para gestores e funcionários do ginásio, com autenticação e permissões, gestão de membros e filiais, planos, contratos, pagamentos, aulas e reservas, pesquisa de registos e relatórios de actividade e receitas.

## 3. Regras de negócio
1. Cada unidade organizacional (`tenant`) pode ter várias filiais.
2. Cada filial pertence a um único `tenant`.
3. Um utilizador pertence a um `tenant` e pode estar associado a uma filial.
4. Cada membro pertence a um `tenant` e está registado numa filial.
5. Cada plano pertence a um `tenant` e define duração e preço.
6. Cada contrato associa um membro a um plano e a uma filial.
7. Cada pagamento é registado para um membro e uma filial; o valor deve ser positivo.
8. Cada tipo de aula pertence a um `tenant` e define capacidade e duração.
9. Cada sessão corresponde a um tipo de aula, uma filial e um instrutor.
10. Cada reserva liga um membro a uma sessão de aula.
11. Chaves estrangeiras impedem associar registos a membros, filiais, planos, utilizadores ou sessões inexistentes.
12. O estado de membros, contratos, pagamentos, aulas e reservas deve usar os valores definidos nas tabelas.

## 4. Modelo e ficheiros
- `diagrama_er.png`: diagrama Entidade-Relacionamento simplificado.
- `modelo_relacional.md`: tabelas, chaves primárias e estrangeiras.
- `01_criacao_e_insercao.sql`: cria `gymcore_trabalho` e insere 20 registos em cada uma das 10 tabelas académicas.
- `02_manipulacao.sql`: SELECT simples, JOIN, UPDATE, DELETE e teste de integridade referencial comentado.

## 5. Como executar no XAMPP/phpMyAdmin
1. Iniciar Apache e MySQL no XAMPP.
2. Abrir `http://localhost/phpmyadmin`.
3. Abrir o separador SQL e executar todo o conteúdo de `01_criacao_e_insercao.sql`.
4. Confirmar que `gymcore_trabalho` e as 10 tabelas foram criadas.
5. Abrir um separador SQL e executar os comandos de `02_manipulacao.sql` por blocos. Para testar a FK, retirar os comentários apenas nas duas linhas do INSERT de teste e executar separadamente.


O projecto GymCore permite aplicar os fundamentos da modelação e implementação de bases de dados relacionais a um cenário de gestão de ginásio. A definição das entidades, dos atributos e dos relacionamentos, aliada à utilização de chaves primárias e estrangeiras, proporciona uma estrutura organizada para armazenar e consultar informações relacionadas.

link: https://youtu.be/PCKCP0-zqD0?si=7BaU_bVR1-CoOyVs 
