-- --------------------------------- --
--      PROJETO CARTORIO (1-DDL)     --
---------------------------------------
--
-- Atencao: No Eclipse abrir com (open with): "SQL File Editor" na perspectiva "Database Development"
--
-- DROP TODOS OS OBJETOS
DROP TABLE TB_CARGO CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_SETOR CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_JORNADA CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_HISTORICO_SETOR_FUNCIONARIO CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_ATENDIMENTO CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_CLIENTE CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_DESCONTO CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_FISICA CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_FUNCIONARIO CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_JURIDICA CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_LIVRO CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_REGISTRO CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_SERVICO CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_SERVICODOATENDIMENTO CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_TIPOSERVICO CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_LOGATENDIMENTO CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_LOGSERVICODOATENDIMENTO CASCADE CONSTRAINTS PURGE;
DROP TABLE TB_LOGREGISTRO CASCADE CONSTRAINTS PURGE;
DROP TYPE TP_SETOR FORCE;
DROP TYPE TP_CARGO FORCE;
DROP TYPE TP_ATENDIMENTO FORCE;
DROP TYPE TP_CLIENTE FORCE;
DROP TYPE TP_DESCONTO FORCE;
DROP TYPE TP_ENDERECO FORCE;
DROP TYPE TP_FISICA FORCE;
DROP TYPE TP_TELEFONE FORCE;
DROP TYPE TP_FUNCIONARIO FORCE;
DROP TYPE TP_GRATIFICACAO FORCE;
DROP TYPE TP_JURIDICA FORCE;
DROP TYPE TP_LIVRO FORCE;
DROP TYPE TP_PESSOA FORCE;
DROP TYPE TP_REGISTRO FORCE;
DROP TYPE TP_SERVICO FORCE;
DROP TYPE TP_SERVICODOATENDIMENTO FORCE;
DROP TYPE TP_TIPOSERVICO FORCE;
DROP TYPE TP_TUPLAATENDIMENTO FORCE;
DROP TYPE TP_TUPLASERVICODOATENDIMENTO FORCE;
DROP TYPE TP_TUPLAREGISTRO FORCE;
DROP TYPE TP_HISTORICO_SETOR_FUNCIONARIO FORCE;
DROP TYPE TP_JORNADA FORCE;
DROP TYPE ARRAY_TELEFONE FORCE;
DROP TYPE NESTED_GRATIFICACAO FORCE;
DROP SEQUENCE SEQ_PESSOA;
DROP SEQUENCE SEQ_CARGO;
DROP SEQUENCE SEQ_SETOR;
DROP SEQUENCE SEQ_JORNADA;
DROP SEQUENCE SEQ_LIVRO;
DROP SEQUENCE SEQ_TIPOSERVICO;
DROP SEQUENCE SEQ_SERVICO;
DROP SEQUENCE SEQ_DESCONTO;
DROP SEQUENCE SEQ_REGISTRO;
DROP SEQUENCE SEQ_ATENDIMENTO;
DROP SEQUENCE SEQ_SERVICODOATENDIMENTO;
DROP SEQUENCE SEQ_LOGSERVICODOATENDIMENTO;
DROP SEQUENCE SEQ_LOGATENDIMENTO;
DROP FUNCTION VALIDA_CNPJ;
DROP FUNCTION VALIDA_CPF;
DROP DIRECTORY IMAGE_FILES;
DROP PROCEDURE INSERIRPFCOMFOTO;
DROP SEQUENCE SEQ_LOGREGISTRO;
DROP PACKAGE TRIGGER_API_LOGSERVATEND;
-- CREATE SEQUENCE
CREATE SEQUENCE SEQ_LOGSERVICODOATENDIMENTO INCREMENT BY 1 START WITH 1; 
CREATE SEQUENCE SEQ_LOGATENDIMENTO INCREMENT BY 1 START WITH 1; 
CREATE SEQUENCE SEQ_PESSOA INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_CARGO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_JORNADA INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_SETOR INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_LIVRO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_TIPOSERVICO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_SERVICO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_DESCONTO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_REGISTRO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_ATENDIMENTO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_SERVICODOATENDIMENTO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_LOGREGISTRO INCREMENT BY 1 START WITH 1;
-- CREATE DIRECTORY
CREATE OR REPLACE DIRECTORY IMAGE_FILES AS 'C:\CARTORIO\PICTURES';
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
	MEMBER FUNCTION TOSTRING RETURN VARCHAR2,
	MEMBER FUNCTION GETTELEFONE RETURN VARCHAR2
);
CREATE OR REPLACE TYPE ARRAY_TELEFONE AS VARRAY(3) OF TP_TELEFONE;
CREATE OR REPLACE TYPE TP_PESSOA AS OBJECT(
	COD NUMBER,
	NOME VARCHAR2(50),
	TELEFONES ARRAY_TELEFONE,
	ENDERECO TP_ENDERECO,
	--
	MEMBER FUNCTION GETENDERECO RETURN VARCHAR2,
	MEMBER FUNCTION GETFONES RETURN VARCHAR2, 
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	MAP MEMBER FUNCTION GETCOD RETURN NUMBER,
	STATIC FUNCTION COMPARE(OBJ1 TP_PESSOA, OBJ2 TP_PESSOA) RETURN BOOLEAN
)NOT FINAL NOT INSTANTIABLE;
CREATE OR REPLACE TYPE TP_FISICA UNDER TP_PESSOA(
	CPF VARCHAR2(11),
	SEXO CHAR(1),
	FOTO BLOB,
	--
	OVERRIDING MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	STATIC FUNCTION COMPARE(OBJ1 TP_FISICA, OBJ2 TP_FISICA) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_FISICA(CPF IN VARCHAR2, SEXO IN CHAR, NOME IN VARCHAR2, ENDLOGRADOURO IN ENDERECO.LOGRADOURO%TYPE, ENDNUMERO IN ENDERECO.NUMERO%TYPE, ENDBAIRRO IN ENDERECO.BAIRRO%TYPE, ENDCIDADE IN ENDERECO.CIDADE%TYPE, ENDUF IN ENDERECO.UF%TYPE, ENDCEP IN ENDERECO.CEP%TYPE) RETURN SELF AS RESULT, 
	CONSTRUCTOR FUNCTION TP_FISICA(CPF IN VARCHAR2, SEXO IN CHAR, NOME IN VARCHAR2, ENDERECO IN ENDERECO%TYPE, FONES IN ARRAY_TELEFONE) RETURN SELF AS RESULT 
);
CREATE OR REPLACE TYPE TP_JURIDICA UNDER TP_PESSOA(
	CNPJ VARCHAR2(14),
	RAZAOSOCIAL VARCHAR2(50),
	--
	OVERRIDING MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	STATIC FUNCTION COMPARE(OBJ1 TP_JURIDICA, OBJ2 TP_JURIDICA) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_JURIDICA(CNPJ IN VARCHAR2, RAZAOSOCIAL IN VARCHAR2, NOME IN VARCHAR2, ENDLOGRADOURO IN ENDERECO.LOGRADOURO%TYPE, ENDNUMERO IN ENDERECO.NUMERO%TYPE, ENDBAIRRO IN ENDERECO.BAIRRO%TYPE, ENDCIDADE IN ENDERECO.CIDADE%TYPE, ENDUF IN ENDERECO.UF%TYPE, ENDCEP IN ENDERECO.CEP%TYPE) RETURN SELF AS RESULT, 
	CONSTRUCTOR FUNCTION TP_JURIDICA(CNPJ IN VARCHAR2, RAZAOSOCIAL IN VARCHAR2, NOME IN VARCHAR2, ENDERECO IN ENDERECO%TYPE,  FONES IN ARRAY_TELEFONE) RETURN SELF AS RESULT 
);
CREATE OR REPLACE TYPE TP_CLIENTE AS OBJECT(
	DATAREGISTRO DATE,
	COD NUMBER,
	RENDA NUMBER(8,2),
	--
	REF_CLIENTE REF TP_PESSOA,
	MEMBER FUNCTION EBAIXARENDA RETURN VARCHAR2,
	MEMBER FUNCTION GETRENDA RETURN VARCHAR2,
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_CLIENTE) RETURN NUMBER,
	STATIC FUNCTION COMPARE(OBJ1 TP_CLIENTE, OBJ2 TP_CLIENTE) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_CLIENTE(CPF_CNPJ IN VARCHAR2) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_CLIENTE(CPF IN VARCHAR2, RENDA IN NUMBER) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_CARGO AS OBJECT(
	DESCRICAO VARCHAR2(250),
	COD NUMBER,
	--
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_CARGO) RETURN NUMBER,
	STATIC FUNCTION COMPARE(OBJ1 TP_CARGO, OBJ2 TP_CARGO) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_CARGO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_SETOR AS OBJECT(
	DESCRICAO VARCHAR2(250),
	COD NUMBER,
	--
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_SETOR) RETURN NUMBER,
	STATIC FUNCTION COMPARE(OBJ1 TP_SETOR, OBJ2 TP_SETOR) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_SETOR(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_JORNADA AS OBJECT(
	DESCRICAO VARCHAR2(250),
	HORAINICIO INTERVAL DAY(0) TO SECOND,
	HORAFIM INTERVAL DAY(0) TO SECOND,
	COD NUMBER,
	--
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_JORNADA) RETURN NUMBER,
	STATIC FUNCTION COMPARE(OBJ1 TP_JORNADA, OBJ2 TP_JORNADA) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_JORNADA(DESCRICAO IN VARCHAR2, HORAINICIO IN INTERVAL DAY TO SECOND, HORAFIM IN INTERVAL DAY TO SECOND) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_GRATIFICACAO AS OBJECT(
	PERIODO DATE,
	VALOR NUMBER(8,2),
	--
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	CONSTRUCTOR FUNCTION TP_GRATIFICACAO(PERIODO IN DATE, VALOR IN NUMBER) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE NESTED_GRATIFICACAO AS TABLE OF TP_GRATIFICACAO;
CREATE OR REPLACE TYPE TP_FUNCIONARIO AS OBJECT(
	DATAADMISSAO DATE,
	MATRICULA NUMBER,
	SENHA VARCHAR2(15),
	SALARIO NUMBER(8,2),  
	STATUS CHAR(1),  
	REF_PESSOAFISICA REF TP_FISICA,
	REF_CARGO REF TP_CARGO,
	REF_SUPERVISOR REF TP_FUNCIONARIO,
	GRATIFICACOES NESTED_GRATIFICACAO,
	--
	MEMBER FUNCTION GETSUMALLGRATIFICACOES RETURN NUMBER,
	MEMBER FUNCTION GETTOTGRATIFICACOESBYANO(ANO IN INTEGER) RETURN NUMBER,
	MEMBER FUNCTION GETTOTGRATIFICACOESBYPERIODO(DATAINI IN DATE, DATAFIM IN DATE) RETURN NUMBER,
	MEMBER FUNCTION GETTOTGRATIFICACOESBYMESANO(MES IN INTEGER,ANO IN INTEGER) RETURN NUMBER,
	MEMBER FUNCTION GETCARGO RETURN VARCHAR2,
	MEMBER FUNCTION GETSTATUS RETURN VARCHAR2,
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	MEMBER FUNCTION GETINFORESUMIDA RETURN VARCHAR2, 
	MEMBER FUNCTION GETINFOSUPERVISOR RETURN VARCHAR2,
	MEMBER FUNCTION POSSUISUPERVISOR RETURN BOOLEAN,
	MEMBER FUNCTION GETFUNCIOARIOSSUPERVISIONADOS RETURN VARCHAR2,
	MAP MEMBER FUNCTION GETMATRICULA RETURN NUMBER,
	STATIC FUNCTION COMPARE(OBJ1 TP_FUNCIONARIO, OBJ2 TP_FUNCIONARIO) RETURN BOOLEAN  
);
CREATE OR REPLACE TYPE TP_HISTORICO_SETOR_FUNCIONARIO AS OBJECT(
	DATAENTRADA TIMESTAMP,
	REF_SETOR REF TP_SETOR,
	REF_FUNCIONARIO REF TP_FUNCIONARIO,
	REF_JORNADA REF TP_JORNADA,
	--
	STATIC FUNCTION GETHISTORICOFUNCIONARIO(MATRICULA IN NUMBER) RETURN VARCHAR2,
	STATIC FUNCTION GETSETORRECENTEFUNCIONARIO(P_MATRICULA IN NUMBER) RETURN VARCHAR2,
	STATIC FUNCTION GETFUNCIONARIOSDOSETOR(DESCSETOR IN VARCHAR2) RETURN VARCHAR2,
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_HISTORICO_SETOR_FUNCIONARIO) RETURN NUMBER,  
	STATIC FUNCTION COMPARE(OBJ1 TP_HISTORICO_SETOR_FUNCIONARIO, OBJ2 TP_HISTORICO_SETOR_FUNCIONARIO) RETURN BOOLEAN,    
	CONSTRUCTOR FUNCTION TP_HISTORICO_SETOR_FUNCIONARIO(MATRICULA IN NUMBER, DESCSETOR IN VARCHAR2, DESCJORNADA IN VARCHAR2) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_HISTORICO_SETOR_FUNCIONARIO(MATRICULA IN NUMBER, DESCSETOR IN VARCHAR2, DESCJORNADA IN VARCHAR2, MOMENTOENTRADA IN TIMESTAMP) RETURN SELF AS RESULT   
);
CREATE OR REPLACE TYPE TP_TIPOSERVICO AS OBJECT(
	COD NUMBER,
	DESCRICAO VARCHAR2(150),
	--
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	MEMBER FUNCTION GETDESCRICAO RETURN VARCHAR2,
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_TIPOSERVICO) RETURN NUMBER,
	STATIC FUNCTION COMPARE(OBJ1 TP_TIPOSERVICO, OBJ2 TP_TIPOSERVICO) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_TIPOSERVICO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_SERVICO AS OBJECT(
	COD NUMBER,
	DESCRICAO VARCHAR2(850),
	VALOR NUMBER(8,2),
	REF_TIPOSERVICO REF TP_TIPOSERVICO,
	--
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,   
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_SERVICO) RETURN NUMBER,
	STATIC FUNCTION COMPARE(OBJ1 TP_SERVICO, OBJ2 TP_SERVICO) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_SERVICO(DESCRICAO IN VARCHAR2, VALOR IN NUMBER, DESCTIPO IN VARCHAR2) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_DESCONTO AS OBJECT(
	COD NUMBER,
	DESCRICAO VARCHAR2(150),
	VALOR NUMBER(8,2),
	--
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	MEMBER FUNCTION GETDESCRICAO RETURN VARCHAR2,
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_DESCONTO) RETURN NUMBER,
	STATIC FUNCTION COMPARE(OBJ1 TP_DESCONTO, OBJ2 TP_DESCONTO) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_DESCONTO(DESCRICAO IN VARCHAR2,VALOR IN NUMBER) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_LIVRO AS OBJECT(
	COD NUMBER,
	DESCRICAO VARCHAR2(150),
	--
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	MEMBER FUNCTION GETDESCRICAO RETURN VARCHAR2,
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_LIVRO) RETURN NUMBER,
	STATIC FUNCTION COMPARE(OBJ1 TP_LIVRO, OBJ2 TP_LIVRO) RETURN BOOLEAN,
	CONSTRUCTOR FUNCTION TP_LIVRO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_ATENDIMENTO AS OBJECT(
	COD NUMBER,
	DATAATENDIMENTO TIMESTAMP,
	VALORTOTAL NUMBER(8,2),
	REF_ATENDENTE REF TP_FUNCIONARIO,
	REF_CLIENTE REF TP_CLIENTE,
	--
	MEMBER FUNCTION GETVALORTOTALATENDIMENTO RETURN NUMBER,
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	MEMBER FUNCTION GETATENDENTE RETURN VARCHAR2,
	MAP MEMBER FUNCTION GETCOD RETURN NUMBER,
	STATIC FUNCTION COMPARE(OBJ1 TP_ATENDIMENTO, OBJ2 TP_ATENDIMENTO) RETURN BOOLEAN, 
	CONSTRUCTOR FUNCTION TP_ATENDIMENTO(V_CPF_CNPJCLIENTE IN VARCHAR2, V_CPFFUNCIONARIOATENDENTE IN VARCHAR2) RETURN SELF AS RESULT,
	MEMBER FUNCTION GETCLIENTE RETURN VARCHAR2,
	CONSTRUCTOR FUNCTION TP_ATENDIMENTO(V_CPF_CNPJCLIENTE IN VARCHAR2, V_CPFFUNCIONARIOATENDENTE IN VARCHAR2, V_DATAATENDIMENTO IN TIMESTAMP) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_ATENDIMENTO(COD IN NUMBER, DATAATENDIMENTO IN TIMESTAMP, VALORTOTAL IN NUMBER, REF_ATENDENTE IN REF TP_FUNCIONARIO, REF_CLIENTE IN REF TP_CLIENTE) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_SERVICODOATENDIMENTO AS OBJECT(
	CODITEM NUMBER,
	DATAHORAREALIZACAO TIMESTAMP,
	OBSERVACAO VARCHAR2(200),
	QUANTIDADE INTEGER,
	VALORSERVICOREALIZADO NUMBER(8,2),
	REF_ATENDIMENTO REF TP_ATENDIMENTO,
	REF_SERVICO REF TP_SERVICO,
	REF_RESPONSAVEL REF TP_FUNCIONARIO,
	REF_DESCONTO REF TP_DESCONTO,
	--
	CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(V_CODATENDIMENTO IN NUMBER, V_DESCSERVICO IN VARCHAR2, V_CPFFUNCRESP IN VARCHAR2, V_OBS IN VARCHAR2, V_QTD IN INTEGER, V_DESCDESCONTO IN VARCHAR2) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(V_CODATENDIMENTO IN NUMBER, V_DESCSERVICO IN VARCHAR2, V_CPFFUNCRESP IN VARCHAR2, V_OBS IN VARCHAR2, V_QTD IN INTEGER, V_VALSERVATEND IN NUMBER, V_DESCDESCONTO IN VARCHAR2) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(V_CODATENDIMENTO IN NUMBER, V_DESCSERVICO IN VARCHAR2, V_CPFFUNCRESP IN VARCHAR2, V_OBS IN VARCHAR2, V_QTD IN INTEGER, V_DESCDESCONTO IN VARCHAR2, V_DATAHORAREALIZACAO IN TIMESTAMP) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(CODITEM IN NUMBER, REF_ATENDIMENTO IN REF TP_ATENDIMENTO, REF_SERVICO IN REF TP_SERVICO, REF_RESPONSAVEL IN REF TP_FUNCIONARIO, DATAHORAREALIZACAO IN TIMESTAMP, OBSERVACAO IN VARCHAR2, QUANTIDADE IN INTEGER, VALORSERVICOREALIZADO IN NUMBER, REF_DESCONTO IN REF TP_DESCONTO) RETURN SELF AS RESULT, 
	MEMBER FUNCTION GETVALORTOTALATENDIMENTO RETURN NUMBER,
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	MEMBER FUNCTION GETDESCRICAOSERVICOATENDIDO RETURN VARCHAR2,
	MEMBER FUNCTION GETRESPONSAVEL RETURN VARCHAR2,
	MEMBER FUNCTION GETCLIENTEATENDIDO RETURN VARCHAR2,
	MAP MEMBER FUNCTION GETCODSERVICOATENDIDO RETURN NUMBER,
	STATIC FUNCTION COMPARE(OBJ1 TP_SERVICODOATENDIMENTO, OBJ2 TP_SERVICODOATENDIMENTO) RETURN BOOLEAN  
);
CREATE OR REPLACE TYPE TP_REGISTRO AS OBJECT(
	NUMREGISTRO NUMBER,
	FOLHA INTEGER,
	REF_LIVRO REF TP_LIVRO,
	REF_SERVICODOATENDIMENTO REF TP_SERVICODOATENDIMENTO,
	--
	STATIC FUNCTION FAZREFERENCIAAALGUMREGISTRO(REFSERVICODOATENDIMENTO IN REF TP_SERVICODOATENDIMENTO) RETURN BOOLEAN,
	MEMBER PROCEDURE SETSERVICODOATENDIMENTO(REFSERVICODOATENDIMENTO IN REF TP_SERVICODOATENDIMENTO),
	MEMBER PROCEDURE SETLIVRO(REFLIVRO IN REF TP_LIVRO),
	MEMBER FUNCTION GETSERVICODOATENDIMENTO RETURN VARCHAR2,
	MEMBER FUNCTION GETLIVRO RETURN VARCHAR2,
	MEMBER FUNCTION GETINFO RETURN VARCHAR2,
	STATIC FUNCTION COMPARE(OBJ1 TP_REGISTRO, OBJ2 TP_REGISTRO) RETURN BOOLEAN,
	MAP MEMBER FUNCTION GETCODREGISTRO RETURN NUMBER,
	CONSTRUCTOR FUNCTION TP_REGISTRO(V_FOLHA IN INTEGER, V_REFLIVRO IN REF TP_LIVRO, V_RESERVICOATENDIDO IN REF TP_SERVICODOATENDIMENTO) RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION TP_REGISTRO(NUMREGISTRO IN INTEGER, FOLHA IN INTEGER, REF_LIVRO IN REF TP_LIVRO, REF_SERVICODOATENDIMENTO IN REF TP_SERVICODOATENDIMENTO) RETURN SELF AS RESULT
);
CREATE OR REPLACE TYPE TP_TUPLAATENDIMENTO AS OBJECT(
	CODATENDIMENTO NUMBER,
	CODCLIENTE NUMBER,
	CODATENDENTE NUMBER,
	VALORTOTAL NUMBER(8,2), 
	DATAATENDIMENTO TIMESTAMP
);
CREATE OR REPLACE TYPE TP_TUPLASERVICODOATENDIMENTO AS OBJECT(
	CODITEM NUMBER,
	CODATENDIMENTO NUMBER,
	CODDESCONTO NUMBER,
	CODRESPONSAVEL NUMBER,
	DATAHORAREALIZACAO TIMESTAMP, 
	CODSERVICO NUMBER,
	OBSERVACAO VARCHAR2(1250),
	VALORDOSERVICOREALIZADO NUMBER(8,2), 
	QUANTIDADE INTEGER 
);
CREATE OR REPLACE TYPE TP_TUPLAREGISTRO AS OBJECT(
	NUMRGISTRO NUMBER,
	FOLHA INTEGER,
	CODLIVRO NUMBER,
	CODSERVICODOATENDIMENTO NUMBER
);
-- CREATE TABLE
CREATE TABLE TB_FISICA OF TP_FISICA (
	COD PRIMARY KEY,
	CPF NOT NULL,
	SEXO NOT NULL CHECK(SEXO IN('M','F')),
	ENDERECO NOT NULL,
	NOME NOT NULL,
	FOTO NULL,
	TELEFONES NULL,     
	CONSTRAINT TB_FISICA_CPFUK UNIQUE(CPF)
 );
CREATE TABLE TB_JURIDICA OF TP_JURIDICA (
	COD PRIMARY KEY,
	CNPJ NOT NULL,
	RAZAOSOCIAL NOT NULL,
	ENDERECO NOT NULL,
	NOME NOT NULL,
	CONSTRAINT TB_JURIDICA_CNPJUK UNIQUE(CNPJ) ,
	CONSTRAINT TB_JURIDICA_RZSOCUK UNIQUE(RAZAOSOCIAL)
);
CREATE TABLE TB_CLIENTE OF TP_CLIENTE (
	COD PRIMARY KEY,
	DATAREGISTRO DEFAULT SYSDATE NOT NULL,
	RENDA NULL,
	REF_CLIENTE NOT NULL
);
CREATE TABLE TB_SETOR OF TP_SETOR (
	COD PRIMARY KEY,
	DESCRICAO NOT NULL,
	CONSTRAINT TB_SETOR_DESCRICAO_UK UNIQUE(DESCRICAO)
);
CREATE TABLE TB_JORNADA OF TP_JORNADA (
	COD PRIMARY KEY,
	DESCRICAO NOT NULL,
	HORAINICIO NOT NULL,
	HORAFIM NOT NULL,
	CONSTRAINT TB_JORNADA_DESCRICAO_UK UNIQUE(DESCRICAO),
	CONSTRAINT TB_JORNADA_HORARIO_UK UNIQUE(HORAINICIO, HORAFIM)
);
CREATE TABLE TB_CARGO OF TP_CARGO (
	COD PRIMARY KEY,
	DESCRICAO NOT NULL,
	CONSTRAINT TB_CARGO_DESCRICAO_UK UNIQUE(DESCRICAO)
);
CREATE TABLE TB_FUNCIONARIO OF TP_FUNCIONARIO (
	MATRICULA PRIMARY KEY,
	DATAADMISSAO DEFAULT SYSDATE NOT NULL,
	SALARIO NOT NULL CHECK (SALARIO >= 788.00),
	STATUS DEFAULT 'A' NOT NULL CHECK(STATUS IN('A','I')), -- A-ATIVO I-INATIVO
	REF_SUPERVISOR NULL SCOPE IS TB_FUNCIONARIO,
	REF_PESSOAFISICA NOT NULL WITH ROWID REFERENCES TB_FISICA, 
	REF_CARGO NOT NULL WITH ROWID REFERENCES TB_CARGO
) NESTED TABLE GRATIFICACOES STORE AS NSTB_GRATIFICACOES ((PRIMARY KEY (NESTED_TABLE_ID, PERIODO)));
CREATE TABLE TB_HISTORICO_SETOR_FUNCIONARIO OF TP_HISTORICO_SETOR_FUNCIONARIO (
	DATAENTRADA DEFAULT SYSTIMESTAMP NOT NULL,
	REF_SETOR NOT NULL WITH ROWID REFERENCES TB_SETOR,
	REF_JORNADA NOT NULL WITH ROWID REFERENCES TB_JORNADA, 
	REF_FUNCIONARIO NOT NULL WITH ROWID REFERENCES TB_FUNCIONARIO,
	PRIMARY KEY(DATAENTRADA)
);
CREATE TABLE TB_TIPOSERVICO OF TP_TIPOSERVICO (
	COD PRIMARY KEY,
	DESCRICAO NOT NULL,
	CONSTRAINT TB_TIPOSERVICO_UK UNIQUE(DESCRICAO)
);
CREATE TABLE TB_SERVICO OF TP_SERVICO( 
	COD PRIMARY KEY,
	DESCRICAO NOT NULL,
	VALOR NOT NULL CHECK(VALOR >= 0.0),
	REF_TIPOSERVICO NOT NULL WITH ROWID REFERENCES TB_TIPOSERVICO,
	CONSTRAINT TB_SERVICO_UK UNIQUE(DESCRICAO)
);
CREATE TABLE TB_DESCONTO OF TP_DESCONTO (
	COD PRIMARY KEY,
	DESCRICAO NOT NULL,
	VALOR NOT NULL CHECK (VALOR >= 0.0),
	CONSTRAINT TB_DESCONTO_DESCUK UNIQUE(DESCRICAO),
	CONSTRAINT TB_DESCONTO_VALORUK UNIQUE(VALOR)
);
CREATE TABLE TB_LIVRO OF TP_LIVRO (
	COD PRIMARY KEY,
	DESCRICAO NOT NULL,
	CONSTRAINT TB_LIVRO_DESCRICAO_UK UNIQUE(DESCRICAO)
);
CREATE TABLE TB_ATENDIMENTO OF TP_ATENDIMENTO (
	COD PRIMARY KEY,
	DATAATENDIMENTO DEFAULT SYSTIMESTAMP NOT NULL,
	VALORTOTAL DEFAULT 0.0 NOT NULL CHECK (VALORTOTAL >= 0.0),
	REF_ATENDENTE NOT NULL WITH ROWID REFERENCES TB_FUNCIONARIO, 
	REF_CLIENTE NOT NULL WITH ROWID REFERENCES TB_CLIENTE
);
CREATE TABLE TB_SERVICODOATENDIMENTO OF TP_SERVICODOATENDIMENTO (
	CODITEM PRIMARY KEY,
	DATAHORAREALIZACAO DEFAULT SYSTIMESTAMP NOT NULL,
	OBSERVACAO NULL,
	QUANTIDADE DEFAULT 1 CHECK (QUANTIDADE >= 1),
	VALORSERVICOREALIZADO DEFAULT 0 CHECK(VALORSERVICOREALIZADO >= 0),
	REF_ATENDIMENTO NOT NULL WITH ROWID REFERENCES TB_ATENDIMENTO, 
	REF_SERVICO NOT NULL WITH ROWID REFERENCES TB_SERVICO, 
	REF_RESPONSAVEL NOT NULL WITH ROWID REFERENCES TB_FUNCIONARIO,
	REF_DESCONTO NULL WITH ROWID REFERENCES TB_DESCONTO
);
CREATE TABLE TB_REGISTRO OF TP_REGISTRO (
	NUMREGISTRO PRIMARY KEY,
	FOLHA NOT NULL CHECK ((FOLHA >= 1) AND (FOLHA <= 200)),
	REF_LIVRO NOT NULL WITH ROWID REFERENCES TB_LIVRO, 
	REF_SERVICODOATENDIMENTO NOT NULL WITH ROWID REFERENCES TB_SERVICODOATENDIMENTO
);
CREATE TABLE TB_LOGATENDIMENTO (
	CODLOG NUMBER NOT NULL,
	DATAOPERACAO TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
	TIPOOPERACAO VARCHAR2(20) NOT NULL,
	USUARIO_BD VARCHAR2(255) NOT NULL,
	TUPLA TP_TUPLAATENDIMENTO NOT NULL,
	CONSTRAINT TB_LOG_LOGATEND_TIPOOPE_CHK CHECK (TIPOOPERACAO IN ('INSER플O','REMO플O','ATUALIZA플O')),
	CONSTRAINT TB_LOG_LOGATEND_PK PRIMARY KEY(CODLOG)
);
CREATE TABLE TB_LOGSERVICODOATENDIMENTO (
	CODLOG NUMBER NOT NULL,
	DATAOPERACAO TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
	TIPOOPERACAO VARCHAR2(20) NOT NULL,
	USUARIO_BD  VARCHAR2(255) NOT NULL,
	TUPLA TP_TUPLASERVICODOATENDIMENTO NOT NULL,
	CONSTRAINT TB_LOG_LOGSERVATEND_TPOP_CHK CHECK (TIPOOPERACAO IN ('INSER플O','REMO플O','ATUALIZA플O')),
	CONSTRAINT TB_LOG_LOGSERVATEND_PK PRIMARY KEY(CODLOG)
);
CREATE TABLE TB_LOGREGISTRO (
	CODLOG NUMBER NOT NULL,
	DATAOPERACAO TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
	TIPOOPERACAO VARCHAR2(20) NOT NULL,
	USUARIO_BD VARCHAR2(255) NOT NULL,
	TUPLA TP_TUPLAREGISTRO NOT NULL,
	CONSTRAINT TB_LOG_LOGREG_TPOP_CHK CHECK (TIPOOPERACAO IN ('INSER플O','REMO플O','ATUALIZA플O')),
	CONSTRAINT TB_LOG_LOGREG_PK PRIMARY KEY(CODLOG)
);
-- CREATE INDEX
CREATE INDEX IDX_TB_ATENDIMENTO_DATA ON TB_ATENDIMENTO(DATAATENDIMENTO);
CREATE INDEX IDX_TB_CLIENTE_DATA ON TB_CLIENTE(DATAREGISTRO);
CREATE INDEX IDX_TB_FISICA_NOME ON TB_FISICA(NOME);
CREATE INDEX IDX_TB_FISICA_CPF_NOME ON TB_FISICA(CPF,NOME);
CREATE INDEX IDX_TB_FUNCIONARIO_STATUS ON TB_FUNCIONARIO(STATUS);
CREATE INDEX IDX_TB_FUNCIONARIO_SALARIO ON TB_FUNCIONARIO(SALARIO);
CREATE INDEX IDX_TB_FUNCION_DTADMISSAO ON TB_FUNCIONARIO(DATAADMISSAO);
CREATE INDEX IDX_TB_JURIDICA_CNPJ_RZSOC ON TB_JURIDICA(CNPJ,RAZAOSOCIAL);
CREATE INDEX IDX_TB_LOG_ATENDIMENTO_DATAOP ON TB_LOGATENDIMENTO(DATAOPERACAO);
CREATE INDEX IDX_TB_LOG_ATENDIMENTO_TIPOOP ON TB_LOGATENDIMENTO(TIPOOPERACAO);
CREATE INDEX IDX_TB_LOG_ATENDIMENTO_DTOP ON TB_LOGATENDIMENTO(DATAOPERACAO,TIPOOPERACAO);
CREATE INDEX IDX_TB_LOG_SERVDOATEND_DATAOP ON TB_LOGSERVICODOATENDIMENTO(DATAOPERACAO);
CREATE INDEX IDX_TB_LOG_SERVDOATEND_TIPOOP ON TB_LOGSERVICODOATENDIMENTO(TIPOOPERACAO);
CREATE INDEX IDX_TB_LOG_SERVDOATEND_DTOP ON TB_LOGSERVICODOATENDIMENTO(DATAOPERACAO,TIPOOPERACAO);
CREATE INDEX IDX_TB_REGISTRO_FOLHA ON TB_REGISTRO(FOLHA);
CREATE INDEX IDX_TB_SERVICO_VALOR ON TB_SERVICO(VALOR);
CREATE INDEX IDX_TB_SERVICO_DESCVAL ON TB_SERVICO(DESCRICAO,VALOR);
