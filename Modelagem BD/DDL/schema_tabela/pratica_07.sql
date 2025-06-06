create database pratica_07;
use pratica_07;

-- A) EXECUÇÃO DA PRÁTICA 5 (GRAÇÃO DAS TABELAS - BASE)

CREATE TABLE funcionario
(func_id int primary key auto_increment,
func_nome varchar(50) not null,
func_cpf varchar(11) unique,
func_salario decimal (4,2)  check (func_salario > 1000),
func_end varchar(252),
func_sexo char(1) check (func_sexo in('F','M')),
super_id int,
depart_id int,
foreign key(super_id) references funcionario(func_id),
foreign key(depart_id) references departamento(depart_id));

CREATE TABLE departamento
(depart_id int primary key auto_increment,
depart_nome varchar(50) not null,
depart_data_inicial date);

CREATE TABLE dependente
(dep_nome varchar(100) not null,
dep_parentesco varchar(30) not null check (dep_parentesco in('PAI', 'MÃE', 'IRMAOS', 'FILHO')),
dep_data_nasc date,
func_id int,
dep_seq  int,
foreign key(func_id) references funcionario (func_id),
primary key(func_id,dep_seq));

CREATE TABLE participa
(part_horas varchar(50),
func_id int,
pro_id int,
primary key(func_id,pro_id));

CREATE TABLE projeto
(pro_id int primary key auto_increment,
pro_titulo varchar(50) not null,
pro_descricao varchar(252),
pro_data_cad date default(current_date()),
depart_id int,
foreign key(depart_id) references departamento(depart_id));

CREATE TABLE localizacao
(local_id int primary key  auto_increment,
depart_id int,
foreign key(depart_id) references departamento(depart_id));

-- ------------------------------------/ EXERCÍCIOS /------------------------------------

-- 1) ALTERAR TABELA 'PROJETO'
-- a)
alter table projeto
add flag_status char(1) check (flag_status in(0,1));
-- b)
alter table projeto 
modify pro_titulo varchar(155) not null;
-- c)
alter table projeto
add data_cad date default (current_date); -- 'sysdate' do oracle no mysql workbench é 'current_date'
alter table projeto
rename column data_cad to data_cadastro;

-- 2) ALTERAR TABELA 'FUNCIONARIO'
-- a)
-- a.1
create table endereco
(end_cod int primary key auto_increment,
end_cidade varchar(50),
end_estado varchar(2),
end_cep varchar(10),
end_numero varchar(10));
-- a.2
alter table funcionario
drop column func_end;
-- a.3
create table funcionario_endereco 
(func_id int,
end_cod int,
primary key (func_id, end_cod),
foreign key (func_id) references funcionario(func_id),
foreign key (end_cod) references endereco(end_cod));
-- b)
alter table funcionario
drop check funcionario_chk_1;

-- 3)
-- a)
-- a.1
create table parentesco (
    par_id int primary key auto_increment,
    par_descricao varchar(30) unique not null
);
-- a.2
insert into parentesco (par_descricao)
values ('pai'), ('mãe'), ('irmaos'), ('filho');
-- a.3
alter table dependente
drop column dep_parentesco;
alter table dependente
add par_id int,
add foreign key (par_id) references parentesco(par_id);
-- b)
alter table dependente
add dep_cpf varchar(11) unique;
-- c)
alter table dependente
drop foreign key dependente_ibfk_1;  -- nome exato pode variar
alter table dependente
add constraint fk_dep_func
foreign key (func_id) references funcionario(func_id) on delete cascade;

-- 4)
-- a)
rename table participa to func_projeto;
