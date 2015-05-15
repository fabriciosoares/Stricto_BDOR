-- -------------------------- --
--      PROJETO CARTORIO      --
--------------------------------
--
-- DROP todos os objetos
DROP TABLE "TB_CARGO" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_SETOR" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_JORNADA" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_HISTORICO_SETOR_FUNCIONARIO" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_ATENDIMENTO" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_CLIENTE" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_DESCONTO" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_FISICA" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_FUNCIONARIO" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_JURIDICA" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_LIVRO" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_REGISTRO" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_SERVICO" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_SERVICODOATENDIMENTO" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_TIPOSERVICO" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_LOGATENDIMENTO" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_LOGSERVICODOATENDIMENTO" CASCADE CONSTRAINTS PURGE;
DROP TABLE "TB_LOGREGISTRO" CASCADE CONSTRAINTS PURGE;
DROP TYPE "TP_SETOR" FORCE;
DROP TYPE "TP_CARGO" FORCE;
DROP TYPE "TP_ATENDIMENTO" FORCE;
DROP TYPE "TP_CLIENTE" FORCE;
DROP TYPE "TP_DESCONTO" FORCE;
DROP TYPE "TP_ENDERECO" FORCE;
DROP TYPE "TP_FISICA" FORCE;
DROP TYPE "TP_TELEFONE" FORCE;
DROP TYPE "ARRAY_TELEFONE" FORCE;
DROP TYPE "TP_FUNCIONARIO" FORCE;
DROP TYPE "TP_GRATIFICACAO" FORCE;
DROP TYPE "TP_JURIDICA" FORCE;
DROP TYPE "TP_LIVRO" FORCE;
DROP TYPE "TP_PESSOA" FORCE;
DROP TYPE "TP_REGISTRO" FORCE;
DROP TYPE "TP_SERVICO" FORCE;
DROP TYPE "TP_SERVICODOATENDIMENTO" FORCE;
DROP TYPE "TP_TIPOSERVICO" FORCE;
DROP TYPE "TP_TUPLAATENDIMENTO" FORCE;
DROP TYPE "TP_TUPLASERVICODOATENDIMENTO" FORCE;
DROP TYPE "TP_TUPLAREGISTRO" FORCE;
DROP TYPE "NESTED_GRATIFICACAO" FORCE;
DROP TYPE "TP_HISTORICO_SETOR_FUNCIONARIO" FORCE;
DROP TYPE "TP_JORNADA" FORCE;
DROP SEQUENCE "SEQ_PESSOA";
DROP SEQUENCE "SEQ_CARGO";
DROP SEQUENCE "SEQ_SETOR";
DROP SEQUENCE "SEQ_JORNADA";
DROP SEQUENCE "SEQ_LIVRO";
DROP SEQUENCE "SEQ_TIPOSERVICO";
DROP SEQUENCE "SEQ_SERVICO";
DROP SEQUENCE "SEQ_DESCONTO";
DROP SEQUENCE "SEQ_REGISTRO";
DROP SEQUENCE "SEQ_ATENDIMENTO";
DROP SEQUENCE "SEQ_SERVICODOATENDIMENTO";
DROP FUNCTION "VALIDA_CNPJ";
DROP FUNCTION "VALIDA_CPF";
DROP DIRECTORY IMAGE_FILES;
DROP PROCEDURE "INSERIRPFCOMFOTO";
DROP SEQUENCE "SEQ_LOGSERVICODOATENDIMENTO";
DROP SEQUENCE "SEQ_LOGATENDIMENTO";
DROP SEQUENCE "SEQ_LOGREGISTRO";
DROP PACKAGE TRIGGER_API_LOGSERVATEND;
-- CREATE SEQUENCE
CREATE SEQUENCE SEQ_LOGSERVICODOATENDIMENTO INCREMENT BY 1 START WITH 1; 
CREATE SEQUENCE SEQ_LOGATENDIMENTO INCREMENT BY 1 START WITH 1; 
CREATE SEQUENCE SEQ_PESSOA INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE "SEQ_CARGO" INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE "SEQ_JORNADA" INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE "SEQ_SETOR" INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE "SEQ_LIVRO" INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE "SEQ_TIPOSERVICO" INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE "SEQ_SERVICO" INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE "SEQ_DESCONTO" INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE "SEQ_REGISTRO" INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE "SEQ_ATENDIMENTO" INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE "SEQ_SERVICODOATENDIMENTO" INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE "SEQ_LOGREGISTRO" INCREMENT BY 1 START WITH 1;
-- CREATE DIRECTORY
CREATE OR REPLACE DIRECTORY IMAGE_FILES AS 'c:\cartorio\pictures';
-- CREATE OBJECT
CREATE OR REPLACE TYPE TP_ENDERECO AS OBJECT(
	LOGRADOURO VARCHAR2(50),
	NUMERO NUMBER(5),
	BAIRRO VARCHAR2(20),
	CIDADE VARCHAR2(20),
	UF CHAR(2),
	CEP VARCHAR2(9)
);
CREATE OR REPLACE TYPE TP_TELEFONE AS OBJECT(
	TIPO VARCHAR2(20),
	DDD NUMBER(2),
	NUMERO NUMBER(8),
	--
	MEMBER FUNCTION toString RETURN VARCHAR2,
	MEMBER FUNCTION getTelefone RETURN VARCHAR2
);
CREATE OR REPLACE TYPE ARRAY_TELEFONE AS VARRAY(3) OF TP_TELEFONE;
CREATE OR REPLACE TYPE TP_PESSOA AS OBJECT(
	COD NUMBER,
	NOME VARCHAR2(50),
	TELEFONES ARRAY_TELEFONE,
	ENDERECO TP_ENDERECO,
	--
	MEMBER FUNCTION getEndereco RETURN VARCHAR2,
	MEMBER FUNCTION getFones RETURN VARCHAR2, 
	MEMBER FUNCTION getInfo RETURN VARCHAR2,
	MAP MEMBER FUNCTION getCod RETURN NUMBER,
	STATIC FUNCTION compare(obj1 TP_PESSOA, obj2 TP_PESSOA) RETURN BOOLEAN
)NOT FINAL NOT INSTANTIABLE;
CREATE OR REPLACE TYPE TP_FISICA UNDER TP_PESSOA(
	CPF VARCHAR2(11),
	SEXO CHAR(1),
	FOTO BLOB,
	--
	OVERRIDING MEMBER FUNCTION getInfo RETURN VARCHAR2,
	STATIC FUNCTION compare(obj1 TP_FISICA, obj2 TP_FISICA) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_FISICA(CPF IN VARCHAR2, SEXO IN CHAR, NOME IN VARCHAR2, ENDLOGRADOURO IN ENDERECO.LOGRADOURO%TYPE, ENDNUMERO IN ENDERECO.NUMERO%TYPE, ENDBAIRRO IN ENDERECO.BAIRRO%TYPE, ENDCIDADE IN ENDERECO.CIDADE%TYPE, ENDUF IN ENDERECO.UF%TYPE, ENDCEP IN ENDERECO.CEP%TYPE) RETURN SELF AS RESULT, 
	CONSTRUCTOR FUNCTION TP_FISICA(CPF IN VARCHAR2, SEXO IN CHAR, NOME IN VARCHAR2, ENDERECO IN ENDERECO%TYPE, FONES IN ARRAY_TELEFONE) RETURN SELF AS RESULT 
);
CREATE OR REPLACE TYPE TP_JURIDICA UNDER TP_PESSOA(
	CNPJ VARCHAR2(14),
	RAZAOSOCIAL VARCHAR2(50),
	--
	OVERRIDING MEMBER FUNCTION getInfo RETURN VARCHAR2,
	STATIC FUNCTION compare(obj1 TP_JURIDICA, obj2 TP_JURIDICA) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_JURIDICA(CNPJ IN VARCHAR2, RAZAOSOCIAL IN VARCHAR2, NOME IN VARCHAR2, ENDLOGRADOURO IN ENDERECO.LOGRADOURO%TYPE, ENDNUMERO IN ENDERECO.NUMERO%TYPE, ENDBAIRRO IN ENDERECO.BAIRRO%TYPE, ENDCIDADE IN ENDERECO.CIDADE%TYPE, ENDUF IN ENDERECO.UF%TYPE, ENDCEP IN ENDERECO.CEP%TYPE) RETURN SELF AS RESULT, 
	CONSTRUCTOR FUNCTION TP_JURIDICA(CNPJ IN VARCHAR2, RAZAOSOCIAL IN VARCHAR2, NOME IN VARCHAR2, ENDERECO IN ENDERECO%TYPE,  FONES IN ARRAY_TELEFONE) RETURN SELF AS RESULT 
);
CREATE OR REPLACE TYPE TP_CLIENTE AS OBJECT(
	DATAREGISTRO DATE,
	COD NUMBER,
	RENDA NUMBER(8,2),
	--
	REF_CLIENTE REF TP_PESSOA,
	MEMBER FUNCTION eBaixaRenda RETURN VARCHAR2,
	MEMBER FUNCTION getRenda RETURN VARCHAR2,
	MEMBER FUNCTION getInfo RETURN VARCHAR2,
	ORDER MEMBER FUNCTION equals(obj TP_CLIENTE) RETURN NUMBER,
	STATIC FUNCTION compare(obj1 TP_CLIENTE, obj2 TP_CLIENTE) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_CLIENTE(CPF_CNPJ IN VARCHAR2) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_CLIENTE(CPF IN VARCHAR2, RENDA IN NUMBER) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_CARGO AS OBJECT(
	DESCRICAO VARCHAR2(250),
	COD NUMBER,
	--
	MEMBER FUNCTION getInfo RETURN VARCHAR2,
	ORDER MEMBER FUNCTION equals(obj TP_CARGO) RETURN NUMBER,
	STATIC FUNCTION compare(obj1 TP_CARGO, obj2 TP_CARGO) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_CARGO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_SETOR AS OBJECT(
	DESCRICAO VARCHAR2(250),
	COD NUMBER,
	--
	MEMBER FUNCTION getInfo RETURN VARCHAR2,
	ORDER MEMBER FUNCTION equals(obj TP_SETOR) RETURN NUMBER,
	STATIC FUNCTION compare(obj1 TP_SETOR, obj2 TP_SETOR) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_SETOR(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_JORNADA AS OBJECT(
	DESCRICAO VARCHAR2(250),
	HORAINICIO INTERVAL DAY(0) TO SECOND,
	HORAFIM INTERVAL DAY(0) TO SECOND,
	COD NUMBER,
	--
	MEMBER FUNCTION getInfo RETURN VARCHAR2,
	ORDER MEMBER FUNCTION EQUALS(obj TP_JORNADA) RETURN NUMBER,
	STATIC FUNCTION compare(obj1 TP_JORNADA, obj2 TP_JORNADA) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_JORNADA(descricao IN VARCHAR2, horainicio IN INTERVAL DAY TO SECOND, horafim IN INTERVAL DAY TO SECOND) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_GRATIFICACAO AS OBJECT(
	PERIODO DATE,
	VALOR NUMBER(8,2),
	--
	MEMBER FUNCTION getInfo RETURN VARCHAR2,    
	CONSTRUCTOR FUNCTION TP_GRATIFICACAO(PERIODO IN DATE, VALOR IN NUMBER) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE NESTED_GRATIFICACAO AS TABLE OF TP_GRATIFICACAO;
CREATE OR REPLACE TYPE TP_FUNCIONARIO AS OBJECT(
	DATAadmissao DATE,
	MATRICULA NUMBER,
	SENHA VARCHAR2(15),
	SALARIO NUMBER(8,2),  
	STATUS CHAR(1),  
	REF_PESSOAFISICA REF TP_FISICA,
	REF_CARGO REF TP_CARGO,
	REF_SUPERVISOR REF TP_FUNCIONARIO,
	GRATIFICACOES NESTED_GRATIFICACAO,
	--
	MEMBER FUNCTION getSumAllGratificacoes RETURN NUMBER,
	MEMBER FUNCTION getTotGratificacoesByAno(ano IN INTEGER) RETURN NUMBER,
	MEMBER FUNCTION getTotGratificacoesByPeriodo(dataIni IN DATE, dataFim IN DATE) RETURN NUMBER,
	MEMBER FUNCTION getTotGratificacoesByMesAno(mes IN INTEGER,ano IN INTEGER) RETURN NUMBER,
	MEMBER FUNCTION getCargo RETURN VARCHAR2,
	MEMBER FUNCTION getStatus RETURN VARCHAR2,
	MEMBER FUNCTION getInfo RETURN VARCHAR2,
	MEMBER FUNCTION getInfoResumida RETURN VARCHAR2, 
	MEMBER FUNCTION getInfoSupervisor RETURN VARCHAR2,
	MEMBER FUNCTION possuiSupervisor RETURN BOOLEAN,
	MEMBER FUNCTION getFuncioariosSupervisionados RETURN VARCHAR2,
	MAP MEMBER FUNCTION getMatricula RETURN NUMBER,
	STATIC FUNCTION compare(obj1 TP_FUNCIONARIO, obj2 TP_FUNCIONARIO) RETURN BOOLEAN  
);
CREATE OR REPLACE TYPE TP_HISTORICO_SETOR_FUNCIONARIO AS OBJECT(
	dataentrada TIMESTAMP,
	REF_SETOR REF TP_SETOR,
	REF_FUNCIONARIO REF TP_FUNCIONARIO,
	REF_JORNADA REF TP_JORNADA,
	--
	STATIC FUNCTION getHistoricoFuncionario(matricula IN NUMBER) RETURN VARCHAR2,
	STATIC FUNCTION getSetorRecenteFuncionario(P_matricula IN NUMBER) RETURN VARCHAR2,
	STATIC FUNCTION getFuncionariosDoSetor(descSetor IN VARCHAR2) RETURN VARCHAR2,
	ORDER MEMBER FUNCTION EQUALS(obj TP_HISTORICO_SETOR_FUNCIONARIO) RETURN NUMBER,  
	STATIC FUNCTION compare(obj1 TP_HISTORICO_SETOR_FUNCIONARIO, obj2 TP_HISTORICO_SETOR_FUNCIONARIO) RETURN BOOLEAN,    
	CONSTRUCTOR FUNCTION TP_HISTORICO_SETOR_FUNCIONARIO(matricula IN NUMBER, descSetor IN VARCHAR2, descjornada IN VARCHAR2) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_HISTORICO_SETOR_FUNCIONARIO(matricula IN NUMBER, descSetor IN VARCHAR2, descJornada IN VARCHAR2, momentoEntrada IN TIMESTAMP) RETURN SELF AS RESULT   
);
CREATE OR REPLACE TYPE TP_TIPOSERVICO AS OBJECT(
	cod NUMBER,
	descricao VARCHAR2(150),
	--
	MEMBER FUNCTION getInfo RETURN VARCHAR2,
	MEMBER FUNCTION getDescricao RETURN VARCHAR2,
	ORDER MEMBER FUNCTION equals(obj TP_TIPOSERVICO) RETURN NUMBER,
	STATIC FUNCTION compare(obj1 TP_TIPOSERVICO, obj2 TP_TIPOSERVICO) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_TIPOSERVICO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_SERVICO AS OBJECT(
	cod NUMBER,
	descricao VARCHAR2(850),
	valor NUMBER(8,2),
	REF_TIPOSERVICO REF TP_TIPOSERVICO,
	--
	MEMBER FUNCTION getInfo RETURN VARCHAR2,   
	ORDER MEMBER FUNCTION EQUALS(obj TP_SERVICO) RETURN NUMBER,
	STATIC FUNCTION compare(obj1 TP_SERVICO, obj2 TP_SERVICO) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_SERVICO(DESCRICAO IN VARCHAR2, valor IN NUMBER, descTipo IN VARCHAR2) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_DESCONTO AS OBJECT(
	cod NUMBER,
	descricao VARCHAR2(150),
	valor NUMBER(8,2),
	--
	MEMBER FUNCTION getInfo RETURN VARCHAR2,
	MEMBER FUNCTION getDescricao RETURN VARCHAR2,
	ORDER MEMBER FUNCTION equals(obj TP_DESCONTO) RETURN NUMBER,
	STATIC FUNCTION compare(obj1 TP_DESCONTO, obj2 TP_DESCONTO) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_DESCONTO(DESCRICAO IN VARCHAR2,VALOR IN NUMBER) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_LIVRO AS OBJECT(
	cod NUMBER,
	descricao VARCHAR2(150),
	--
	MEMBER FUNCTION getInfo RETURN VARCHAR2,
	MEMBER FUNCTION getDescricao RETURN VARCHAR2,
	ORDER MEMBER FUNCTION EQUALS(obj TP_LIVRO) RETURN NUMBER,
	STATIC FUNCTION compare(obj1 TP_LIVRO, obj2 TP_LIVRO) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_LIVRO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_ATENDIMENTO AS OBJECT(
	cod NUMBER,
	dataatendimento TIMESTAMP,
	valortotal NUMBER(8,2),
	REF_ATENDENTE REF TP_FUNCIONARIO,
	REF_CLIENTE REF TP_CLIENTE,
	--
	MEMBER FUNCTION getValorTotalAtendimento RETURN NUMBER,
	MEMBER FUNCTION getInfo RETURN VARCHAR2,
	MEMBER FUNCTION getAtendente RETURN VARCHAR2,
	MAP MEMBER FUNCTION getCod RETURN NUMBER,
	STATIC FUNCTION compare(obj1 TP_ATENDIMENTO, obj2 TP_ATENDIMENTO) RETURN BOOLEAN, 
	CONSTRUCTOR FUNCTION TP_ATENDIMENTO(v_cpf_cnpjCliente IN VARCHAR2, v_cpfFuncionarioAtendente IN VARCHAR2) RETURN SELF AS RESULT,
	MEMBER FUNCTION getCliente RETURN VARCHAR2,
	CONSTRUCTOR FUNCTION TP_ATENDIMENTO(v_cpf_cnpjCliente IN VARCHAR2, v_cpfFuncionarioAtendente IN VARCHAR2, v_dataAtendimento IN TIMESTAMP) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_ATENDIMENTO(cod IN NUMBER, dataAtendimento IN TIMESTAMP, valorTotal IN NUMBER, ref_Atendente IN REF TP_FUNCIONARIO, ref_Cliente IN REF TP_CLIENTE) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_SERVICODOATENDIMENTO AS OBJECT(
	coditem NUMBER,
	datahorarealizacao TIMESTAMP,
	observacao VARCHAR2(200),
	quantidade INTEGER,  
	valorservicorealizado NUMBER(8,2),
  	REF_ATENDIMENTO REF TP_ATENDIMENTO,
	REF_SERVICO REF TP_SERVICO,
	REF_RESPONSAVEL REF TP_FUNCIONARIO,
	REF_DESCONTO REF TP_DESCONTO,
	--
	CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(v_codAtendimento IN NUMBER, v_descServico IN VARCHAR2, v_cpfFuncResp IN VARCHAR2, v_obs IN VARCHAR2, v_qtd IN INTEGER, v_descDesconto IN VARCHAR2) RETURN SELF AS RESULT
	CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(v_codAtendimento IN NUMBER, v_descServico IN VARCHAR2, v_cpfFuncResp IN VARCHAR2, v_obs IN VARCHAR2, v_qtd IN INTEGER, v_valServAtend IN NUMBER, v_descDesconto IN VARCHAR2) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(v_codAtendimento IN NUMBER, v_descServico IN VARCHAR2, v_cpfFuncResp IN VARCHAR2, v_obs IN VARCHAR2, v_qtd IN INTEGER, v_descDesconto IN VARCHAR2, v_datahorarealizacao IN TIMESTAMP) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(CODITEM IN NUMBER, REF_ATENDIMENTO IN REF TP_ATENDIMENTO, REF_SERVICO IN REF TP_SERVICO, REF_RESPONSAVEL IN REF TP_FUNCIONARIO, DATAHORAREALIZACAO IN TIMESTAMP, observacao IN VARCHAR2, quantidade IN INTEGER, valorservicorealizado IN NUMBER, ref_desconto IN REF tp_desconto) RETURN SELF AS RESULT, 
	MEMBER FUNCTION getValorTotalAtendimento RETURN NUMBER,
	MEMBER FUNCTION getInfo RETURN VARCHAR2,
	MEMBER FUNCTION getDescricaoServicoAtendido RETURN VARCHAR2,
	MEMBER FUNCTION getResponsavel RETURN VARCHAR2,
	MEMBER FUNCTION getClienteAtendido RETURN VARCHAR2,
	MAP MEMBER FUNCTION getCodServicoAtendido RETURN NUMBER,
	STATIC FUNCTION compare(obj1 TP_SERVICODOATENDIMENTO, obj2 TP_SERVICODOATENDIMENTO) RETURN BOOLEAN  
);
CREATE OR REPLACE TYPE TP_REGISTRO AS OBJECT(
	numregistro NUMBER,
	folha INTEGER,
	REF_LIVRO REF TP_LIVRO,
	REF_SERVICODOATENDIMENTO REF TP_SERVICODOATENDIMENTO,
	--
	STATIC FUNCTION fazReferenciaAAlgumRegistro(refServicoDoAtendimento IN ref tp_servicodoatendimento) RETURN BOOLEAN,
	MEMBER PROCEDURE setServicoDoAtendimento(refServicoDoAtendimento IN ref tp_servicodoatendimento),
	MEMBER PROCEDURE setLivro(refLivro IN ref tp_livro),
	MEMBER FUNCTION getServicoDoAtendimento RETURN VARCHAR2,
	MEMBER FUNCTION getLivro RETURN VARCHAR2,
	MEMBER FUNCTION getInfo RETURN VARCHAR2,
	STATIC FUNCTION compare(obj1 TP_REGISTRO, obj2 TP_REGISTRO) RETURN BOOLEAN,   
	MAP MEMBER FUNCTION getCodRegistro RETURN NUMBER,
	CONSTRUCTOR FUNCTION TP_REGISTRO(v_folha IN INTEGER, v_refLivro IN ref tp_livro, v_reServicoAtendido IN REF tp_servicodoatendimento) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_REGISTRO(NUMREGISTRO IN INTEGER, FOLHA IN INTEGER, REF_LIVRO IN ref tp_livro, REF_SERVICODOATENDIMENTO IN REF tp_servicodoatendimento) RETURN SELF AS RESULT   
);
CREATE OR REPLACE TYPE tp_tuplaAtendimento AS OBJECT(
	codAtendimento NUMBER,
	codCliente NUMBER,
	codAtendente NUMBER,
	valorTotal NUMBER(8,2), 
	dataAtendimento TIMESTAMP
);
CREATE OR REPLACE TYPE tp_tuplaServicoDoAtendimento AS OBJECT(
	codItem NUMBER,
	codAtendimento NUMBER,
	codDesconto NUMBER,
	codResponsavel NUMBER,
	dataHoraRealizacao TIMESTAMP, 
	codServico NUMBER,
	observacao VARCHAR2(1250),
	valorDoServicoRealizado NUMBER(8,2), 
	quantidade INTEGER 
);
CREATE OR REPLACE TYPE tp_tuplaREGISTRO AS OBJECT(
	numrgistro NUMBER,
	folha INTEGER,
	codLivro NUMBER,
	codServicoDoAtendimento NUMBER
);
-- CREATE TABLE
CREATE TABLE TB_FISICA OF TP_FISICA (
	cod PRIMARY KEY,
	cpf NOT NULL,
	sexo NOT NULL CHECK(SEXO IN('M','F')),
	endereco NOT NULL,
	nome NOT NULL,
	foto NULL,
	telefones NULL,     
	CONSTRAINT TB_FISICA_CPFUK UNIQUE(CPF)
 );
CREATE TABLE TB_JURIDICA OF TP_JURIDICA (
	cod PRIMARY KEY,
	cnpj NOT NULL,
	razaosocial NOT NULL,
	endereco NOT NULL,
	nome NOT NULL,     
	CONSTRAINT TB_JURIDICA_CNPJUK UNIQUE(cnpj) ,
	CONSTRAINT TB_JURIDICA_RZSOCUK UNIQUE(razaosocial)
);
CREATE TABLE TB_CLIENTE OF TP_CLIENTE (
	cod PRIMARY KEY,
	dataregistro DEFAULT SYSDATE NOT NULL,
	renda NULL,      
	REF_CLIENTE NOT NULL    
);
CREATE TABLE TB_SETOR OF TP_SETOR (
	cod PRIMARY KEY,
	descricao NOT NULL,
    CONSTRAINT TB_SETOR_DESCRICAO_UK UNIQUE(descricao)
);

CREATE TABLE TB_JORNADA OF TP_JORNADA (
	cod PRIMARY KEY,
	descricao NOT NULL,
	horainicio NOT NULL,
	horafim NOT NULL,
	CONSTRAINT TB_JORNADA_DESCRICAO_UK UNIQUE(descricao),
	CONSTRAINT TB_JORNADA_HORARIO_UK UNIQUE(horainicio, horafim)
);
CREATE TABLE TB_CARGO OF TP_CARGO (
	cod PRIMARY KEY,
	descricao NOT NULL,
	CONSTRAINT TB_CARGO_DESCRICAO_UK UNIQUE(descricao)
);
CREATE TABLE TB_FUNCIONARIO OF TP_FUNCIONARIO (
	matricula PRIMARY KEY,
	dataadmissao DEFAULT SYSDATE NOT NULL,
	salario NOT NULL CHECK (SALARIO          >=788.00),
	STATUS DEFAULT 'A' NOT NULL CHECK(STATUS IN('A','I')), -- A-ATIVO I-INATIVO
	REF_SUPERVISOR NULL SCOPE IS TB_FUNCIONARIO,
	REF_PESSOAFISICA NOT NULL WITH ROWID REFERENCES TB_FISICA, 
	REF_CARGO NOT NULL WITH ROWID REFERENCES TB_CARGO   
) NESTED TABLE GRATIFICACOES STORE AS NSTB_GRATIFICACOES (PRIMARY KEY (NESTED_TABLE_ID, PERIODO));
CREATE TABLE TB_HISTORICO_SETOR_FUNCIONARIO OF TP_HISTORICO_SETOR_FUNCIONARIO (
	dataentrada DEFAULT SYSTIMESTAMP NOT NULL,
	REF_SETOR NOT NULL WITH ROWID REFERENCES TB_SETOR,
	REF_JORNADA NOT NULL WITH ROWID REFERENCES TB_JORNADA, 
	REF_FUNCIONARIO NOT NULL WITH ROWID REFERENCES TB_FUNCIONARIO,
	PRIMARY KEY(dataentrada)
);   
CREATE TABLE TB_TIPOSERVICO OF TP_TIPOSERVICO (
	cod PRIMARY KEY,
	descricao NOT NULL,
	CONSTRAINT TB_TIPOSERVICO_UK UNIQUE(descricao)
);
CREATE TABLE TB_SERVICO OF TP_SERVICO( 
	cod PRIMARY KEY,
	descricao NOT NULL,
	valor NOT NULL CHECK(VALOR >= 0.0),
	REF_TIPOSERVICO NOT NULL WITH ROWID REFERENCES TB_TIPOSERVICO,
	CONSTRAINT TB_SERVICO_UK UNIQUE(descricao)
);
CREATE TABLE TB_DESCONTO OF TP_DESCONTO (
	cod PRIMARY KEY,
	descricao NOT NULL,
	valor NOT NULL CHECK (VALOR >= 0.0),
	CONSTRAINT TB_DESCONTO_DESCUK UNIQUE(descricao),
	CONSTRAINT TB_DESCONTO_VALORUK UNIQUE(valor)
);
CREATE TABLE TB_LIVRO OF TP_LIVRO (
	cod PRIMARY KEY,
	descricao NOT NULL,
	CONSTRAINT TB_LIVRO_DESCRICAO_UK UNIQUE(descricao)
);
CREATE TABLE TB_ATENDIMENTO OF TP_ATENDIMENTO (
	cod PRIMARY KEY,
	dataatendimento DEFAULT SYSTIMESTAMP NOT NULL,
	valortotal DEFAULT 0.0 NOT NULL CHECK (valortotal >= 0.0),
	REF_ATENDENTE NOT NULL WITH ROWID REFERENCES TB_FUNCIONARIO, 
	REF_CLIENTE NOT NULL WITH ROWID REFERENCES TB_CLIENTE
);
CREATE TABLE TB_SERVICODOATENDIMENTO OF TP_SERVICODOATENDIMENTO (
	coditem PRIMARY KEY,
	datahorarealizacao DEFAULT SYSTIMESTAMP NOT NULL,
	observacao NULL,
	quantidade DEFAULT 1 CHECK (quantidade >= 1),
	valorservicorealizado DEFAULT 0 CHECK(valorservicorealizado >= 0),
	REF_ATENDIMENTO NOT NULL WITH ROWID REFERENCES TB_ATENDIMENTO, 
	REF_SERVICO NOT NULL WITH ROWID REFERENCES TB_SERVICO, 
	REF_RESPONSAVEL NOT NULL WITH ROWID REFERENCES TB_FUNCIONARIO,
	REF_DESCONTO NULL WITH ROWID REFERENCES TB_DESCONTO
);
CREATE TABLE TB_REGISTRO OF TP_REGISTRO (
	numregistro PRIMARY KEY,
	folha NOT NULL CHECK ((folha >= 1) AND (folha <= 200)),
    REF_LIVRO NOT NULL WITH ROWID REFERENCES TB_LIVRO, 
    REF_SERVICODOATENDIMENTO NOT NULL WITH ROWID REFERENCES TB_SERVICODOATENDIMENTO
);
CREATE TABLE tb_logAtendimento (
	codLog NUMBER NOT NULL,
	dataOperacao TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
	tipoOperacao VARCHAR2(20) NOT NULL,
	usuario_bd VARCHAR2(255) NOT NULL,
	tupla tp_tuplaAtendimento NOT NULL,
	CONSTRAINT tb_log_LogAtend_tipoOpe_chk CHECK (tipoOperacao IN ('INSER플O','REMO플O','ATUALIZA플O')),
	CONSTRAINT tb_log_LogAtend_pk PRIMARY KEY(codLog)
);
CREATE TABLE tb_logServicoDoAtendimento (
	codLog NUMBER NOT NULL,
	dataOperacao TIMESTAMP DEFAULT sysTIMESTAMP NOT NULL,
	tipoOperacao VARCHAR2(20) NOT NULL,
	usuario_bd  VARCHAR2(255) NOT NULL,
	tupla tp_tuplaServicoDoAtendimento NOT NULL,
	CONSTRAINT tb_log_LogServAtend_tpOp_chk CHECK (tipoOperacao IN ('INSER플O','REMO플O','ATUALIZA플O')),
	CONSTRAINT tb_log_LogServAtend_pk PRIMARY KEY(codLog)
);
CREATE TABLE tb_logregistro (
	codLog NUMBER NOT NULL,
	dataOperacao TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
	tipoOperacao VARCHAR2(20) NOT NULL,
	usuario_bd VARCHAR2(255) NOT NULL,
	tupla tp_tuplaregistro NOT NULL,
	CONSTRAINT tb_log_LogReg_tpOp_chk CHECK (tipoOperacao IN ('INSER플O','REMO플O','ATUALIZA플O')),
	CONSTRAINT tb_log_LogReg_pk PRIMARY KEY(codLog)
);
-- CREATE INDEX
CREATE INDEX idx_tb_atendimento_data ON tb_atendimento(dataatendimento);
CREATE INDEX idx_tb_cliente_data ON tb_cliente(dataregistro);
CREATE INDEX idx_tb_fisica_nome ON tb_fisica(nome);
CREATE INDEX idx_tb_fisica_cpf_nome ON tb_fisica(cpf,nome);
CREATE INDEX idx_tb_funcionario_status ON tb_funcionario(status);
CREATE INDEX idx_tb_funcionario_salario ON tb_funcionario(salario);
CREATE INDEX idx_tb_funcionario_dataadmissao ON tb_funcionario(dataadmissao);
CREATE INDEX idx_tb_juridica_cnpj_rzsoc ON tb_juridica(cnpj,razaosocial);
CREATE INDEX idx_tb_log_atendimento_dataop ON tb_logatendimento(dataoperacao);
CREATE INDEX idx_tb_log_atendimento_tipoop ON tb_logatendimento(tipooperacao);
CREATE INDEX idx_tb_log_atendimento_dtop ON tb_logatendimento(dataoperacao,tipooperacao);
CREATE INDEX idx_tb_log_servdoatend_dataop ON tb_logservicodoatendimento(dataoperacao);
CREATE INDEX idx_tb_log_servdoatend_tipoop ON tb_logservicodoatendimento(tipooperacao);
CREATE INDEX idx_tb_log_servdoatend_dtop ON tb_logservicodoatendimento(dataoperacao,tipooperacao);
CREATE INDEX idx_tb_registro_folha ON tb_registro(folha);
CREATE INDEX idx_tb_servico_valor ON tb_servico(valor);
CREATE INDEX idx_tb_servico_descval ON tb_servico(descricao,valor);