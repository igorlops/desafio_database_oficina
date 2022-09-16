-- drop database os_oficina;
create database os_oficina;
use os_oficina;

create table cliente(
	idCliente int auto_increment primary key,
    CNome varchar(15),
    Sobrenome varchar(15),
    Endereco varchar(45),
    Telefone char(12)
);

alter table cliente auto_increment=1;
create table veiculo(
	idVeiculo int primary key auto_increment,
    Condicao enum('Revisao','Conserto'),
	idVCliente int,
    constraint fk_v_cliente foreign key(idVCliente) references cliente(idCliente)
    );

create table oficina(
	idOficina int primary key auto_increment,
    idOVeiculo int,
    idOCliente int,
    constraint fk_o_veiculo foreign key(idOVeiculo) references veiculo(idVeiculo),
    constraint fk_o_cliente foreign key(idOCliente) references cliente(idCliente)
);

create table mecanicos(
	idMecanicos int primary key auto_increment,
    MNome varchar(30),
	Especialidade enum('Revisao','Conserto'),
    idMOficina int,
    idMVeiculo int,
    idMCliente int,
    constraint fk_m_oficina foreign key(idMOficina) references oficina(idOficina),
    constraint fk_m_veiculo foreign key(idMVeiculo) references veiculo(idVeiculo),
    constraint fk_m_cliente foreign key(idMCliente) references cliente(idCliente)
);
alter table mecanicos auto_increment=1;

create table servicos(
	idServicos int primary key auto_increment,
    idSMecanicos int,
    idSOficina int,
    idSVeiculo int,
    idSCliente int,
    constraint fk_s_mecanicos foreign key(idSMecanicos) references mecanicos(idMecanicos),
    constraint fk_s_oficina foreign key(idSOficina) references oficina(idOficina),
    constraint fk_s_veiculo foreign key(idSVeiculo) references veiculo(idVeiculo),
    constraint fk_s_cliente foreign key(idSCliente) references cliente(idCliente)
);


create table OS(
	idOS int primary key auto_increment,
    dataEmissao date,
    valor float,
    statusOS enum('Em processamento','Concluido','Cancelado') default 'Em processamento',
    dataConclusao date
);
-- drop table servicos_has_os;
create table servicos_has_os(
	idSOSservicos int auto_increment,
    idSOSOs int,
	idSOSMecanicos int,
    idSOSOficina int,
    idSOSVeiculo int,
    idSOSCliente int,
    constraint primary key(idSOSservicos,idSOSOs),
    constraint fk_sos_servicos foreign key(idSOSservicos) references servicos(idServicos),
    constraint fk_sos_os foreign key(idSOSOficina) references OS(idOS),
	constraint fk_sos_mecanicos foreign key(idSOSMecanicos) references mecanicos(idMecanicos),
    constraint fk_sos_oficina foreign key(idSOSOficina) references oficina(idOficina),
    constraint fk_sos_veiculo foreign key(idSOSVeiculo) references veiculo(idVeiculo),
    constraint fk_sos_cliente foreign key(idSOSCliente) references cliente(idCliente)
);

create table pecas(
	idPecas int primary key,
    valorPecas float
);

create table pecasUsadas(
	idPUpecas int,
    idPUos int,
    constraint primary key(idPUpecas,idPUos),
    constraint fk_pu_pecas foreign key(idPUpecas) references pecas(idPecas),
    constraint fk_pu_os foreign key(idPUos) references OS(idOS)
);

show tables;