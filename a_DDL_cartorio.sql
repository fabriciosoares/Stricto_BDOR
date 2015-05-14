------ criação de sequences para ajudar na geração da chave primária das tabela;

CREATE SEQUENCE SEQ_LOGSERVICODOATENDIMENTO INCREMENT BY 1 START WITH 1; 

CREATE SEQUENCE SEQ_LOGATENDIMENTO INCREMENT BY 1 START WITH 1; 

CREATE SEQUENCE SEQ_PESSOA INCREMENT BY 1 START WITH 1; -- usada para cadastrar pessoas fisicas e juridicas no sistema

CREATE sequence "SEQ_CARGO" INCREMENT BY 1 START WITH 1;

CREATE sequence "SEQ_JORNADA" INCREMENT BY 1 START WITH 1;

CREATE sequence "SEQ_SETOR" INCREMENT BY 1 START WITH 1;

CREATE sequence "SEQ_LIVRO" INCREMENT BY 1 START WITH 1;

CREATE sequence "SEQ_TIPOSERVICO" INCREMENT BY 1 START WITH 1;

CREATE sequence "SEQ_SERVICO" INCREMENT BY 1 START WITH 1;

CREATE sequence "SEQ_DESCONTO" INCREMENT BY 1 START WITH 1;

CREATE sequence "SEQ_REGISTRO" INCREMENT BY 1 START WITH 1;

CREATE sequence "SEQ_ATENDIMENTO" INCREMENT BY 1 START WITH 1;

CREATE sequence "SEQ_SERVICODOATENDIMENTO" INCREMENT BY 1 START WITH 1;

CREATE sequence "SEQ_LOGREGISTRO" INCREMENT BY 1 START WITH 1;

 
-------- Crição dos tipos de objetos do modelo objeto relacional do sistema de cartório ----------------------------------------------

CREATE OR REPLACE TYPE TP_ENDERECO AS OBJECT(
  LOGRADOURO      VARCHAR2(50),
  NUMERO          NUMBER(5),
  BAIRRO          VARCHAR2(20),
  CIDADE          VARCHAR2(20),
  UF		       CHAR(2),
  CEP             VARCHAR2(9)
);

CREATE OR REPLACE TYPE TP_TELEFONE AS OBJECT(
  TIPO     VARCHAR2(20),
  DDD     NUMBER(2),
  NUMERO  NUMBER(8),
  MEMBER FUNCTION toString RETURN VARCHAR2,
  MEMBER FUNCTION getTelefone RETURN VARCHAR2
);


CREATE OR REPLACE TYPE ARRAY_TELEFONE AS VARRAY(3) OF TP_TELEFONE;

CREATE OR REPLACE TYPE TP_PESSOA AS OBJECT(
  COD             NUMBER,
  NOME           VARCHAR2(50),
  TELEFONES      ARRAY_TELEFONE,
  ENDERECO       TP_ENDERECO,
  MEMBER FUNCTION getEndereco RETURN VARCHAR2,
  MEMBER FUNCTION getFones RETURN VARCHAR2, 
  MEMBER FUNCTION getInfo RETURN VARCHAR2,
  MAP MEMBER FUNCTION getCod RETURN NUMBER,
  STATIC FUNCTION compare(obj1 TP_PESSOA, obj2 TP_PESSOA) RETURN BOOLEAN
)NOT FINAL NOT INSTANTIABLE;
   
CREATE OR REPLACE TYPE TP_FISICA UNDER TP_PESSOA(
  CPF            VARCHAR2(11),
  SEXO            CHAR(1),
  FOTO                    BLOB,
  OVERRIDING MEMBER FUNCTION getInfo RETURN VARCHAR2,
  STATIC FUNCTION compare(obj1 TP_FISICA, obj2 TP_FISICA) RETURN BOOLEAN,
  CONSTRUCTOR FUNCTION TP_FISICA(CPF IN VARCHAR2, SEXO IN CHAR, NOME IN VARCHAR2, ENDLOGRADOURO IN ENDERECO.LOGRADOURO%TYPE, ENDNUMERO IN ENDERECO.NUMERO%TYPE, ENDBAIRRO IN ENDERECO.BAIRRO%TYPE, ENDCIDADE IN ENDERECO.CIDADE%TYPE, ENDUF IN ENDERECO.UF%TYPE, ENDCEP IN ENDERECO.CEP%TYPE) RETURN SELF AS RESULT, 
  CONSTRUCTOR FUNCTION TP_FISICA(CPF IN VARCHAR2, SEXO IN CHAR, NOME IN VARCHAR2, ENDERECO IN ENDERECO%TYPE, FONES IN ARRAY_TELEFONE) RETURN SELF AS RESULT 
);

CREATE OR REPLACE TYPE TP_JURIDICA UNDER TP_PESSOA(
  CNPJ            VARCHAR2(14),
  RAZAOSOCIAL     VARCHAR2(50),
  OVERRIDING MEMBER FUNCTION getInfo RETURN VARCHAR2,
  STATIC FUNCTION compare(obj1 TP_JURIDICA, obj2 TP_JURIDICA) RETURN BOOLEAN,
  CONSTRUCTOR FUNCTION TP_JURIDICA(CNPJ IN VARCHAR2, RAZAOSOCIAL IN VARCHAR2, NOME IN VARCHAR2, ENDLOGRADOURO IN ENDERECO.LOGRADOURO%TYPE, ENDNUMERO IN ENDERECO.NUMERO%TYPE, ENDBAIRRO IN ENDERECO.BAIRRO%TYPE, ENDCIDADE IN ENDERECO.CIDADE%TYPE, ENDUF IN ENDERECO.UF%TYPE, ENDCEP IN ENDERECO.CEP%TYPE) RETURN SELF AS RESULT, 
  CONSTRUCTOR FUNCTION TP_JURIDICA(CNPJ IN VARCHAR2, RAZAOSOCIAL IN VARCHAR2, NOME IN VARCHAR2, ENDERECO IN ENDERECO%TYPE,  FONES IN ARRAY_TELEFONE) RETURN SELF AS RESULT 
);

CREATE OR REPLACE TYPE TP_CLIENTE AS OBJECT(
  DATAREGISTRO       DATE,
  COD              NUMBER,
  RENDA          NUMBER(8,2),  
  REF_CLIENTE    REF TP_PESSOA,
  MEMBER FUNCTION eBaixaRenda RETURN VARCHAR2,
  MEMBER FUNCTION getRenda RETURN VARCHAR2,
  MEMBER FUNCTION getInfo RETURN VARCHAR2,
  ORDER MEMBER FUNCTION equals(obj TP_CLIENTE) RETURN NUMBER,
  STATIC FUNCTION compare(obj1 TP_CLIENTE, obj2 TP_CLIENTE) RETURN BOOLEAN,
  CONSTRUCTOR FUNCTION TP_CLIENTE(CPF_CNPJ IN VARCHAR2) RETURN SELF AS RESULT,
  CONSTRUCTOR FUNCTION TP_CLIENTE(CPF IN VARCHAR2, RENDA IN NUMBER) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE TP_CARGO AS OBJECT(
  DESCRICAO        VARCHAR2(250),
  COD              NUMBER,  
  MEMBER FUNCTION getInfo RETURN VARCHAR2,
  ORDER MEMBER FUNCTION equals(obj TP_CARGO) RETURN NUMBER,
  STATIC FUNCTION compare(obj1 TP_CARGO, obj2 TP_CARGO) RETURN BOOLEAN,
  CONSTRUCTOR FUNCTION TP_CARGO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE TP_SETOR AS OBJECT(
  DESCRICAO        VARCHAR2(250),
  COD              NUMBER,  
  MEMBER FUNCTION getInfo RETURN VARCHAR2,
  ORDER MEMBER FUNCTION equals(obj TP_SETOR) RETURN NUMBER,
  STATIC FUNCTION compare(obj1 TP_SETOR, obj2 TP_SETOR) RETURN BOOLEAN,
  CONSTRUCTOR FUNCTION TP_SETOR(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT
);

create or replace TYPE TP_JORNADA AS OBJECT(
  DESCRICAO        VARCHAR2(250),
  HORAINICIO  interval day(0) to second,
  HORAFIM  interval day(0) to second,
  COD              NUMBER,  
  MEMBER FUNCTION getInfo RETURN VARCHAR2,
  ORDER MEMBER FUNCTION equals(obj TP_JORNADA) RETURN NUMBER,
  STATIC FUNCTION compare(obj1 TP_JORNADA, obj2 TP_JORNADA) RETURN BOOLEAN,
  CONSTRUCTOR FUNCTION TP_JORNADA(DESCRICAO IN VARCHAR2,HORAINICIO IN interval day to second,HORAFIM IN interval day to second) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE TP_GRATIFICACAO AS OBJECT(
  PERIODO                DATE,
  VALOR              NUMBER(8,2),
  MEMBER FUNCTION getInfo RETURN VARCHAR2,    
  CONSTRUCTOR FUNCTION TP_GRATIFICACAO(PERIODO IN DATE, VALOR IN NUMBER) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE NESTED_GRATIFICACAO AS TABLE OF TP_GRATIFICACAO;

CREATE OR REPLACE TYPE TP_FUNCIONARIO AS OBJECT(
  DATAADMISAO         DATE,
  MATRICULA           NUMBER,
  SENHA               VARCHAR2(15),
  SALARIO             NUMBER(8,2),  
  STATUS              CHAR(1),  
  REF_PESSOAFISICA    REF TP_FISICA,
  REF_CARGO           REF TP_CARGO,
  REF_SUPERVISOR      REF TP_FUNCIONARIO,
  GRATIFICACOES       NESTED_GRATIFICACAO,      

  MEMBER FUNCTION getSumAllGratificacoes RETURN NUMBER,
  MEMBER FUNCTION getTotGratificacoesByAno(ano in integer) RETURN NUMBER,
  MEMBER FUNCTION getTotGratificacoesByPeriodo(dataIni in date, dataFim in date) RETURN NUMBER,
  MEMBER FUNCTION getTotGratificacoesByMesAno(mes in integer,ano in integer) RETURN NUMBER,
  
  MEMBER FUNCTION getCargo RETURN VARCHAR2,
  MEMBER FUNCTION getStatus RETURN VARCHAR2,
  MEMBER FUNCTION getInfo RETURN VARCHAR2,
  MEMBER FUNCTION getInfoResumida RETURN VARCHAR2, 

  MEMBER FUNCTION getInfoSupervisor RETURN varchar2,
  MEMBER FUNCTION possuiSupervisor RETURN BOOLEAN,
  MEMBER FUNCTION getFuncioariosSupervisionados RETURN varchar2
    
  , MAP MEMBER FUNCTION getMatricula RETURN number
  ,STATIC FUNCTION compare(obj1 TP_FUNCIONARIO, obj2 TP_FUNCIONARIO) RETURN BOOLEAN  
      
);

create or replace TYPE TP_HISTORICO_SETOR_FUNCIONARIO AS OBJECT(
   DATAENTRADA TIMESTAMP,
   REF_SETOR REF TP_SETOR,
   REF_FUNCIONARIO REF TP_FUNCIONARIO,
   REF_JORNADA REF TP_JORNADA,
      
   STATIC FUNCTION getHistoricoFuncionario(matricula in number) RETURN varchar2,
   STATIC FUNCTION getSetorRecenteFuncionario(P_matricula in number) RETURN varchar2,   
   STATIC FUNCTION getFuncionariosDoSetor(descSetor in varchar2) RETURN varchar2,  
   ORDER MEMBER FUNCTION equals(obj TP_HISTORICO_SETOR_FUNCIONARIO) RETURN NUMBER,  
   STATIC FUNCTION compare(obj1 TP_HISTORICO_SETOR_FUNCIONARIO, obj2 TP_HISTORICO_SETOR_FUNCIONARIO) RETURN BOOLEAN,    
   CONSTRUCTOR FUNCTION TP_HISTORICO_SETOR_FUNCIONARIO(matricula IN number, descSetor IN varchar2,descjornada in varchar2) RETURN SELF AS RESULT,
   CONSTRUCTOR FUNCTION TP_HISTORICO_SETOR_FUNCIONARIO(matricula IN number, descSetor IN varchar2,descJornada in varchar2, momentoEntrada in timestamp) RETURN SELF AS RESULT   
);

CREATE OR REPLACE TYPE TP_TIPOSERVICO AS OBJECT(
   COD  NUMBER,
   DESCRICAO VARCHAR2(150),
   MEMBER FUNCTION getInfo RETURN VARCHAR2,
   MEMBER FUNCTION getDescricao RETURN VARCHAR2,
   ORDER MEMBER FUNCTION equals(obj TP_TIPOSERVICO) RETURN NUMBER,
   STATIC FUNCTION compare(obj1 TP_TIPOSERVICO, obj2 TP_TIPOSERVICO) RETURN BOOLEAN,
   CONSTRUCTOR FUNCTION TP_TIPOSERVICO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE TP_SERVICO AS OBJECT(
   COD  NUMBER,
   DESCRICAO VARCHAR2(850),
   VALOR NUMBER(8,2),
   REF_TIPOSERVICO REF TP_TIPOSERVICO,
   MEMBER FUNCTION getInfo RETURN VARCHAR2,   
   ORDER MEMBER FUNCTION equals(obj TP_SERVICO) RETURN NUMBER,
   STATIC FUNCTION compare(obj1 TP_SERVICO, obj2 TP_SERVICO) RETURN BOOLEAN,
   CONSTRUCTOR FUNCTION TP_SERVICO(DESCRICAO IN VARCHAR2, valor in number, descTipo in varchar2) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE TP_DESCONTO AS OBJECT(
   COD  NUMBER,
   DESCRICAO VARCHAR2(150),
   VALOR NUMBER(8,2),
   MEMBER FUNCTION getInfo RETURN VARCHAR2,
   MEMBER FUNCTION getDescricao RETURN VARCHAR2,
   ORDER MEMBER FUNCTION equals(obj TP_DESCONTO) RETURN NUMBER,
   STATIC FUNCTION compare(obj1 TP_DESCONTO, obj2 TP_DESCONTO) RETURN BOOLEAN,
   CONSTRUCTOR FUNCTION TP_DESCONTO(DESCRICAO IN VARCHAR2,VALOR IN NUMBER) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE TP_LIVRO AS OBJECT(
   COD  NUMBER,
   DESCRICAO VARCHAR2(150),   
   MEMBER FUNCTION getInfo RETURN VARCHAR2,
   MEMBER FUNCTION getDescricao RETURN VARCHAR2,
   ORDER MEMBER FUNCTION equals(obj TP_LIVRO) RETURN NUMBER,
   STATIC FUNCTION compare(obj1 TP_LIVRO, obj2 TP_LIVRO) RETURN BOOLEAN,
   CONSTRUCTOR FUNCTION TP_LIVRO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE TP_ATENDIMENTO AS OBJECT(
   COD  NUMBER,
   DATAATENDIMENTO TIMESTAMP,
   VALORTOTAL NUMBER(8,2)
   ,REF_ATENDENTE REF TP_FUNCIONARIO
   ,REF_CLIENTE REF TP_CLIENTE
  
  ,MEMBER FUNCTION getValorTotalAtendimento RETURN NUMBER 
  ,MEMBER FUNCTION getInfo RETURN VARCHAR2  
  ,MEMBER FUNCTION getAtendente RETURN VARCHAR2
  ,MEMBER FUNCTION getCliente RETURN VARCHAR2     
  ,MAP MEMBER FUNCTION getCod RETURN number  
  ,STATIC FUNCTION compare(obj1 TP_ATENDIMENTO, obj2 TP_ATENDIMENTO) RETURN BOOLEAN    
  ,CONSTRUCTOR FUNCTION TP_ATENDIMENTO(v_cpf_cnpjCliente IN VARCHAR2, v_cpfFuncionarioAtendente IN varchar2) RETURN SELF AS RESULT
  ,CONSTRUCTOR FUNCTION TP_ATENDIMENTO(v_cpf_cnpjCliente IN VARCHAR2, v_cpfFuncionarioAtendente IN varchar2, v_dataAtendimento in TIMESTAMP) RETURN SELF AS RESULT
  ,CONSTRUCTOR FUNCTION TP_ATENDIMENTO(cod IN number, dataAtendimento IN TIMESTAMP, valorTotal in number, ref_Atendente in REF TP_FUNCIONARIO, ref_Cliente in REF TP_CLIENTE) RETURN SELF AS RESULT
    
);

CREATE OR REPLACE TYPE TP_SERVICODOATENDIMENTO AS OBJECT(
  CODITEM NUMBER,
  REF_ATENDIMENTO REF TP_ATENDIMENTO,
  REF_SERVICO REF TP_SERVICO,
  REF_RESPONSAVEL REF TP_FUNCIONARIO,
  DATAHORAREALIZACAO TIMESTAMP,
  OBSERVACAO VARCHAR2(200),
  QUANTIDADE INTEGER,  
  VALORSERVICOREALIZADO NUMBER(8,2),
  
  REF_DESCONTO REF TP_DESCONTO

  ,MEMBER FUNCTION getValorTotalAtendimento RETURN NUMBER 
  
  ,MEMBER FUNCTION getInfo RETURN VARCHAR2  
  ,MEMBER FUNCTION getDescricaoServicoAtendido RETURN VARCHAR2    
  ,MEMBER FUNCTION getResponsavel RETURN VARCHAR2
  ,MEMBER FUNCTION getClienteAtendido RETURN VARCHAR2     
  ,MAP MEMBER FUNCTION getCodServicoAtendido RETURN NUMBER
  
  ,STATIC FUNCTION compare(obj1 TP_SERVICODOATENDIMENTO, obj2 TP_SERVICODOATENDIMENTO) RETURN BOOLEAN  
  
  ,CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(v_codAtendimento IN number, v_descServico IN varchar2, v_cpfFuncResp in varchar2,v_obs in varchar2,v_qtd in integer, v_descDesconto in varchar2) RETURN SELF AS RESULT
  ,CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(v_codAtendimento IN number, v_descServico IN varchar2, v_cpfFuncResp in varchar2,v_obs in varchar2,v_qtd in integer, v_valServAtend in number,v_descDesconto in varchar2) RETURN SELF AS RESULT  
  ,CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(v_codAtendimento IN number, v_descServico IN varchar2, v_cpfFuncResp in varchar2,v_obs in varchar2,v_qtd in integer, v_descDesconto in varchar2,v_datahorarealizacao in timestamp) RETURN SELF AS RESULT
  ,CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(CODITEM IN NUMBER, REF_ATENDIMENTO IN REF TP_ATENDIMENTO, REF_SERVICO IN REF TP_SERVICO, REF_RESPONSAVEL IN REF TP_FUNCIONARIO, DATAHORAREALIZACAO in timestamp, observacao in varchar2, quantidade in integer, valorservicorealizado in number, ref_desconto in ref tp_desconto) RETURN SELF AS RESULT  
    
);

CREATE OR REPLACE TYPE TP_REGISTRO AS OBJECT(
   NUMREGISTRO  NUMBER,
   FOLHA INTEGER,
   REF_LIVRO REF TP_LIVRO,
   REF_SERVICODOATENDIMENTO REF TP_SERVICODOATENDIMENTO        
  --COLOCAR ESSE METODO EM CLIENTE TAMBÉM  ,STATIC FUNCTION fazReferenciaAAlgumCliente(refPessoa in ref tp_pessoa) RETURN BOOLEAN   --buscar em duas tabelas fisica e juridica
  --COLOCAR ESSE METODO EM FUNCIONARIO TAMBÉM  ,STATIC FUNCTION fazReferenciaAAlgumFuncionario(refPessoaFisica in ref tp_Fisica) RETURN BOOLEAN  --buscar na tabela fisica  
  ,STATIC FUNCTION fazReferenciaAAlgumRegistro(refServicoDoAtendimento in ref tp_servicodoatendimento) RETURN BOOLEAN  --para garantir relacionamento 1p1 usar  no contrutor do objeto--para garantir relacionamento 1p1 usar  no contrutor do objeto
  ,MEMBER procedure setServicoDoAtendimento(refServicoDoAtendimento in ref tp_servicodoatendimento) 
  ,MEMBER procedure setLivro(refLivro in ref tp_livro)         
  ,MEMBER FUNCTION getServicoDoAtendimento RETURN varchar2
  ,MEMBER FUNCTION getLivro RETURN varchar2
  ,MEMBER FUNCTION getInfo RETURN varchar2     
  ,STATIC FUNCTION compare(obj1 TP_REGISTRO, obj2 TP_REGISTRO) RETURN BOOLEAN    
  ,MAP MEMBER FUNCTION getCodRegistro RETURN NUMBER
  ,CONSTRUCTOR FUNCTION TP_REGISTRO(v_folha IN integer, v_refLivro IN ref tp_livro, v_reServicoAtendido in ref tp_servicodoatendimento) RETURN SELF AS RESULT
  ,CONSTRUCTOR FUNCTION TP_REGISTRO(NUMREGISTRO IN integer, FOLHA in integer,  REF_LIVRO IN ref tp_livro, REF_SERVICODOATENDIMENTO in ref tp_servicodoatendimento) RETURN SELF AS RESULT   
);

CREATE OR REPLACE TYPE tp_tuplaAtendimento AS OBJECT(
 codAtendimento NUMBER,
 codCliente NUMBER,
 codAtendente NUMBER,
 valorTotal number(8,2), 
 dataAtendimento TIMESTAMP
);

CREATE OR REPLACE TYPE tp_tuplaServicoDoAtendimento AS OBJECT(
 codItem number,
 codAtendimento number,
 codDesconto number,
 codResponsavel number,
 dataHoraRealizacao timestamp, 
 codServico number,
 observacao varchar2(1250),
 valorDoServicoRealizado number(8,2), 
 quantidade integer 
);

CREATE OR REPLACE TYPE tp_tuplaREGISTRO AS OBJECT(
 numrgistro number,
 folha integer,
 codLivro number,
 codServicoDoAtendimento number
);


-------- Crição das tabelas de tipos de objetos e das tabelas de log de auditoria do sistema de cartório ------------------------------

CREATE TABLE TB_FISICA OF TP_FISICA
  (
    COD PRIMARY KEY,
    CPF NOT NULL,
    SEXO NOT NULL CHECK(SEXO IN('M','F')),
    ENDERECO NOT NULL,
    NOME NOT NULL,
    FOTO NULL,
    TELEFONES NULL,     
    CONSTRAINT TB_FISICA_CPFUK UNIQUE(CPF)
  );

CREATE TABLE TB_JURIDICA OF TP_JURIDICA
  (
    COD PRIMARY KEY,
    CNPJ NOT NULL,
    RAZAOSOCIAL NOT NULL,
    ENDERECO NOT NULL,
    NOME NOT NULL,     
    CONSTRAINT TB_JURIDICA_CNPJUK UNIQUE(CNPJ) ,
    CONSTRAINT TB_JURIDICA_RZSOCUK UNIQUE(RAZAOSOCIAL)
  );

CREATE TABLE TB_CLIENTE OF TP_CLIENTE
  (
    COD PRIMARY KEY,
    DATAREGISTRO DEFAULT SYSDATE NOT NULL,
    RENDA NULL,      
    REF_CLIENTE NOT NULL --IS OF (TP_PESSOA)
    
  );

CREATE TABLE TB_SETOR OF TP_SETOR
  (
    COD PRIMARY KEY,
    DESCRICAO NOT NULL,
    CONSTRAINT TB_SETOR_DESCRICAO_UK UNIQUE(DESCRICAO)
  );
  
CREATE TABLE TB_JORNADA OF TP_JORNADA
  (
    COD PRIMARY KEY,
    DESCRICAO NOT NULL,
    HORAINICIO NOT NULL,
    HORAFIM NOT NULL,
    CONSTRAINT TB_JORNADA_DESCRICAO_UK UNIQUE(DESCRICAO),
    CONSTRAINT TB_JORNADA_HORARIO_UK UNIQUE(HORAINICIO,HORAFIM)
  );  

CREATE TABLE TB_CARGO OF TP_CARGO
  (
    COD PRIMARY KEY,
    DESCRICAO NOT NULL,
    CONSTRAINT TB_CARGO_DESCRICAO_UK UNIQUE(DESCRICAO)
  );

CREATE TABLE TB_FUNCIONARIO OF TP_FUNCIONARIO
  (
    MATRICULA PRIMARY KEY,
    DATAADMISAO DEFAULT SYSDATE NOT NULL,
    SALARIO NOT NULL CHECK (SALARIO          >=788.00),
    STATUS DEFAULT 'A' NOT NULL CHECK(STATUS IN('A','I')), -- A-ATIVO I-INATIVO
    REF_SUPERVISOR NULL SCOPE IS TB_FUNCIONARIO,
    REF_PESSOAFISICA NOT NULL WITH ROWID REFERENCES TB_FISICA, 
    REF_CARGO NOT NULL WITH ROWID REFERENCES TB_CARGO   
    ) NESTED TABLE GRATIFICACOES STORE AS NSTB_GRATIFICACOES
  (
    (PRIMARY KEY (NESTED_TABLE_ID, PERIODO))
   );

CREATE TABLE TB_HISTORICO_SETOR_FUNCIONARIO OF TP_HISTORICO_SETOR_FUNCIONARIO
  (
    DATAENTRADA DEFAULT SYSTIMESTAMP NOT NULL,
    REF_SETOR NOT NULL WITH ROWID REFERENCES TB_SETOR,
    REF_JORNADA NOT NULL WITH ROWID REFERENCES TB_JORNADA, 
    REF_FUNCIONARIO NOT NULL WITH ROWID REFERENCES TB_FUNCIONARIO,
PRIMARY KEY(DATAENTRADA)
  );
      
CREATE TABLE TB_TIPOSERVICO OF TP_TIPOSERVICO
  (
    COD PRIMARY KEY,
    DESCRICAO NOT NULL,
    CONSTRAINT TB_TIPOSERVICO_UK UNIQUE(DESCRICAO)
  );

CREATE TABLE TB_SERVICO OF TP_SERVICO
  (
    COD PRIMARY KEY,
    DESCRICAO NOT NULL,
    VALOR NOT NULL CHECK(VALOR>=0.0),
    REF_TIPOSERVICO NOT NULL
WITH ROWID REFERENCES TB_TIPOSERVICO,
  CONSTRAINT TB_SERVICO_UK UNIQUE(DESCRICAO)
  );

CREATE TABLE TB_DESCONTO OF TP_DESCONTO
  (
    COD PRIMARY KEY,
    DESCRICAO NOT NULL,
    VALOR NOT NULL CHECK (VALOR>=0.0),
    CONSTRAINT TB_DESCONTO_DESCUK UNIQUE(DESCRICAO),
    CONSTRAINT TB_DESCONTO_VALORUK UNIQUE(VALOR)
  );

CREATE TABLE TB_LIVRO OF TP_LIVRO
  (
    COD PRIMARY KEY,
    DESCRICAO NOT NULL,
    CONSTRAINT TB_LIVRO_DESCRICAO_UK UNIQUE(DESCRICAO)
  );

CREATE TABLE TB_ATENDIMENTO OF TP_ATENDIMENTO
  (
    COD PRIMARY KEY,
    DATAATENDIMENTO DEFAULT SYSTIMESTAMP NOT NULL,
    VALORTOTAL DEFAULT 0.0 NOT NULL CHECK (VALORTOTAL>=0.0),
    REF_ATENDENTE NOT NULL WITH ROWID REFERENCES TB_FUNCIONARIO, 
    REF_CLIENTE NOT NULL WITH ROWID REFERENCES TB_CLIENTE
  );

CREATE TABLE TB_SERVICODOATENDIMENTO OF TP_SERVICODOATENDIMENTO
  (
    coditem PRIMARY KEY,
    REF_ATENDIMENTO NOT NULL WITH ROWID REFERENCES TB_ATENDIMENTO, 
    REF_SERVICO NOT NULL WITH ROWID REFERENCES TB_SERVICO, REF_RESPONSAVEL NOT NULL
    WITH ROWID REFERENCES TB_FUNCIONARIO,
    DATAHORAREALIZACAO DEFAULT SYSTIMESTAMP NOT NULL ,
    OBSERVACAO NULL,
    QUANTIDADE DEFAULT 1 CHECK (QUANTIDADE >=1),
    VALORSERVICOREALIZADO DEFAULT 0 CHECK(VALORSERVICOREALIZADO>=0),
    REF_DESCONTO NULL WITH ROWID REFERENCES TB_DESCONTO
  );

CREATE TABLE TB_REGISTRO OF TP_REGISTRO
  (
    NUMREGISTRO PRIMARY KEY,
    FOLHA NOT NULL CHECK ((FOLHA>=1)
  AND(FOLHA                     <=200)),
    REF_LIVRO NOT NULL WITH ROWID REFERENCES TB_LIVRO, 
    REF_SERVICODOATENDIMENTO NOT NULL WITH ROWID REFERENCES TB_SERVICODOATENDIMENTO
  );

--TABELAS LOG
CREATE TABLE tb_logAtendimento
(
  codLog       NUMBER NOT NULL,
  dataOperacao timestamp DEFAULT systimestamp NOT NULL,
  tipoOperacao varchar2(20) NOT NULL,
  usuario_bd  varchar2(255) NOT NULL,
  tupla tp_tuplaAtendimento NOT NULL,
  CONSTRAINT tb_log_LogAtend_tipoOpe_chk CHECK (tipoOperacao IN ('INSERÇÃO','REMOÇÃO','ATUALIZAÇÃO')), --I-INSERÇÃO R-REMOÇÃO A-ALTERAÇÃO
  CONSTRAINT tb_log_LogAtend_pk PRIMARY KEY(codLog)
);

CREATE TABLE tb_logServicoDoAtendimento
(
  codLog       NUMBER NOT NULL,
  dataOperacao timestamp DEFAULT systimestamp NOT NULL,
  tipoOperacao VARCHAR2(20) NOT NULL,
  usuario_bd  varchar2(255) NOT NULL,
  tupla tp_tuplaServicoDoAtendimento NOT NULL,
  CONSTRAINT tb_log_LogServAtend_tpOp_chk CHECK (tipoOperacao IN ('INSERÇÃO','REMOÇÃO','ATUALIZAÇÃO')), --I-INSERÇÃO R-REMOÇÃO A-ATUALIZAÇÃO
  CONSTRAINT tb_log_LogServAtend_pk PRIMARY KEY(codLog)
);

 CREATE TABLE tb_logregistro
(
  codLog      NUMBER NOT NULL,
  dataOperacao timestamp DEFAULT systimestamp NOT NULL,
  tipoOperacao VARCHAR2(20) NOT NULL,
  usuario_bd  varchar2(255) NOT NULL,
  tupla tp_tuplaregistro NOT NULL,
  CONSTRAINT tb_log_LogReg_tpOp_chk CHECK (tipoOperacao IN ('INSERÇÃO','REMOÇÃO','ATUALIZAÇÃO')), --I-INSERÇÃO R-REMOÇÃO A-ATUALIZAÇÃO
  CONSTRAINT tb_log_LogReg_pk PRIMARY KEY(codLog)
);

  
-------------------Criação do corpo dos tipos de objetos-------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TYPE BODY TP_TELEFONE AS
    
    MEMBER FUNCTION toString RETURN VARCHAR2 AS
    retorno VARCHAR2(15);
    BEGIN
       SELECT         
       SELF.TIPO ||': '||TO_CHAR(SELF.DDD) ||') ' || TO_CHAR(SELF.numero) into retorno FROM DUAL;
       RETURN retorno;
    END toString;
    
    MEMBER FUNCTION getTelefone RETURN VARCHAR2 AS
    retorno VARCHAR2(15);
    BEGIN
       SELECT         
       '('||TO_CHAR(SELF.DDD) ||') ' || TO_CHAR(SELF.numero) into retorno FROM DUAL;
       RETURN retorno;
    END getTelefone;
END;

CREATE OR REPLACE TYPE BODY TP_PESSOA AS
    
    MEMBER FUNCTION getEndereco RETURN VARCHAR2 AS
    retorno VARCHAR2(550);
    BEGIN
       SELECT    
       'Logradouro: '||SELF.ENDERECO.LOGRADOURO || 
       ' nº ' || TO_CHAR(SELF.ENDERECO.NUMERO)||
       ' Bairro: ' || SELF.ENDERECO.BAIRRO||
       ' Cidade: '|| SELF.ENDERECO.CIDADE ||'-'||SELF.ENDERECO.UF||
       ' CEP: '||SELF.ENDERECO.CEP
       INTO retorno FROM DUAL;                     
       RETURN retorno;
    END getEndereco;
    
    MEMBER FUNCTION getFones RETURN VARCHAR2 AS
    retorno VARCHAR2(55);
    BEGIN      
       IF(SELF.TELEFONES IS NOT NULL)THEN
         retorno:='';   
         FOR I IN 1..SELF.TELEFONES.COUNT LOOP           
           retorno := retorno||SELF.TELEFONES(I).getTelefone||' ';                                 
         END LOOP;   
       ELSE
         retorno:='Nenhum';       
       END IF;        
       RETURN retorno;
    END getFones;
    
    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS 
    retorno VARCHAR2(15);
    BEGIN
       SELECT         
       ' Cod: '||TO_CHAR(SELF.COD)||
       ' Nome: '||TO_CHAR(SELF.NOME)||
       ' Endereço: '||SELF.getEndereco()||
       ' Fones: '||SELF.getFones()
       into retorno FROM DUAL;
       RETURN retorno;
    END getInfo;
    
    MAP MEMBER FUNCTION getCod RETURN number AS
    BEGIN       
       RETURN SELF.COD;
    END getCod;
    
    STATIC FUNCTION compare(obj1 TP_PESSOA, obj2 TP_PESSOA) RETURN BOOLEAN AS
    RESULTADO BOOLEAN;
    BEGIN
       RESULTADO := FALSE;
       IF(obj1.cod=obj2.cod)THEN
          RESULTADO:=TRUE;
       END IF;
       RETURN RESULTADO;            
    END compare;
    
END;

CREATE OR REPLACE TYPE BODY TP_FISICA AS
        
    OVERRIDING MEMBER FUNCTION getInfo RETURN VARCHAR2 AS 
    retorno VARCHAR2(555);
    BEGIN
       retorno:='';    
       retorno:= ' Cod: '||TO_CHAR(self.getCod())||
                 ' Nome: '||self.NOME||
                 ' CPF: '||SELF.CPF||
                 ' SEXO: '||SELF.SEXO||
                 ' Endereco: '||self.getEndereco()||
                 ' Fones: '||self.getFones();
       RETURN retorno;
    END getInfo;      
    
    STATIC FUNCTION compare(obj1 TP_FISICA, obj2 TP_FISICA) RETURN BOOLEAN AS
    RESULTADO BOOLEAN;
    BEGIN
       RESULTADO := FALSE;
       IF(obj1.cpf=obj2.cpf)THEN
          RESULTADO:=TRUE;
       END IF;
       RETURN RESULTADO;            
    END compare;
          

  CONSTRUCTOR FUNCTION TP_FISICA(CPF IN VARCHAR2, SEXO IN CHAR, NOME IN VARCHAR2, ENDLOGRADOURO IN ENDERECO.LOGRADOURO%TYPE, ENDNUMERO IN ENDERECO.NUMERO%TYPE, ENDBAIRRO IN ENDERECO.BAIRRO%TYPE, ENDCIDADE IN ENDERECO.CIDADE%TYPE, ENDUF IN ENDERECO.UF%TYPE, ENDCEP IN ENDERECO.CEP%TYPE) RETURN SELF AS RESULT AS 
  BEGIN              
      SELF.CPF:=CPF;
      SELF.SEXO:=SEXO;
      SELF.FOTO:=NULL;   
      
      SELF.COD:=SEQ_PESSOA.NEXTVAL;
      SELF.NOME:=NOME;
      SELF.ENDERECO:= NEW TP_ENDERECO(ENDLOGRADOURO,ENDNUMERO,ENDBAIRRO,ENDCIDADE,ENDUF,ENDCEP);  
      SELF.TELEFONES:=NULL; 
    
  RETURN;            
  END TP_FISICA;  
    

  CONSTRUCTOR FUNCTION TP_FISICA(CPF IN VARCHAR2, SEXO IN CHAR, NOME IN VARCHAR2, ENDERECO IN ENDERECO%TYPE, FONES IN ARRAY_TELEFONE) RETURN SELF AS RESULT AS 
  BEGIN                    
      SELF.CPF:=CPF;
      SELF.SEXO:=SEXO;
      SELF.FOTO:=NULL;
      
      SELF.COD:=SEQ_PESSOA.NEXTVAL;      
      SELF.NOME:=NOME;
      
      SELF.ENDERECO:=ENDERECO;
      SELF.TELEFONES:=FONES;       
  RETURN;            
  END TP_FISICA;
    
    
END;

CREATE OR REPLACE TYPE BODY TP_JURIDICA AS
        
    OVERRIDING MEMBER FUNCTION getInfo RETURN VARCHAR2 AS 
    retorno VARCHAR2(755);
    BEGIN
       SELECT                  
       ' Cod: '||TO_CHAR(SELF.getCod())||
       ' Nome do Responsável pela empresa: '||SELF.NOME||
       ' CNPJ: '||SELF.CNPJ||
       ' Razão social: '||SELF.RAZAOSOCIAL||
       ' Endereço: '||SELF.getEndereco()||
       ' Fones: '||SELF.getFones()       
       into retorno FROM DUAL;
       RETURN retorno;
    END getInfo;      
    
    STATIC FUNCTION compare(obj1 TP_JURIDICA, obj2 TP_JURIDICA) RETURN BOOLEAN AS
    RESULTADO BOOLEAN;
    BEGIN
       RESULTADO := FALSE;
       IF(obj1.cnpj=obj2.cnpj)THEN
          RESULTADO:=TRUE;
       END IF;
       RETURN RESULTADO;            
    END compare;
          
  
  CONSTRUCTOR FUNCTION TP_JURIDICA(CNPJ IN VARCHAR2, RAZAOSOCIAL IN VARCHAR2, NOME IN VARCHAR2, ENDLOGRADOURO IN ENDERECO.LOGRADOURO%TYPE, ENDNUMERO IN ENDERECO.NUMERO%TYPE, ENDBAIRRO IN ENDERECO.BAIRRO%TYPE, ENDCIDADE IN ENDERECO.CIDADE%TYPE, ENDUF IN ENDERECO.UF%TYPE, ENDCEP IN ENDERECO.CEP%TYPE) RETURN SELF AS RESULT AS 
  BEGIN              
      SELF.CNPJ:=CNPJ;
      SELF.RAZAOSOCIAL:=RAZAOSOCIAL;
      
      SELF.COD:=SEQ_PESSOA.NEXTVAL;
      SELF.NOME:=NOME;
      
      SELF.ENDERECO:= NEW TP_ENDERECO(ENDLOGRADOURO,ENDNUMERO,ENDBAIRRO,ENDCIDADE,ENDUF,ENDCEP);    
      SELF.TELEFONES:=NULL; 
    
  RETURN;            
  END TP_JURIDICA;  
    
  
  CONSTRUCTOR FUNCTION TP_JURIDICA(CNPJ IN VARCHAR2, RAZAOSOCIAL IN VARCHAR2, NOME IN VARCHAR2, ENDERECO IN ENDERECO%TYPE, FONES IN ARRAY_TELEFONE) RETURN SELF AS RESULT AS 
  BEGIN              
      --SELF.TP_PESSOA(NOME,ENDERECO,FONES);
      SELF.CNPJ:=CNPJ;
      SELF.RAZAOSOCIAL:=RAZAOSOCIAL;
      
      
      SELF.COD:=SEQ_PESSOA.NEXTVAL;      
      SELF.NOME:=NOME;
      SELF.ENDERECO:=ENDERECO;
      SELF.TELEFONES:=FONES;       
  RETURN;            
  END TP_JURIDICA;
    
    
END;


create or replace TYPE BODY TP_CLIENTE AS

    MEMBER FUNCTION eBaixaRenda RETURN VARCHAR2 AS
    retorno VARCHAR2(555);
    BEGIN
       IF ((SELF.RENDA IS NOT NULL) AND SELF.RENDA<=700.00)THEN
          retorno:='É cliente de baixa renda.';
       ELSE
          retorno:='Não é cliente de baixa renda.';
       END IF;
       RETURN retorno;
    END eBaixaRenda;   
    
    
    MEMBER FUNCTION getRenda RETURN VARCHAR2 AS
    retorno VARCHAR2(555);
    BEGIN    
        IF(SELF.RENDA IS NOT NULL)THEN
         retorno:=TO_CHAR(SELF.RENDA);
        ELSE
         retorno:='Nenhuma renda declarada';
        END IF;        
       RETURN retorno;
    END getRenda;   
        
    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS 
    retorno VARCHAR2(855);
    BEGIN
       SELECT                  
       ' Código do Cliente: '||TO_CHAR(SELF.COD)||
       ' Data de Cadastro: '||TO_CHAR(SELF.DATAREGISTRO,'DDMMYYYY')||
       ' Renda declarada: '||SELF.getRenda()||
       ' ('||SELF.eBaixaRenda()||') '||
       ' Dados do cliente: '||(DEREF(SELF.REF_CLIENTE).getInfo())
       into retorno FROM DUAL;
       RETURN retorno;
    END getInfo;  
    
    ORDER MEMBER FUNCTION equals(obj TP_CLIENTE) RETURN NUMBER AS
    BEGIN
      RETURN  (SELF.COD  - obj.COD);-- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
    END equals;
        
    STATIC FUNCTION compare(obj1 TP_CLIENTE, obj2 TP_CLIENTE) RETURN BOOLEAN AS
    retorno BOOLEAN;  
    BEGIN    
    
      retorno:=false;
  
      IF(TO_CHAR(obj1.COD)=TO_CHAR(obj2.COD))THEN      
        retorno:=true;     
      ELSE
         retorno:=false;
      END IF;
            
      RETURN retorno;
    END compare;


    CONSTRUCTOR FUNCTION TP_CLIENTE(CPF_CNPJ IN VARCHAR2) RETURN SELF AS RESULT AS    
    refCliente REF TP_PESSOA;
    codPessoa number;
    v_cpf_cnpj varchar2(14);
    BEGIN
      v_cpf_cnpj:=cpf_cnpj;
      IF(valida_cpf(v_cpf_cnpj)='SIM')THEN
          SELECT REF(PF), PF.cod INTO refCliente, codPessoa FROM TB_FISICA PF WHERE PF.CPF=v_cpf_cnpj;             
      ELSIF(valida_cnpj(v_cpf_cnpj)='SIM')THEN
          SELECT REF(PJ), PJ.cod INTO refCliente, codPessoa FROM TB_JURIDICA PJ WHERE PJ.CNPJ=v_cpf_cnpj;      
      END IF;
              
      SELF.COD:=codPessoa;      
      SELF.REF_CLIENTE:=refCliente;
      SELF.DATAREGISTRO:=SYSDATE;
      SELF.RENDA:=NULL;
            
      RETURN; 
    END TP_CLIENTE;      
    
            
    CONSTRUCTOR FUNCTION TP_CLIENTE(CPF IN VARCHAR2, RENDA IN NUMBER) RETURN SELF AS RESULT AS    
    refClientePessoaFisica REF TP_FISICA;
    codPessoa number;
    v_cpf varchar2(11);
    BEGIN
      v_cpf:=cpf;
      SELECT REF(PF), PF.COD INTO refClientePessoaFisica, codPessoa 
      FROM TB_FISICA PF WHERE PF.CPF=v_cpf;
                    
      SELF.COD:=codPessoa;      
      SELF.REF_CLIENTE:=refClientePessoaFisica;
      SELF.DATAREGISTRO:=SYSDATE;
      SELF.RENDA:=RENDA;
            
      RETURN; 
    END TP_CLIENTE;      
        
END;

create or replace TYPE BODY TP_CARGO AS
     
    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS 
    retorno VARCHAR2(855);
    BEGIN
       SELECT                  
       ' Código do Cargo: '||TO_CHAR(SELF.COD)||       
       ' Descricao: '||(SELF.descricao)
       into retorno FROM DUAL;
       RETURN retorno;
    END getInfo;  
    
    ORDER MEMBER FUNCTION equals(obj TP_CARGO) RETURN NUMBER AS
    BEGIN
      RETURN  (SELF.COD  - obj.COD);-- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
    END equals;
        
    STATIC FUNCTION compare(obj1 TP_CARGO, obj2 TP_CARGO) RETURN BOOLEAN AS
    retorno BOOLEAN;  
    BEGIN        
    
      retorno:=false;  
      
      IF(TO_CHAR(obj1.COD)=TO_CHAR(obj2.COD)or(obj1.descricao=obj2.descricao))THEN      
        retorno:=true;     
      ELSE
        retorno:=false;
      END IF;
            
      RETURN retorno;
    END compare;
              
    CONSTRUCTOR FUNCTION TP_CARGO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT AS    
    BEGIN      
      SELF.COD:=SEQ_CARGO.NEXTVAL;        
      SELF.DESCRICAO:=DESCRICAO;          
      RETURN; 
    END TP_CARGO;      
        
END;

create or replace TYPE BODY TP_SETOR AS
     
    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS 
    retorno VARCHAR2(855);
    BEGIN
       SELECT                  
       ' Código do Setor: '||TO_CHAR(SELF.COD)||       
       ' Descrição: '||(SELF.descricao)
       into retorno FROM DUAL;
       RETURN retorno;
    END getInfo;  
    
    ORDER MEMBER FUNCTION equals(obj TP_SETOR) RETURN NUMBER AS
    BEGIN
      RETURN  (SELF.COD  - obj.COD);-- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
    END equals;
        
    STATIC FUNCTION compare(obj1 TP_SETOR, obj2 TP_SETOR) RETURN BOOLEAN AS
    retorno BOOLEAN;  
    BEGIN        
    
      retorno:=false;  
      
      IF(TO_CHAR(obj1.COD)=TO_CHAR(obj2.COD)or(obj1.descricao=obj2.descricao))THEN      
        retorno:=true;     
      ELSE
        retorno:=false;
      END IF;
            
      RETURN retorno;
    END compare;
              

    CONSTRUCTOR FUNCTION TP_SETOR(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT AS    
    BEGIN      
      SELF.COD:=SEQ_SETOR.NEXTVAL;        
      SELF.DESCRICAO:=DESCRICAO;          
      RETURN; 
    END TP_SETOR;      
        
END;


create or replace TYPE BODY TP_JORNADA AS
     
    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS 
    retorno VARCHAR2(855);
    BEGIN
       SELECT                  
       ' Código do Jornada: '||TO_CHAR(SELF.COD)||       
       ' Descrição: '||(SELF.descricao)||
       ' Horário inicio: '||TO_CHAR((SELF.horainicio),'HH24:MI:SS')||
       ' Horário fim: '||TO_CHAR((SELF.horafim),'HH24:MI:SS')
       into retorno FROM DUAL;
       RETURN retorno;
    END getInfo;  
    
    ORDER MEMBER FUNCTION equals(obj TP_JORNADA) RETURN NUMBER AS
    BEGIN
      RETURN  (SELF.COD  - obj.COD);-- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
    END equals;
        
    STATIC FUNCTION compare(obj1 TP_JORNADA, obj2 TP_JORNADA) RETURN BOOLEAN AS
    retorno BOOLEAN;  
    BEGIN        
    
      retorno:=false;  
      
      IF(TO_CHAR(obj1.COD)=TO_CHAR(obj2.COD)or(obj1.descricao=obj2.descricao))THEN      
        retorno:=true;     
      ELSE
        retorno:=false;
      END IF;
            
      RETURN retorno;
    END compare;
              

    CONSTRUCTOR FUNCTION TP_JORNADA(DESCRICAO IN VARCHAR2, HORAINICIO IN interval day to second, HORAFIM IN interval day to second) RETURN SELF AS RESULT AS    
    BEGIN      
      SELF.COD:=SEQ_JORNADA.NEXTVAL;        
      SELF.DESCRICAO:=DESCRICAO;          
      SELF.HORAINICIO:=HORAINICIO;          
      SELF.HORAFIM:=HORAFIM;          
      RETURN; 
    END TP_JORNADA;      
        
END;


create or replace TYPE BODY TP_GRATIFICACAO AS
     
    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS 
    retorno VARCHAR2(155);
    BEGIN
       SELECT                  
       ' Período: '||TO_CHAR(SELF.PERIODO,'MMYYYY')||       
       ' Valor: '||(SELF.VALOR)
       into retorno FROM DUAL;
       RETURN retorno;
    END getInfo;  
          
    CONSTRUCTOR FUNCTION TP_GRATIFICACAO(PERIODO IN DATE, VALOR IN NUMBER) RETURN SELF AS RESULT AS    
    BEGIN      
      SELF.PERIODO:=PERIODO;        
      SELF.VALOR:=VALOR;          
      RETURN; 
    END TP_GRATIFICACAO;      
        
END;

create or replace TYPE BODY TP_FUNCIONARIO AS

    MEMBER FUNCTION getSumAllGratificacoes RETURN NUMBER AS
      cont integer;      
      total number(8,2);
    BEGIN
      total:=0;
      
      IF(SELF.GRATIFICACOES is not null)THEN          
        FOR cont in 1..SELF.GRATIFICACOES.COUNT LOOP          
          Total := Total + SELF.GRATIFICACOES(CONT).valor;     
        END LOOP;
      END IF;
    
      RETURN total;
    END getSumAllGratificacoes;
    
    MEMBER FUNCTION getTotGratificacoesByAno(ano in integer) RETURN NUMBER AS      
      total number(8,2);
    BEGIN
      total:=0;
      
      IF(SELF.GRATIFICACOES is not null AND UTL_COLL.IS_LOCATOR(SELF.GRATIFICACOES))THEN     
      
        SELECT SUM(G.VALOR) INTO Total FROM   TABLE(CAST(self.gratificacoes AS NESTED_GRATIFICACAO)) G
        where to_char(G.PERIODO,'YYYY')=to_char(ano); --ORDER BY G.PERIODO;      
        
      END IF;
    
      RETURN total;
    END getTotGratificacoesByAno;
    
    MEMBER FUNCTION getTotGratificacoesByPeriodo(dataIni in date, dataFim in date) RETURN NUMBER AS        
      total number(8,2);
    BEGIN
      total:=0;
      
      IF(SELF.GRATIFICACOES is not null AND UTL_COLL.IS_LOCATOR(SELF.GRATIFICACOES))THEN     
      
        SELECT SUM(G.VALOR) INTO Total FROM   TABLE(CAST(self.gratificacoes AS NESTED_GRATIFICACAO)) G
        where to_char(G.PERIODO,'DDMMYYYY') BETWEEN to_char(DATAINI,'DDMMYYYY') AND to_char(DATAFIM,'DDMMYYYY');
        --ORDER BY G.PERIODO;
      
      END IF;
    
      RETURN total;
    END getTotGratificacoesByPeriodo;
    
    
    MEMBER FUNCTION getTotGratificacoesByMesAno(mes in integer,ano in integer) RETURN NUMBER AS  
      total number(8,2);
      mesAno varchar2(8);    
    BEGIN
      total:=0;
      
      IF(SELF.GRATIFICACOES is not null AND UTL_COLL.IS_LOCATOR(SELF.GRATIFICACOES))THEN     
      
        mesAno:=to_char(MES)||''||to_char(ANO);
        SELECT SUM(G.VALOR) INTO Total FROM   TABLE(CAST(self.gratificacoes AS NESTED_GRATIFICACAO)) G 
        WHERE to_char(G.PERIODO,'MMYYYY')=mesAno; --ORDER BY L.PERIODO;
      
      END IF;
    
      RETURN total;
    END getTotGratificacoesByMesAno;


    MEMBER FUNCTION getCargo RETURN VARCHAR2 AS
    retorno VARCHAR2(455);
    BEGIN
    
       SELECT DEREF(F.REF_CARGO).getInfo() into retorno FROM TB_FUNCIONARIO F 
       where self.matricula=f.matricula;       
                         
       RETURN retorno;
    END getCargo;   
    
    MEMBER FUNCTION getStatus RETURN VARCHAR2 AS
    retorno VARCHAR2(25);
    BEGIN
       
       if(self.status='A')then
        retorno:='Ativo';
       else
        retorno:='Inativo';
       end if;
       
       RETURN retorno;
    END getStatus;   
    
    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS
    retorno VARCHAR2(1255);
    INFOFUNC VARCHAR(550);
    BEGIN
    
       select DEREF(F.REF_PESSOAFISICA).getInfo() INTO INFOFUNC from TB_FUNCIONARIO F WHERE F.MATRICULA=SELF.MATRICULA;
       
       retorno:=' Data de Admissão: '||to_char(self.dataadmisao,'DDMMYYYY');
       retorno:=retorno||' Matrícula: '||to_char(self.matricula);
       retorno:=retorno||' Salário: '||to_char(self.salario);
       retorno:=retorno||' Status: '||to_char(self.getStatus());
       retorno:=retorno||' Dados do funcionário: '||INFOFUNC;            
       
       RETURN retorno;
    END getInfo; 
    
    
     MEMBER FUNCTION getInfoResumida RETURN VARCHAR2 AS
    retorno VARCHAR2(1255);
    NOMEFUNC VARCHAR2(50);
    BEGIN
    
       SELECT DEREF(F.REF_PESSOAFISICA).nome INTO NOMEFUNC FROM TB_FUNCIONARIO F WHERE F.MATRICULA=self.matricula;              
       retorno:=' Matrícula: '||to_char(self.matricula)||' Nome do funcionário: '||NOMEFUNC;
                                                            
       RETURN retorno;
    END getInfoResumida; 
    
    MEMBER FUNCTION getInfoSupervisor RETURN VARCHAR2 AS
     retorno VARCHAR2(1255);
     INFOSUPERVISOR VARCHAR2(550);
    BEGIN    
       SELECT DEREF(F.REF_SUPERVISOR).getInfo() INTO INFOSUPERVISOR FROM TB_FUNCIONARIO F WHERE F.MATRICULA=SELF.MATRICULA;
       retorno:=' Dados do supervisor: '||INFOSUPERVISOR;                              
       RETURN retorno;
    END getInfoSupervisor; 
    
    MEMBER FUNCTION possuiSupervisor RETURN BOOLEAN AS
    retorno BOOLEAN;
    
    REFFUNC REF TP_FUNCIONARIO;
    BEGIN    
        
      SELECT REF(F)  INTO REFFUNC 
      FROM TB_FUNCIONARIO F WHERE F.MATRICULA=SELF.MATRICULA AND (F.REF_SUPERVISOR IS NOT DANGLING);
      
      IF(SELF.REF_SUPERVISOR IS NOT NULL AND REFFUNC IS NOT NULL)THEN        
         RETORNO:=TRUE;
      ELSE
         RETORNO:=FALSE;
      END IF;          
     RETURN RETORNO; 
    END possuiSupervisor; 
    
    
    MEMBER FUNCTION getFuncioariosSupervisionados RETURN varchar2 AS
    retorno varchar2(2855);    
    cont number; 
    CURSOR C_FSUPERVISIONADOS IS SELECT F.getInfoResumida() AS FUNC  from TB_FUNCIONARIO F
    WHERE (F.REF_SUPERVISOR IS NOT DANGLING AND F.REF_SUPERVISOR IS NOT NULL 
    AND SELF.MATRICULA=DEREF(F.REF_SUPERVISOR).MATRICULA) ORDER BY (DEREF(F.REF_PESSOAFISICA).NOME);
    
    V_FSUPERVISIONADOS C_FSUPERVISIONADOS%ROWTYPE;
    
    
    
    BEGIN    
      RETORNO:='';         
      CONT:=0;          
      FOR V_FSUPERVISIONADOS IN C_FSUPERVISIONADOS LOOP      
        CONT:=CONT+1;
        RETORNO:=RETORNO||' Funcionário supervisionado '||to_char(cont);        
        RETORNO:=RETORNO||'ª - '||V_FSUPERVISIONADOS.FUNC;        
      END LOOP;            
        
     RETURN RETORNO; 
    END getFuncioariosSupervisionados;
    
    
    MAP MEMBER FUNCTION getMatricula RETURN number AS    
    BEGIN  
        return SELF.matricula;
    END getMatricula; 
    
    
    STATIC FUNCTION compare(obj1 TP_FUNCIONARIO, obj2 TP_FUNCIONARIO) RETURN BOOLEAN AS
    retorno BOOLEAN;  
    BEGIN        
      retorno:=false;  
      IF(TO_CHAR(obj1.MATRICULA)=TO_CHAR(obj2.MATRICULA))THEN      
        retorno:=true;     
      ELSE
         retorno:=false;
      END IF;            
      RETURN retorno;
    END compare;
                  
END;


create or replace TYPE BODY TP_HISTORICO_SETOR_FUNCIONARIO AS   

    STATIC  FUNCTION getHistoricoFuncionario(matricula in number) RETURN varchar2 AS            
      RETORNO VARCHAR2(32767);
      CURSOR C_HISTFUN IS SELECT 
      to_char(H.DATAENTRADA,'DDMMYYYY HH:MI:SS') AS ENTRADA, 
      DEREF(H.REF_SETOR).DESCRICAO AS SETOR, 
      to_char(DEREF(H.REF_FUNCIONARIO).MATRICULA) AS MATRICULA,
      H.ref_jornada.getInfo() as JORNADA
      FROM TB_HISTORICO_SETOR_FUNCIONARIO H WHERE DEREF(H.REF_FUNCIONARIO).MATRICULA=MATRICULA  ORDER BY H.DATAENTRADA DESC;
      
    V_HISTFUN C_HISTFUN%ROWTYPE;
    BEGIN      
      RETORNO:='Matricula: '||to_char(matricula)||chr(13);      
      
      FOR V_HISTFUN IN C_HISTFUN LOOP      
        RETORNO:=RETORNO||' Setor: '||V_HISTFUN.setor||' Data de entrada: '||V_HISTFUN.entrada||chr(13);
        RETORNO:=RETORNO||' Setor: '||V_HISTFUN.setor||' Data de entrada: '||V_HISTFUN.entrada||chr(13);
        RETORNO:=RETORNO||V_HISTFUN.JORNADA||chr(13);
      END LOOP;
            
      RETURN RETORNO;
    END getHistoricoFuncionario;
    
    
    STATIC  FUNCTION getSetorRecenteFuncionario(P_matricula in NUMBER) RETURN varchar2 AS      
       SETORRECENTE VARCHAR2(32767);          
       JORNADA VARCHAR2(32767);          
    BEGIN                    
      SELECT  
      -- to_char(H.DATAENTRADA,'DDMMYYYY HH:MI:SS') AS ENTRADA, 
      DEREF(H.REF_SETOR).DESCRICAO AS SETOR,
      H.REF_JORNADA.getInfo()
      --, to_char(DEREF(H.REF_FUNCIONARIO).MATRICULA) AS MATRICULA
      INTO SETORRECENTE, JORNADA
      FROM TB_HISTORICO_SETOR_FUNCIONARIO H WHERE DEREF(H.REF_FUNCIONARIO).MATRICULA=P_matricula  
      AND  H.DATAENTRADA=(SELECT MAX(H2.DATAENTRADA) AS ULTIMADTENTRADA FROM TB_HISTORICO_SETOR_FUNCIONARIO H2 WHERE DEREF(H2.REF_FUNCIONARIO).MATRICULA=P_matricula);
      
      IF(SETORRECENTE IS NOT NULL)THEN
         SETORRECENTE:='Setor recente: '||to_char(SETORRECENTE)||CHR(13);  
         SETORRECENTE:=SETORRECENTE||JORNADA;
      ELSE
         SETORRECENTE:='Setor recente: <nenhum>';  
      END IF;
            
      RETURN SETORRECENTE;
    END getSetorRecenteFuncionario;
    
 
    STATIC FUNCTION getFuncionariosDoSetor(descSetor in varchar2) RETURN varchar2 AS      
    RETORNO VARCHAR2(32767);
    CURSOR C_HISTFUNSETOR IS --pega os funcionarios de um dado setor
      SELECT DISTINCT
        deref(H.REF_FUNCIONARIO).MATRICULA AS MATRICULA,                
        deref(deref(H.REF_FUNCIONARIO).REF_PESSOAFISICA).NOME AS FUNCIONARIO,
        to_char(H.DATAENTRADA,'DDMMYYYY HH:MI:SS') AS ENTRADA
      FROM 
        TB_HISTORICO_SETOR_FUNCIONARIO H
      WHERE 
       DEREF(H.REF_SETOR).DESCRICAO=descSetor 
       AND  H.DATAENTRADA=( SELECT MAX(H2.DATAENTRADA) AS ULTIMADTENTRADA
                            FROM TB_HISTORICO_SETOR_FUNCIONARIO H2 
                            WHERE 
                             DEREF(H2.REF_FUNCIONARIO).MATRICULA=DEREF(H.REF_FUNCIONARIO).MATRICULA 
                             --AND DEREF(H2.REF_SETOR).DESCRICAO=descSetor
                           );
                    
    V_HISTFUNSETOR C_HISTFUNSETOR%ROWTYPE;
    BEGIN      
      RETORNO:='Setor: '||descSetor||chr(13);      
      
      FOR V_HISTFUNSETOR IN C_HISTFUNSETOR LOOP      
        RETORNO:=RETORNO||' Matrícula: '||V_HISTFUNSETOR.matricula||' Funcionário: '||V_HISTFUNSETOR.funcionario||chr(13)||
        ' Data de entrada: '||V_HISTFUNSETOR.entrada||chr(13);
      END LOOP;
            
      RETURN RETORNO;
    END getFuncionariosDoSetor;
    
    
    ORDER MEMBER FUNCTION equals(obj TP_HISTORICO_SETOR_FUNCIONARIO) RETURN NUMBER AS
    COD INTEGER;
    BEGIN        
    IF(SELF.DATAENTRADA=OBJ.DATAENTRADA)THEN
       COD:=0;--IGUAL
    ELSIF(SELF.DATAENTRADA>OBJ.DATAENTRADA)THEN
       COD:=-1;--DATA DO OBJETO É MENOR
    ELSE
       COD:=1;--DATA DO OBJETO É MAIOR
    END IF;         
      RETURN  COD;-- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
    END equals;
        
    STATIC FUNCTION compare(obj1 TP_HISTORICO_SETOR_FUNCIONARIO, obj2 TP_HISTORICO_SETOR_FUNCIONARIO) RETURN BOOLEAN AS
    retorno BOOLEAN;  
    BEGIN        
      retorno:=false;  
      IF(TO_CHAR(obj1.DATAENTRADA,'DDMMYYYY HH:MI:SS')=TO_CHAR(obj2.DATAENTRADA,'DDMMYYYY HH:MI:SS'))THEN      
        retorno:=true;     
      ELSE
         retorno:=false;
      END IF;            
      RETURN retorno;
    END compare;
    
     
    CONSTRUCTOR FUNCTION TP_HISTORICO_SETOR_FUNCIONARIO(matricula IN number, descSetor IN varchar2,descjornada in varchar2)  RETURN SELF AS RESULT AS          
    refSetor REF TP_SETOR;
    refFuncionario REF TP_Funcionario; 
    refJornada REF TP_Jornada; 
    v_matricula number;
    BEGIN
      v_matricula := matricula;
      SELF.DATAENTRADA:=SYSTIMESTAMP;
      
      select ref(s) into refSetor from tb_setor s where s.descricao=descSetor;
      SELF.REF_SETOR:=refSetor;
      
      select ref(f) into refFuncionario from tb_funcionario f where f.matricula=v_matricula;
      SELF.REF_FUNCIONARIO:=refFuncionario;
      
      select ref(j) into refJornada from tb_jornada j where j.descricao=descJornada;
      SELF.REF_JORNADA:=refJornada;
               
      RETURN; 
    END TP_HISTORICO_SETOR_FUNCIONARIO;      
    
                  
    CONSTRUCTOR FUNCTION TP_HISTORICO_SETOR_FUNCIONARIO(matricula IN number, descSetor IN varchar2, descjornada in varchar2, momentoEntrada in timestamp) RETURN SELF AS RESULT AS    
    refSetor REF TP_SETOR;
    refFuncionario REF TP_Funcionario; 
    refJornada REF TP_Jornada; 
     v_matricula number;
    BEGIN
      v_matricula:=matricula;
      SELF.DATAENTRADA:=momentoEntrada;
      
      select ref(s) into refSetor from tb_setor s where s.descricao=descSetor;
      SELF.REF_SETOR:=refSetor;
      
      select ref(f) into refFuncionario from tb_funcionario f where f.matricula=v_matricula;
      SELF.REF_FUNCIONARIO:=refFuncionario;
      
      select ref(j) into refJornada from tb_jornada j where j.descricao=descJornada;
      SELF.REF_JORNADA:=refJornada;
               
      RETURN; 
    END TP_HISTORICO_SETOR_FUNCIONARIO;
    
END;


create or replace TYPE BODY TP_TIPOSERVICO AS


    MEMBER FUNCTION getDescricao RETURN VARCHAR2 AS 
    retorno VARCHAR2(855);
    BEGIN
       SELECT                  
               SELF.descricao
       into retorno FROM DUAL;
       RETURN retorno;
    END getDescricao;  
     
    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS 
    retorno VARCHAR2(855);
    BEGIN
       SELECT                  
       ' Código do Tipo do Serviço: '||TO_CHAR(SELF.COD)||       
       ' Descrição: '||(SELF.descricao)
       into retorno FROM DUAL;
       RETURN retorno;
    END getInfo;  
    
    ORDER MEMBER FUNCTION equals(obj TP_TIPOSERVICO) RETURN NUMBER AS
    BEGIN
      RETURN  (SELF.COD  - obj.COD);-- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
    END equals;
        
    STATIC FUNCTION compare(obj1 TP_TIPOSERVICO, obj2 TP_TIPOSERVICO) RETURN BOOLEAN AS
    retorno BOOLEAN;  
    BEGIN        
    
      retorno:=false;  
      
      IF(TO_CHAR(obj1.COD)=TO_CHAR(obj2.COD)or(obj1.descricao=obj2.descricao))THEN      
        retorno:=true;     
      ELSE
        retorno:=false;
      END IF;
            
      RETURN retorno;
    END compare;
              

    CONSTRUCTOR FUNCTION TP_TIPOSERVICO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT AS    
    BEGIN      
      SELF.COD:=SEQ_TIPOSERVICO.NEXTVAL;        
      SELF.DESCRICAO:=DESCRICAO;          
      RETURN; 
    END TP_TIPOSERVICO;      
        
END;



create or replace TYPE BODY TP_SERVICO AS
     
    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS 
    retorno VARCHAR2(1855);
    BEGIN
       SELECT                  
       ' Código do Serviço: '||TO_CHAR(SELF.COD)||       
       ' Descrição: '||(SELF.descricao)||
       ' Valor: '||to_char(SELF.valor)||
       ' Tipo: '||deref(SELF.REF_TIPOSERVICO).getDescricao()
       into retorno FROM DUAL;
       RETURN retorno;
    END getInfo;  
    
    ORDER MEMBER FUNCTION equals(obj TP_SERVICO) RETURN NUMBER AS
    BEGIN
      RETURN  (SELF.COD  - obj.COD);-- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
    END equals;
        
    STATIC FUNCTION compare(obj1 TP_SERVICO, obj2 TP_SERVICO) RETURN BOOLEAN AS
    retorno BOOLEAN;  
    BEGIN        
    
      retorno:=false;  
      
      IF(TO_CHAR(obj1.COD)=TO_CHAR(obj2.COD)or(obj1.descricao=obj2.descricao))THEN      
        retorno:=true;     
      ELSE
        retorno:=false;
      END IF;
            
      RETURN retorno;
    END compare;
              
    CONSTRUCTOR FUNCTION TP_SERVICO(DESCRICAO IN VARCHAR2, valor in number, descTipo in varchar2) RETURN SELF AS RESULT AS    
    BEGIN      
      SELF.COD:=SEQ_SERVICO.NEXTVAL;        
      SELF.DESCRICAO:=DESCRICAO;   
      self.valor:=valor;
      select ref(ts) into self.ref_tiposervico from tb_tiposervico ts where ts.descricao=descTipo;
      RETURN; 
    END TP_SERVICO;      
        
END;

create or replace TYPE BODY TP_DESCONTO AS


    MEMBER FUNCTION getDescricao RETURN VARCHAR2 AS 
    retorno VARCHAR2(855);
    BEGIN
       SELECT                  
               SELF.descricao
       into retorno FROM DUAL;
       RETURN retorno;
    END getDescricao;  
     
    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS 
    retorno VARCHAR2(855);
    BEGIN
       SELECT                         
       ' Descrição: '||(SELF.descricao)||
       ' Valor: '||to_char(SELF.valor)
       into retorno FROM DUAL;
       RETURN retorno;
    END getInfo;  
    
    ORDER MEMBER FUNCTION equals(obj TP_DESCONTO) RETURN NUMBER AS
    BEGIN
      RETURN  (SELF.COD  - obj.COD);-- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
    END equals;
        
    STATIC FUNCTION compare(obj1 TP_DESCONTO, obj2 TP_DESCONTO) RETURN BOOLEAN AS
    retorno BOOLEAN;  
    BEGIN        
    
      retorno:=false;  
      
      IF(TO_CHAR(obj1.COD)=TO_CHAR(obj2.COD)or(obj1.descricao=obj2.descricao)or(obj1.valor=obj2.valor))THEN      
        retorno:=true;     
      ELSE
        retorno:=false;
      END IF;
            
      RETURN retorno;
    END compare;
              
    CONSTRUCTOR FUNCTION TP_DESCONTO(DESCRICAO IN VARCHAR2, valor in number) RETURN SELF AS RESULT AS    
    BEGIN      
      SELF.COD:=SEQ_DESCONTO.NEXTVAL;        
      SELF.DESCRICAO:=DESCRICAO;          
      SELF.VALOR:=VALOR;
      RETURN; 
    END TP_DESCONTO;      
        
END;

create or replace TYPE BODY TP_LIVRO AS


    MEMBER FUNCTION getDescricao RETURN VARCHAR2 AS 
    retorno VARCHAR2(855);
    BEGIN
       SELECT                  
               SELF.descricao
       into retorno FROM DUAL;
       RETURN retorno;
    END getDescricao;  
     
    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS 
    retorno VARCHAR2(855);
    BEGIN
       SELECT                         
       ' Descrição: '||(SELF.descricao)
       into retorno FROM DUAL;
       RETURN retorno;
    END getInfo;  
    
    ORDER MEMBER FUNCTION equals(obj TP_LIVRO) RETURN NUMBER AS
    BEGIN
      RETURN  (SELF.COD  - obj.COD);-- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
    END equals;
        
    STATIC FUNCTION compare(obj1 TP_LIVRO, obj2 TP_LIVRO) RETURN BOOLEAN AS
    retorno BOOLEAN;  
    BEGIN        
    
      retorno:=false;  
      
      IF(TO_CHAR(obj1.COD)=TO_CHAR(obj2.COD)or(obj1.descricao=obj2.descricao))THEN      
        retorno:=true;     
      ELSE
        retorno:=false;
      END IF;
            
      RETURN retorno;
    END compare;
              
    CONSTRUCTOR FUNCTION TP_LIVRO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT AS    
    BEGIN      
      SELF.COD:=SEQ_LIVRO.NEXTVAL;        
      SELF.DESCRICAO:=DESCRICAO;          
      RETURN; 
    END TP_LIVRO;      
        
END;

create or replace TYPE BODY TP_ATENDIMENTO AS

    MEMBER FUNCTION getValorTotalAtendimento RETURN NUMBER AS
    pragma autonomous_transaction;
      V_TOTALATENDIMENTO NUMBER(8,2);
    BEGIN    
        SELECT SUM(SA.VALORSERVICOREALIZADO) AS TOTAL INTO V_TOTALATENDIMENTO FROM TB_SERVICODOATENDIMENTO SA
        WHERE SA.REF_ATENDIMENTO.COD=SELF.COD;
        
        IF(V_TOTALATENDIMENTO IS NULL)THEN
         V_TOTALATENDIMENTO:=0;
        END IF;
        
        COMMIT;
        RETURN V_TOTALATENDIMENTO;        
    END getValorTotalAtendimento;

    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS
     retorno VARCHAR2(32767);
     INFOCLIENTE VARCHAR(32767);
     INFOATENDENTE VARCHAR(32767);
     v_totAtendimento number(8,2);
    BEGIN
    
       select 
       DEREF(TA.REF_ATENDENTE).getInfoResumida(), DEREF(TA.REF_CLIENTE).getInfo(), TA.getValorTotalAtendimento() 
       INTO INFOATENDENTE, INFOCLIENTE, v_totAtendimento from TB_ATENDIMENTO TA WHERE TA.COD=SELF.COD;
       
       retorno:='Código do Atendimento: '||to_char(self.cod)||
       '  Data do Atendimento: '||to_char(self.dataatendimento,'DDMMYYYY')||chr(13);
       retorno:=retorno||' Atendente: '||INFOATENDENTE||chr(13);
       retorno:=retorno||' Cliente: '||INFOCLIENTE||chr(13);
       retorno:=retorno||' Valor Total: '||to_char(v_totAtendimento);            
       
       RETURN retorno;
    END getInfo; 
    
    
    MEMBER FUNCTION getAtendente RETURN VARCHAR2 AS    
    V_NOMEATENDENTE VARCHAR2(450);
    BEGIN
      select DEREF(TA.REF_ATENDENTE.REF_PESSOAFISICA).NOME AS NOMEATENDENTE INTO V_NOMEATENDENTE from TB_ATENDIMENTO TA 
      WHERE TA.COD=SELF.COD;    
      RETURN V_NOMEATENDENTE;
    END getAtendente;
    
    MEMBER FUNCTION getCliente RETURN VARCHAR2 AS    
    V_NOMECLIENTE VARCHAR2(450);
    BEGIN
      select DEREF(TA.REF_CLIENTE.REF_CLIENTE).NOME AS NOMECLIENTE INTO V_NOMECLIENTE from TB_ATENDIMENTO TA WHERE TA.COD=SELF.COD;    
      RETURN V_NOMECLIENTE;
    END getCliente;  
    
    MAP MEMBER FUNCTION getCod RETURN number AS    
    BEGIN  
        return SELF.COD;
    END getCod; 
    
    
    STATIC FUNCTION compare(obj1 TP_ATENDIMENTO, obj2 TP_ATENDIMENTO) RETURN BOOLEAN AS
    retorno BOOLEAN;  
    BEGIN        
      retorno:=false;  
      IF(TO_CHAR(obj1.COD)=TO_CHAR(obj2.COD))THEN      
        retorno:=true;     
      ELSE
         retorno:=false;
      END IF;            
      RETURN retorno;
    END compare;


    --construtor para cadastrar um FUNCIONARIO SEM GRATIFICACOES E SEM SUPERVISOR   
    CONSTRUCTOR FUNCTION TP_ATENDIMENTO(v_cpf_cnpjCliente IN VARCHAR2, v_cpfFuncionarioAtendente IN varchar2) RETURN SELF AS RESULT AS              
    dataatendimento_invalido exception;
    BEGIN
    
        SELF.DATAATENDIMENTO:=SYSTIMESTAMP;
        SELF.COD:=SEQ_ATENDIMENTO.NEXTVAL;
        SELF.VALORTOTAL:=0.0;
        
        IF(VALIDA_CNPJ(v_cpf_cnpjCliente)='SIM')THEN
            --PEGA SOMENTE O CLIENTE PESSOA JURIDICA
            SELECT REF(CA) INTO SELF.REF_CLIENTE FROM TB_CLIENTE CA 
            WHERE (DEREF(CA.REF_CLIENTE)IS OF(ONLY TP_JURIDICA)) AND (TREAT(DEREF(CA.REF_CLIENTE) AS TP_JURIDICA).CNPJ=v_cpf_cnpjCliente);
        ELSIF(VALIDA_CPF(v_cpf_cnpjCliente)='SIM') THEN
            --PEGA SOMENTE O CLIENTE PESSOA FISICA
            SELECT REF(CA) INTO SELF.REF_CLIENTE FROM TB_CLIENTE CA 
            WHERE (DEREF(CA.REF_CLIENTE)IS OF(ONLY TP_FISICA)) AND (TREAT(DEREF(CA.REF_CLIENTE) AS TP_FISICA).CPF=v_cpf_cnpjCliente);
        END IF;
   
        SELECT REF(AA) INTO SELF.REF_ATENDENTE FROM TB_FUNCIONARIO AA 
        WHERE AA.REF_PESSOAFISICA.CPF=v_cpfFuncionarioAtendente AND AA.REF_CARGO.DESCRICAO='Atendente';  
        
        if(SELF.REF_ATENDENTE IS NULL)then
                  RAISE_APPLICATION_ERROR(-20011, 'Funcionário inválido! Informe um funcionário com o cargo de atendente válido para atender o cliente no cartório!');
            elsif(SELF.REF_CLIENTE IS NULL)then                                  
                  RAISE_APPLICATION_ERROR(-20012, 'Cliente inválido! Informe um cliente com cpf ou cnpj válido cadastrado no cartório!');
            elsif(self.dataatendimento is null)then   
                  RAISE_APPLICATION_ERROR(-20013, 'Data de atendimento inválida! Informe uma data válida para o atendimento no cartório!');           
            end if; 
                                    
      RETURN;     
    END TP_ATENDIMENTO;      
    
  
    
      CONSTRUCTOR FUNCTION TP_ATENDIMENTO(v_cpf_cnpjCliente IN VARCHAR2, v_cpfFuncionarioAtendente IN varchar2, v_dataAtendimento in TIMESTAMP) RETURN SELF AS RESULT AS
          dataatendimento_invalido exception;
        cliente_invalido exception;
         atendente_invalido exception;
      
      BEGIN    
          SELF.DATAATENDIMENTO:=v_dataAtendimento;
          SELF.COD:=SEQ_ATENDIMENTO.NEXTVAL;
          SELF.VALORTOTAL:=0.0;
          
          IF(VALIDA_CNPJ(v_cpf_cnpjCliente)='SIM')THEN
              --PEGA SOMENTE O CLIENTE PESSOA JURIDICA
              SELECT REF(CA) INTO SELF.REF_CLIENTE FROM TB_CLIENTE CA 
              WHERE (DEREF(CA.REF_CLIENTE)IS OF(ONLY TP_JURIDICA)) AND (TREAT(DEREF(CA.REF_CLIENTE) AS TP_JURIDICA).CNPJ=v_cpf_cnpjCliente);
          ELSIF(VALIDA_CPF(v_cpf_cnpjCliente)='SIM') THEN
              --PEGA SOMENTE O CLIENTE PESSOA FISICA
              SELECT REF(CA) INTO SELF.REF_CLIENTE FROM TB_CLIENTE CA 
              WHERE (DEREF(CA.REF_CLIENTE)IS OF(ONLY TP_FISICA)) AND (TREAT(DEREF(CA.REF_CLIENTE) AS TP_FISICA).CPF=v_cpf_cnpjCliente);
          END IF;
       
          SELECT REF(AA) INTO SELF.REF_ATENDENTE FROM TB_FUNCIONARIO AA 
          WHERE AA.REF_PESSOAFISICA.CPF=v_cpfFuncionarioAtendente AND AA.REF_CARGO.DESCRICAO='Atendente';  
          
            if(SELF.REF_ATENDENTE IS NULL)then
                  RAISE_APPLICATION_ERROR(-20011, 'Funcionário inválido! Informe um funcionário com o cargo de atendente válido para atender o cliente no cartório!');
            elsif(SELF.REF_CLIENTE IS NULL)then                                  
                  RAISE_APPLICATION_ERROR(-20012, 'Cliente inválido! Informe um cliente com cpf ou cnpj válido cadastrado no cartório!');
            elsif(self.dataatendimento is null)then   
                  RAISE_APPLICATION_ERROR(-20013, 'Data de atendimento inválida! Informe uma data válida para o atendimento no cartório!');           
            end if; 
             
                          
      RETURN;       
      
      END TP_ATENDIMENTO;
      
      
      CONSTRUCTOR FUNCTION TP_ATENDIMENTO(cod IN number, dataAtendimento IN TIMESTAMP, valorTotal in number, ref_Atendente in REF TP_FUNCIONARIO, ref_Cliente in REF TP_CLIENTE) RETURN SELF AS RESULT AS      
      v_refAtendente ref TP_FUNCIONARIO;
      BEGIN    
          v_refAtendente:=ref_Atendente;                    
                              
          SELF.COD:=SEQ_ATENDIMENTO.NEXTVAL;
          SELF.DATAATENDIMENTO:=dataAtendimento;          
          SELF.REF_CLIENTE:=ref_Cliente;                        
          SELF.VALORTOTAL:=SELF.getValorTotalAtendimento();
          
          
          select ref(fa) into self.ref_Atendente from tb_funcionario fa where fa.ref_cargo.descricao='Atendente' 
          and ref(fa)=v_refAtendente;                                    
          
          if(SELF.REF_ATENDENTE IS NULL)then
                  RAISE_APPLICATION_ERROR(-20011, 'Funcionário inválido! Informe um funcionário com o cargo de atendente válido para atender o cliente no cartório!');
            elsif(SELF.REF_CLIENTE IS NULL)then                                  
                  RAISE_APPLICATION_ERROR(-20012, 'Cliente inválido! Informe um cliente com cpf ou cnpj válido cadastrado no cartório!');
            elsif(self.dataatendimento is null)then   
                  RAISE_APPLICATION_ERROR(-20013, 'Data de atendimento inválida! Informe uma data válida para o atendimento no cartório!');           
            end if; 
            
       RETURN; 
       
      END TP_ATENDIMENTO;                
        
END;

create or replace TYPE BODY TP_SERVICODOATENDIMENTO AS

    MEMBER FUNCTION getValorTotalAtendimento RETURN NUMBER AS
      V_TOTALATENDIMENTO NUMBER(8,2);
    BEGIN    
        SELECT SUM(SA.VALORSERVICOREALIZADO) AS TOTAL INTO V_TOTALATENDIMENTO FROM TB_SERVICODOATENDIMENTO SA
        WHERE SA.REF_ATENDIMENTO.COD=DEREF(SELF.REF_ATENDIMENTO).COD;
        
        IF(V_TOTALATENDIMENTO IS NULL)THEN
         V_TOTALATENDIMENTO:=0;
        END IF;
        
        RETURN V_TOTALATENDIMENTO;
    END getValorTotalAtendimento;

    MEMBER FUNCTION getInfo RETURN VARCHAR2 AS
     retorno VARCHAR2(32767);
     INFOATENDIMENTO VARCHAR(32767);
     INFOCLIENTE VARCHAR(32767);
     INFOSERVICOATENDIDO VARCHAR(32767);
     INFOFUNCRESPONSAVEL VARCHAR(32767);
     INFODESCONTO VARCHAR(32767);
     v_totAtendimento number(8,2);
     valorServico number(8,2);
     v_desconto number(8,2);
     valservRealizado NUMBER(8,2);
    BEGIN
    
      select 
         DEREF(SA.REF_RESPONSAVEL).getInfoResumida(), 
         DEREF(SA.REF_ATENDIMENTO).getInfo(), 
         SA.getValorTotalAtendimento(), 
         DEREF(SA.REF_SERVICO).getInfo(), 
         DEREF(SA.REF_SERVICO).valor
       INTO INFOFUNCRESPONSAVEL, INFOATENDIMENTO, v_totAtendimento, INFOSERVICOATENDIDO, valorServico 
      from TB_SERVICODOATENDIMENTO SA 
         WHERE SA.DATAHORAREALIZACAO=SELF.DATAHORAREALIZACAO;
       
       retorno:=INFOATENDIMENTO||chr(13)||
       ' Responsável pelo serviço: '||INFOFUNCRESPONSAVEL||chr(13)||
       ' Horário da prestação do serviço:'||to_char(self.datahorarealizacao,'DDMMYYYY HH24:MI:SS')||chr(13)||
       ' Serviço prestado: '||INFOSERVICOATENDIDO||chr(13)||
       ' Quantidade: '||self.quantidade||chr(13);
       
       
       if(self.ref_desconto is not null)then
         select 
           DEREF(SA.ref_desconto).getInfo(), 
           DEREF(SA.ref_desconto).valor into INFODESCONTO, v_desconto 
         from tb_servicodoatendimento sa where sa.datahorarealizacao=self.datahorarealizacao;
         retorno:=retorno||' Desconto: '||INFODESCONTO||chr(13);         
         valservRealizado:=(valorServico*quantidade)-((valorServico*quantidade*v_desconto)100);
       else
         valservRealizado:=(valorServico*quantidade);
         retorno:=retorno||' Desconto: <nenhum>'||chr(13);
       end if;
                   
       retorno:=retorno||' Valor total do serviço prestado: R$ '||to_char(valservRealizado)||chr(13);
       
       IF(SELF.OBSERVACAO IS NOT NULL)then
       retorno:=retorno||' Observações: '||self.observacao||chr(13);
       end if;
                   
       RETURN retorno;
    END getInfo; 
    
    
    MEMBER FUNCTION getResponsavel RETURN VARCHAR2 AS    
    v_NOMEresponsavel VARCHAR2(450);
    BEGIN
      select DEREF(sA.REF_responsavel.REF_PESSOAFISICA).NOME AS responsavel INTO v_NOMEresponsavel from TB_servicodoatendimento sA 
      WHERE sA.datahorarealizacao=SELF.datahorarealizacao;    
      RETURN v_NOMEresponsavel;
    END getResponsavel;
    
    MEMBER FUNCTION getClienteAtendido RETURN VARCHAR2 AS    
    V_NOMECLIENTE VARCHAR2(450);
    BEGIN
      select DEREF(sA.ref_atendimento.REF_CLIENTE.REF_CLIENTE).NOME AS NOMECLIENTE 
      INTO V_NOMECLIENTE from TB_servicodoATENDIMENTO SA WHERE 
      sA.datahorarealizacao=SELF.datahorarealizacao;    
      RETURN V_NOMECLIENTE;
    END getClienteAtendido;  
    
     MEMBER FUNCTION getDescricaoServicoAtendido RETURN VARCHAR2 AS    
    V_DESCRICAOSERVICOATENDIDO VARCHAR2(450);
    BEGIN
      select DEREF(SA.REF_SERVICO).DESCRICAO AS V_DESCRICAOSERVICOATENDIDO INTO V_DESCRICAOSERVICOATENDIDO from TB_SERVICODOATENDIMENTO SA 
      WHERE sA.datahorarealizacao=SELF.datahorarealizacao;     
      RETURN V_DESCRICAOSERVICOATENDIDO;
    END getDescricaoServicoAtendido; 
    
    
    MAP MEMBER FUNCTION getCodServicoAtendido RETURN NUMBER AS    
    BEGIN  
        return SELF.coditem;
    END getCodServicoAtendido; 
    
    
    STATIC FUNCTION compare(obj1 TP_SERVICODOATENDIMENTO, obj2 TP_SERVICODOATENDIMENTO) RETURN BOOLEAN AS
    retorno BOOLEAN;  
    BEGIN        
      retorno:=false;  
      IF(obj1.CODitem=obj2.CODitem)THEN      
        retorno:=true;     
      ELSE
         retorno:=false;
      END IF;            
      RETURN retorno;
    END compare;

    --construtor para cadastrar um FUNCIONARIO SEM GRATIFICACOES E SEM SUPERVISOR   
    CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(v_codAtendimento IN number, v_descServico IN varchar2, v_cpfFuncResp in varchar2,v_obs in varchar2,v_qtd in integer, v_descDesconto in varchar2) RETURN SELF AS RESULT AS              
    refAtendimento ref tp_atendimento;
    v_clienteEBaixaRenda varchar2(450);
    refServico ref tp_servico;
    V_valorServico number(8,6);
    refResponsavel ref tp_funcionario;
    ref_desconto ref tp_desconto;
    v_valdesconto number(8,6);
    BEGIN
        
        SELECT REF(AC), DEREF(AC.REF_CLIENTE).eBaixaRenda() INTO refAtendimento, v_clienteEBaixaRenda FROM TB_ATENDIMENTO AC WHERE AC.COD=v_codAtendimento; 
        SELECT REF(SC), sc.valor INTO refServico, V_valorServico FROM TB_SERVICO SC WHERE SC.DESCRICAO=v_descServico;
        SELECT REF(FR) INTO refResponsavel FROM TB_FUNCIONARIO FR WHERE FR.REF_PESSOAFISICA.cpf=v_cpfFuncResp;
        
        
        SELF.CODITEM:=SEQ_servicodoatendimento.nextval;                      
        SELF.QUANTIDADE:=v_qtd;
        SELF.OBSERVACAO:=V_OBS;     
        self.datahorarealizacao:=systimestamp;
        
        if(v_descDesconto is not null)then
           if(v_clienteEBaixaRenda='É cliente de baixa renda.')then
             SELECT REF(DS), ds.valor INTO ref_desconto, v_valdesconto FROM TB_DESCONTO DS WHERE DS.DESCRICAO=v_descDesconto;
             SELF.REF_DESCONTO:=REF_DESCONTO;
             SELF.VALORservicorealizado:=(V_valorServico*v_qtd)-((V_valorServico*v_qtd*v_valdesconto)100);
           else
              RAISE_APPLICATION_ERROR(-20015, 'Cliente inválido! Não é possível oferecer desconto no serviço pois o cliente não é de baixa renda!');
           end if;   
        else
           SELF.VALORservicorealizado:=(V_valorServico*v_qtd);
        end if;  
        
        
         SELF.REF_ATENDIMENTO:=refAtendimento;
         SELF.REF_SERVICO:=refServico;
         SELF.REF_RESPONSAVEL:=refResponsavel;
                          
      RETURN;       
    END TP_SERVICODOATENDIMENTO;      
    
  CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(v_codAtendimento IN number, v_descServico IN varchar2, v_cpfFuncResp in varchar2,v_obs in varchar2,v_qtd in integer, v_valServAtend in number,v_descDesconto in varchar2) RETURN SELF AS RESULT AS
      refAtendimento ref tp_atendimento;
    v_clienteEBaixaRenda varchar2(450);
    refServico ref tp_servico;
    V_valorServico number(8,6);
    refResponsavel ref tp_funcionario;
    ref_desconto ref tp_desconto;
    v_valdesconto number(8,6);
    BEGIN
         SELF.CODITEM:=SEQ_servicodoatendimento.nextval;
        SELECT REF(AC), DEREF(AC.REF_CLIENTE).eBaixaRenda() INTO refAtendimento, v_clienteEBaixaRenda FROM TB_ATENDIMENTO AC WHERE AC.COD=v_codAtendimento; 
        SELECT REF(SC), sc.valor INTO refServico, V_valorServico FROM TB_SERVICO SC WHERE SC.DESCRICAO=v_descServico;
        SELECT REF(FR) INTO refResponsavel FROM TB_FUNCIONARIO FR WHERE FR.REF_PESSOAFISICA.cpf=v_cpfFuncResp;
        
        SELF.QUANTIDADE:=v_qtd;
        SELF.OBSERVACAO:=V_OBS;     
        self.datahorarealizacao:=systimestamp;
        
        if(v_descDesconto is not null)then
           if(v_clienteEBaixaRenda='É cliente de baixa renda.')then
             SELECT REF(DS), ds.valor INTO ref_desconto, v_valdesconto FROM TB_DESCONTO DS WHERE DS.DESCRICAO=v_descDesconto;
             SELF.REF_DESCONTO:=REF_DESCONTO;
             SELF.VALORservicorealizado:=(V_valorServico*v_qtd)-((V_valorServico*v_qtd*v_valdesconto)100);
           else
              RAISE_APPLICATION_ERROR(-20015, 'Cliente inválido! Não é possível oferecer desconto no serviço pois o cliente não é de baixa renda!');
           end if;   
        else
           SELF.VALORservicorealizado:=(V_valorServico*v_qtd);
        end if;  
        
          SELF.REF_ATENDIMENTO:=refAtendimento;
         SELF.REF_SERVICO:=refServico;
         SELF.REF_RESPONSAVEL:=refResponsavel;
                          
      RETURN;                   
      END TP_SERVICODOATENDIMENTO;
      
      
    CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(v_codAtendimento IN number, v_descServico IN varchar2, v_cpfFuncResp in varchar2,v_obs in varchar2,v_qtd in integer, v_descDesconto in varchar2,v_datahorarealizacao in timestamp) RETURN SELF AS RESULT AS      
    refAtendimento ref tp_atendimento;
    v_clienteEBaixaRenda varchar2(450);
    refServico ref tp_servico;
    V_valorServico number;
    refResponsavel ref tp_funcionario;
    ref_desconto ref tp_desconto;
    v_valdesconto number;
    BEGIN
        
         SELF.CODITEM:=SEQ_servicodoatendimento.nextval;
        SELECT REF(AC), DEREF(AC.REF_CLIENTE).eBaixaRenda() INTO refAtendimento, v_clienteEBaixaRenda FROM TB_ATENDIMENTO AC 
        WHERE AC.COD=v_codAtendimento; 
        SELECT REF(SC), sc.valor INTO refServico, V_valorServico FROM TB_SERVICO SC WHERE SC.DESCRICAO=v_descServico;
        SELECT REF(FR) INTO refResponsavel FROM TB_FUNCIONARIO FR WHERE FR.REF_PESSOAFISICA.cpf=v_cpfFuncResp;
        
        SELF.REF_ATENDIMENTO:=refAtendimento;
        SELF.REF_SERVICO:=refServico;
        SELF.REF_RESPONSAVEL:=refResponsavel;
        
        
        SELF.QUANTIDADE:=v_qtd;
        SELF.OBSERVACAO:=V_OBS;   
        
        self.datahorarealizacao:=v_datahorarealizacao;
        
  
        if(v_descDesconto is not null)then
           if(v_clienteEBaixaRenda='É cliente de baixa renda.')then
             SELECT REF(DS), ds.valor INTO ref_desconto, v_valdesconto FROM TB_DESCONTO DS WHERE DS.DESCRICAO=v_descDesconto;
             SELF.REF_DESCONTO:=REF_DESCONTO;
             SELF.VALORservicorealizado:=(V_valorServico*v_qtd)-((V_valorServico*v_qtd*v_valdesconto)100);
           else
              RAISE_APPLICATION_ERROR(-20015, 'Cliente inválido! Não é possível oferecer desconto no serviço pois o cliente não é de baixa renda!');
           end if;   
        else
           SELF.VALORservicorealizado:=(V_valorServico*v_qtd);
        end if;  
                          
      RETURN; 
      END TP_SERVICODOATENDIMENTO;    
      
      
   CONSTRUCTOR FUNCTION TP_SERVICODOATENDIMENTO(CODITEM IN NUMBER, REF_ATENDIMENTO IN REF TP_ATENDIMENTO, REF_SERVICO IN REF TP_SERVICO, REF_RESPONSAVEL IN REF TP_FUNCIONARIO, DATAHORAREALIZACAO in timestamp, observacao in varchar2, quantidade in integer, valorservicorealizado in number, ref_desconto in ref tp_desconto) RETURN SELF AS RESULT AS      
      refAtendimento ref tp_atendimento;
    v_clienteEBaixaRenda varchar2(450);
    refServico ref tp_servico;
    V_valorServico number(8,6);
    refResponsavel ref tp_funcionario;    
    v_valdesconto number(8,6);
    BEGIN
        
        SELF.CODITEM:=SEQ_servicodoatendimento.nextval;
        self.ref_atendimento:=REF_ATENDIMENTO;
        self.ref_servico:=REF_SERVICO;
        self.REF_RESPONSAVEL:=REF_RESPONSAVEL;
        self.DATAHORAREALIZACAO:=DATAHORAREALIZACAO;
        self.observacao:=observacao;
        self.quantidade:=quantidade;        
                     
        if(ref_desconto is not null)then
           if(v_clienteEBaixaRenda='É cliente de baixa renda.')then           
             SELECT  ds.valor INTO v_valdesconto  FROM TB_DESCONTO DS WHERE DS.cod=deref(ref_desconto).cod;             
             self.ref_desconto:=ref_desconto;
             SELF.VALORservicorealizado:=(V_valorServico*quantidade)-((V_valorServico*quantidade*v_valdesconto)100);
           else
              RAISE_APPLICATION_ERROR(-20015, 'Cliente inválido! Não é possível oferecer desconto no serviço pois o cliente não é de baixa renda!');
           end if;   
        else
           SELF.VALORservicorealizado:=(V_valorServico*quantidade);
        end if;  
                          
      RETURN; 
      EXCEPTION        
            WHEN OTHERS THEN
            if(SELF.REF_atendimento IS NULL)then
                  RAISE_APPLICATION_ERROR(-20016, 'Atendimento inválido! Associe o serviço prestado ao atendimento corrente do cliente que está sendo atendido!');
            elsif(SELF.REF_servico IS NULL)then                                  
                  RAISE_APPLICATION_ERROR(-20017, 'Serviço inválido! Informe um serviço cartorial válido no atendimento ao cliente!');
            elsif(SELF.REF_responsavel IS NULL)then                                  
                  RAISE_APPLICATION_ERROR(-20018, 'Funcionário inválido! Informe um funcionário válido para se responsabilizar na prestação de serviço ao cliente que está sendo atendido!');
            elsif((SELF.quantidade IS NULL)or(self.quantidade<1))then                                  
                  RAISE_APPLICATION_ERROR(-20019, 'Quantidade inválida! Informe uma quantidade maior ou igual a um para o serviço prestado ao cliente!');                  
            elsif(self.datahorarealizacao is null)then   
                  RAISE_APPLICATION_ERROR(-20020, 'Horário da prestação do serviço inválido! Informe um horário válido!');           
            end if;    
      END TP_SERVICODOATENDIMENTO;  
        
END;

create or replace TYPE BODY TP_REGISTRO AS

    STATIC FUNCTION fazReferenciaAAlgumRegistro(refServicoDoAtendimento in ref tp_servicodoatendimento) RETURN BOOLEAN AS --para garantir relacionamento 1p1 usar  no contrutor do objeto
        codRegistro number;
        retorno boolean;
    BEGIN    
        select ra.NUMREGISTRO INTO codRegistro from tb_registro ra where 
        RA.REF_SERVICODOATENDIMENTO.CODITEM=deref(refServicoDoAtendimento).CODITEM;
        IF(codRegistro is not null)then
          retorno:=true;
        else
          retorno:=false;
        end if;
        return retorno;
    END fazReferenciaAAlgumRegistro;
    
    MEMBER procedure setServicoDoAtendimento(refServicoDoAtendimento in ref tp_servicodoatendimento) as
    begin         
        if(TP_REGISTRO.fazReferenciaAAlgumRegistro(refServicoDoAtendimento))then
           RAISE_APPLICATION_ERROR(-20025, 'Impossível associar o serviço ao registro! O serviço atendido não poderá ser associado 
           ao registro do arquivo por que ele já se encontra associado a outro registro!');                      
        end if;
         self.ref_servicodoatendimento:=refServicoDoAtendimento;
    end setServicoDoAtendimento;


    MEMBER procedure setLivro(refLivro in ref tp_livro)  as
    begin     
        self.ref_livro:=refLivro;
    end setLivro;
    
            
    MEMBER FUNCTION getServicoDoAtendimento RETURN varchar2 as
    retorno varchar2(32767);
     begin 
     
      select ra.ref_servicodoatendimento.getInfo() into retorno from tb_registro ra 
      WHERE ra.ref_servicodoatendimento.CODITEM=deref(self.ref_servicodoatendimento).CODITEM;
       
      return retorno;
     end getServicoDoAtendimento;
     
    MEMBER FUNCTION getLivro RETURN varchar2 as
        retorno varchar2(32767);
     begin 
     
      select ra.ref_livro.getInfo() into retorno from tb_registro ra 
      WHERE ra.ref_livro.cod=deref(self.ref_livro).cod and ra.numregistro=self.numregistro;
       
      return retorno;
    end getLivro;
    
    MEMBER FUNCTION getInfo RETURN varchar2 as
       retorno varchar2(32767);
     begin 
      
      retorno:=self.getLivro||chr(13)||
      ' Número de registro: '||self.numRegistro||chr(13)||
      ' Número da folha: '||self.folha||chr(13);
      
      retorno:=retorno||' '||self.getServicoDoAtendimento;                
       
      return retorno;
    end getInfo;
    
    
    STATIC FUNCTION compare(obj1 TP_REGISTRO, obj2 TP_REGISTRO) RETURN BOOLEAN as
    retorno boolean;
    begin
     if(obj1.numRegistro=obj2.numRegistro)then
       retorno:=true;
     else
       retorno:=false;
     end if;
      return retorno;
    end compare;
    
    
    MAP MEMBER FUNCTION getCodRegistro RETURN NUMBER as
    begin
      return self.numRegistro;
    end getCodRegistro;
    
    
    CONSTRUCTOR FUNCTION TP_REGISTRO(v_folha IN integer, v_refLivro IN ref tp_livro, v_reServicoAtendido in ref tp_servicodoatendimento) RETURN SELF AS RESULT as    
    begin
       
       self.numRegistro:=seq_registro.nextval;
       self.folha:=v_folha;
       self.ref_livro:=v_refLivro;
       self.ref_servicodoatendimento:=v_reServicoAtendido;
        
         RETURN; 
    end TP_REGISTRO;
    
    CONSTRUCTOR FUNCTION TP_REGISTRO(NUMREGISTRO IN integer, FOLHA in integer,  REF_LIVRO IN ref tp_livro, REF_SERVICODOATENDIMENTO in ref tp_servicodoatendimento) RETURN SELF AS RESULT as    
    begin
       self.numRegistro:=NUMREGISTRO;
       self.folha:=FOLHA;
       self.ref_livro:=REF_LIVRO;             
       self.ref_servicodoatendimento:=REF_SERVICODOATENDIMENTO;
         RETURN; 
    end TP_REGISTRO;    
        
END;


---------------triggers do sistema de cartório -----------------------------------------------------------------------------------------------------------------------------------

--trigger que impede que o mesmo codigo de pessoa fisica apareça na tabela pessoa juridica
--trigger que impede que o mesmo codigo de pessoa juridica apareça na tabela pessoa fisica
--essas duas trigger garantem a herança disjunta e total;

create or replace trigger trg_heranca_disjuntatotal1
before insert or update 
on tb_fisica
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare
novoCodPessoaFisica NUMBER;
codPessoaJuridica NUMBER;
qtdPJCadastrada number;
begin 

        novoCodPessoaFisica:=:NEW.cod;
        
        select count(objJ.cod) into qtdPJCadastrada from tb_juridica objJ where objJ.cod=novoCodPessoaFisica;
        
       IF(qtdPJCadastrada>0)THEN
        
            select objJ.cod into codPessoaJuridica from tb_juridica objJ where objJ.cod=novoCodPessoaFisica;
        
            if(novoCodPessoaFisica=codPessoaJuridica)then
               RAISE_APPLICATION_ERROR('-20090','Impossível adicionaratualizar a pessoa física pois já existe uma pessoa jurídica com o código informado.');
            end if;  
        
        END IF;

end trg_heranca_disjuntatotal1;



create or replace trigger trg_heranca_disjuntatotal2
before insert or update 
on tb_juridica
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare
novoCodPessoaJuridica number;
codPessoaFisica NUMBER;
qtdPFCadastrada NUMBER;
begin 

       novoCodPessoaJuridica:=:NEW.cod;
       
       select count(objF.cod)  into qtdPFCadastrada from tb_fisica objF where objF.cod=novoCodPessoaJuridica;
        
       IF(qtdPFCadastrada>0)THEN
               
           select objF.cod into codPessoaFisica from tb_fisica objF where objF.cod=novoCodPessoaJuridica;
        
            if(novoCodPessoaJuridica=codPessoaFisica)then
                RAISE_APPLICATION_ERROR('-20091','Impossível adicionaratualizar a pessoa jurídica pois já existe uma pessoa física com o código informado.');
            end if;  
            
       END IF;     

end trg_heranca_disjuntatotal2;



--trigger para impedir a exclusão de pessoa fisica ou juridica caso ela esteja associada a algum cliente

create or replace trigger trg_referencia_clientePJ
before delete 
on tb_juridica
REFERENCING NEW AS NEW OLD AS OLD
for each row
declare
pragma autonomous_transaction;
codPessoaJuridica number;
codObjPessoaCliente number;
qtdCliRefPessoa number;
begin 
        
        
        codPessoaJuridica:=:OLD.cod;
                              
        select count(objC.ref_cliente.cod) into qtdCliRefPessoa from tb_cliente objC where objC.ref_cliente.cod=codPessoaJuridica;
        
        if(qtdCliRefPessoa>0)then
               RAISE_APPLICATION_ERROR('-20094','Impossível excluir pessoa jurídica por que ela ja encontra-se associada a um código de cliente.');                
        end if;        
        
commit;                      
end trg_referencia_clientePJ;



create or replace trigger trg_referencia_clientePF
before delete 
on tb_fisica
REFERENCING NEW AS NEW OLD AS OLD
for each row  
declare
pragma autonomous_transaction;
codPessoaFisica number;
codObjPessoaCliente number;
qtdCliRefPessoa number;
begin 
        
        
        codPessoaFisica:=:OLD.cod;
        
        --select count(objC.ref_cliente.cod)  from tb_cliente objC where objC.ref_cliente.cod=14;
        
        select count(objC.ref_cliente.cod) into qtdCliRefPessoa from tb_cliente objC where objC.ref_cliente.cod=codPessoaFisica;
        if(qtdCliRefPessoa>0)then
              RAISE_APPLICATION_ERROR('-20093','Impossível excluir pessoa física por que ela já encontra-se associada a um código de cliente.');                               
        end if;        
commit;              
end trg_referencia_clientePF;



--trigguer para negar a inserção ou atualizacao na tabela atendimento caso o funcionario nao seja um funcionario com cargo de atendente

create or replace trigger trg_atendimento_atendente
before insert or update 
on tb_atendimento
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare
funcionario tp_funcionario;
cargoFuncionario tp_CARGO;
codCargoAtendente number;
begin 
        UTL_REF.SELECT_OBJECT(:NEW.ref_atendente, funcionario);
        UTL_REF.SELECT_OBJECT(funcionario.ref_cargo, cargoFuncionario);
        
        select tc.cod 
          into codCargoAtendente 
        from tb_cargo tc where tc.descricao='Atendente';
        
        if(cargoFuncionario.cod<>codCargoAtendente)then
              RAISE_APPLICATION_ERROR('-20095','Impossível cadastraralterar o atendimento com o funcionário informado.
              Informe um funcionário válido com cargo de atendente para atender ao cliente.');  
        end if;
        
end trg_atendimento_atendente;



--trigger do sistema de cartório que impede a exclusão de um funcionario que seja supervisor  do outros funcionarios ------

create or replace trigger trg_block_delfuncsupervisor
before delete 
on tb_funcionario
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare
pragma autonomous_transaction;
eSupervisor boolean;
begin  
        eSupervisor:=false;
        
        for v_reg in (select f.matricula as matricula from tb_funcionario f where  f.matricula=:old.matricula and f.matricula in (select  f2.ref_supervisor.matricula as mat_supervisores from tb_funcionario f2 where f2.ref_supervisor is not dangling)) 
        loop
            if(:OLD.MATRICULA=v_reg.matricula)then
                eSupervisor:=true;                        
            end if;
        end loop;
  
  if(eSupervisor=TRUE)then
    RAISE_APPLICATION_ERROR('-20051','Impossível excluir o funcionário pois o mesmo é supervisor de outros funcionários.');
  end if;

commit;
end trg_block_delfuncsupervisor;



----trigger para quando for inserido ou atualizado um item do servico de atendimento que seja calculado antes o novo valor do item que esta 
----sendo inserido ou atualizado e atualize o seu valor. Além disso devera ser atualizado o valor total do atendimento somando-se os outros 
----servicos atendidos juntamente com este novo servico atualizado ou inserido no atendimento realizado;
create or replace trigger trg_servDoatendimento
before insert or update 
on tb_servicodoatendimento
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare
pragma autonomous_transaction;

objAtendimento tp_atendimento;
objServicoDoAtendimento tp_servicoDoAtendimento;
objServico tp_servico;
objDesconto tp_desconto;
totalAtendimentoAntes number;
totServicoDoAtendimento number;
novototal number;

begin 
   
   --pega o objeto atendimento;
   UTL_REF.SELECT_OBJECT(:NEW.ref_atendimento, objAtendimento);
    
   --pega o valor total de atendimento somando todos os itens menos o que esta sendo modificado antes da operação
   SELECT SUM(SA.VALORSERVICOREALIZADO) AS TOTAL into totalAtendimentoAntes  FROM TB_SERVICODOATENDIMENTO SA
        WHERE SA.REF_ATENDIMENTO.COD=objAtendimento.cod and sa.coditem<>:new.coditem;
        
  if(totalAtendimentoAntes is not null)then
                    
       --tem que pegar o serviçodoatendimento que esta sendo inserido ou atualizado   
       UTL_REF.SELECT_OBJECT(:NEW.ref_servico, objServico);
       
       --e calcular o valor do novo serviço a ser inseridoatualizado depois soma ao valor que esta em atendimento
       if(:NEW.ref_desconto is not null)then      
         UTL_REF.SELECT_OBJECT(:NEW.ref_desconto, objDesconto);
         totServicoDoAtendimento:=((:new.quantidade*objServico.valor)-((:new.quantidade*objServico.valor*objDesconto.valor)100));     
       else   
        totServicoDoAtendimento:=:new.quantidade*objServico.valor;    
       end if;
       
       --atualiza o valordoservicorealizado
        :new.valorservicorealizado:=totServicoDoAtendimento;
        
        --insere o novo total do atendimento que é a soma do novo servico atualizado ou inserido mais o total que dos outros servicos do atendimento;
        novototal:=totalAtendimentoAntes+totServicoDoAtendimento;
           
        
       update tb_atendimento ta set ta.valortotal=novototal
       where ta.cod=objAtendimento.cod;              
       
   
  end if;
 
commit;    
end trg_servDoatendimento;



--trigguer para garantir apenas uma referencia entre a tabela funcionario e a tabela pessoa fisica; 
--tanto na inserçao quanto na atualização

create or replace trigger trg_grant_um_p_um_func_pFisica
before insert or update 
on tb_funcionario
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare
pragma autonomous_transaction;

qtdReferenciaPF NUMBER;
objPessoaFisica tp_fisica;
objPessoaFisicaNovo tp_fisica;
objPessoaFisicaAntigo tp_fisica;
begin 
      
   if(inserting)then
   
          UTL_REF.SELECT_OBJECT(:NEW.ref_pessoafisica, objPessoaFisica);
     
          --ao inserir um funcionario verificar se já existe funcionario que referencia a pessoa fisica informada
          --se já existir cancelar a inserção
          select count(pf.ref_pessoafisica.cod) into qtdReferenciaPF from tb_funcionario pf where 
          pf.ref_pessoafisica.cod=objPessoaFisica.cod;

          if(qtdReferenciaPF>0)then
             RAISE_APPLICATION_ERROR('-20099','Impossível cadastrar funcionario
             pois já existe um funcionário relacionado a pessoa fisica informada!');
          end if;          
   end if;
   
   if(updating)then
   
           UTL_REF.SELECT_OBJECT(:NEW.ref_pessoafisica, objPessoaFisicaNovo);
           UTL_REF.SELECT_OBJECT(:OLD.ref_pessoafisica, objPessoaFisicaAntigo);
     
          --ao ATUALIZAR um funcionario verificar se a nova referência a pessoa física referência a mesma pessoa fisica(old)
          --se sim deixar a atualização acontecer senão
          --verificar se a nova referência ja existe para um outro funcionário se ja existir cancelar a operação de atualização
          --senão prosseguir com a mesma
          
          if(objPessoaFisicaNovo.cod<>objPessoaFisicaAntigo.cod)then
          
                   select count(fc.ref_pessoafisica.cod) into qtdReferenciaPF from tb_funcionario fc 
                   where fc.ref_pessoafisica.cod=objPessoaFisicaNovo.cod;
          
                   if(qtdReferenciaPF>0)then
             
                       RAISE_APPLICATION_ERROR('-20098','Impossível alterar funcionário
                            pois já existe um funcionário relacionado a pessoa fisica informada!');
                   end if;                                      
          end if;                          
          
   end if;
   
 
commit;    
end trg_grant_um_p_um_func_pFisica;



--trigger para garantir apenas uma referencia entre a tabela registro e a tabela servico do atendimento; tanto na inserçao quanto na atualização

create or replace trigger trg_grant_um_p_um_reg_servA
before insert or update 
on tb_registro
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare
pragma autonomous_transaction;

qtdReferenciaSA NUMBER;
objServicoDoAtendimento tp_servicodoatendimento;
objServicoDoAtendimentoNovo tp_servicodoatendimento;
objServicoDoAtendimentoAntigo tp_servicodoatendimento;
begin 
      
   if(inserting)then
   
          UTL_REF.SELECT_OBJECT(:NEW.ref_servicodoatendimento, objServicoDoAtendimento);
     
          --ao inserir um registro no arquivo verificar se já existe servicodoatendimento que referencia o registro informado
          --se já existir cancelar a inserção
          select count(ra.ref_servicodoatendimento.coditem) into qtdReferenciaSA from tb_registro ra where 
          ra.ref_servicodoatendimento.coditem=objServicoDoAtendimento.coditem;

          if(qtdReferenciaSA>0)then
  
             RAISE_APPLICATION_ERROR('-20003','Impossível cadastrar registro no arquivo
             pois já existe registro relacionado ao serviço do atendimento informado!');
          end if;          
   end if;
   
   if(updating)then
   
           UTL_REF.SELECT_OBJECT(:NEW.ref_servicodoatendimento, objServicoDoAtendimentoNovo);
           UTL_REF.SELECT_OBJECT(:OLD.ref_servicodoatendimento, objServicoDoAtendimentoAntigo);
     
          --ao ATUALIZAR um registro de arquivo verificar se a nova referência a serviço do atendimento referência 
          --o mesmo serviço do atendimento antigo(old)
          --se sim deixar a atualização acontecer senão
          --verificar se a nova referência ja existe para um outro registro no arquivo se ja existir cancelar a operação de atualização
          --senão prosseguir com a mesma
          
          if(objServicoDoAtendimentoNovo.coditem<>objServicoDoAtendimentoAntigo.coditem)then
          
                   select count(ra.ref_servicodoatendimento.coditem) into qtdReferenciaSA from tb_registro ra 
                   where ra.ref_servicodoatendimento.coditem=objServicoDoAtendimentoNovo.coditem;
          
                   if(qtdReferenciaSA>0)then           
                       RAISE_APPLICATION_ERROR('-20099','Impossível alterar registro
                            pois já existe outro registro relacionado ao serviço do atendimento informado!');
                   end if;                                      
          end if;                          
          
   end if;
   
 
commit;    
end trg_grant_um_p_um_reg_servA;


--trigguer para garantir apenas uma referencia entre a tabela cliente e a tabela pessoa fisica; tanto na inserçao quanto na atualização

create or replace trigger trg_grant_um_p_um_cli_pesFis
before insert or update 
on tb_cliente
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare
pragma autonomous_transaction;

qtdReferenciaPF NUMBER;
objPessoaFisica tp_pessoa;
objPessoaFisicaNovo tp_pessoa;
objPessoaFisicaAntigo tp_pessoa;

begin 
      
   if(inserting)then
   
          UTL_REF.SELECT_OBJECT(:NEW.ref_cliente, objPessoaFisica);
     
          --ao inserir um cliente no cartorio verificar se já existe pessoa fisica que referencia o cliente informado
          --se já existir cancelar a inserção
          
          --vai buscar nas duas tabelas ref_cliente se refere tanto a pessoa juridica como fisica aumenta o poder de consulta objeto relacional é o bicho
          --select count(tc.ref_cliente.cod)  from tb_cliente tc 
          
          select count(tc.ref_cliente.cod) into qtdReferenciaPF from tb_cliente tc where 
          tc.ref_cliente.cod=objPessoaFisica.cod;


        IF(qtdReferenciaPF IS NOT NULL)THEN
          if(qtdReferenciaPF>0)then  
             RAISE_APPLICATION_ERROR('-20004','Impossível cadastrar cliente 
             pois já existe cliente relacionado a pessoa fisica informada!');
          end if;          
       END IF;   
   end if;
   
   if(updating)then
   
           UTL_REF.SELECT_OBJECT(:NEW.ref_cliente, objPessoaFisicaNovo);
           UTL_REF.SELECT_OBJECT(:OLD.ref_cliente, objPessoaFisicaAntigo);
     
          --ao ATUALIZAR um registro de arquivo verificar se a nova referência a serviço do atendimento referência 
          --o mesmo serviço do atendimento antigo(old)
          --se sim deixar a atualização acontecer senão
          --verificar se a nova referência ja existe para um outro registro no arquivo se ja existir cancelar a operação de atualização
          --senão prosseguir com a mesma
          
          if(objPessoaFisicaNovo.cod<>objPessoaFisicaAntigo.cod)then
          
                   select count(tc.ref_cliente.cod) into qtdReferenciaPF from tb_cliente tc 
                   where tc.ref_cliente.cod=objPessoaFisicaNovo.cod;
              IF(qtdReferenciaPF IS NOT NULL)THEN
                   if(qtdReferenciaPF>0)then           
                       RAISE_APPLICATION_ERROR('-20099','Impossível alterar cliente
                            pois já existe outro cliente relacionado a pessoa física informada!');
                   end if;                                      
              END IF;     
          end if;                          
          
   end if;
  
commit;    
end trg_grant_um_p_um_cli_pesFis;



--trigguer para garantir apenas uma referencia entre a tabela cliente e a tabela pessoa juridica; tanto na inserçao quanto na atualização

create or replace trigger trg_grant_um_p_um_cli_pesJur
before insert or update 
on tb_cliente
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare
pragma autonomous_transaction;

qtdReferenciaPJ NUMBER;
objPessoaJuridica tp_pessoa;
objPessoaJuridicaNovo tp_pessoa;
objPessoaJuridicaAntigo tp_pessoa;

begin 
   
   
   if(inserting)then
   
          UTL_REF.SELECT_OBJECT(:NEW.ref_cliente, objPessoaJuridica);
     
          --ao inserir um cliente no cartorio verificar se já existe pessoa JURIDICA que referencia o cliente informado
          --se já existir cancelar a inserção
          
          --vai buscar nas duas tabelas ref_cliente se refere tanto a pessoa juridica como fisica aumenta o poder de consulta 
          --objeto relacional é o bicho
          --select count(tc.ref_cliente.cod)  from tb_cliente tc 
          
          select count(tc.ref_cliente.cod) into qtdReferenciaPJ from tb_cliente tc where 
          tc.ref_cliente.cod=objPessoaJuridica.cod;

        if(qtdReferenciaPJ is not null)then
          if(qtdReferenciaPJ>0)then  
             RAISE_APPLICATION_ERROR('-20011','Impossível cadastrar cliente 
             pois já existe cliente relacionado a pessoa jurídica informada!');
          end if;          
        end if;  
   end if;
   
   if(updating)then
   
           UTL_REF.SELECT_OBJECT(:NEW.ref_cliente, objPessoaJuridicaNovo);
           UTL_REF.SELECT_OBJECT(:OLD.ref_cliente, objPessoaJuridicaAntigo);
     
          --ao ATUALIZAR um cliente verificar se a nova referência a pessoa fisica referência 
          --o mesmo cliente 
          --se sim deixar a atualização acontecer senão
          --verificar se a nova referência ja existe para um outro cliente se ja existir cancelar a operação de atualização
          --senão prosseguir com a mesma
          
          if(objPessoaJuridicaNovo.cod<>objPessoaJuridicaAntigo.cod)then
          
                   select count(tc.ref_cliente.cod) into qtdReferenciaPJ from tb_cliente tc 
                   where tc.ref_cliente.cod=objPessoaJuridicaNovo.cod;
                if(qtdReferenciaPJ is not null)then
                   if(qtdReferenciaPJ>0)then           
                       RAISE_APPLICATION_ERROR('-20010','Impossível alterar cliente
                            pois já existe outro cliente relacionado a pessoa jurídica informada!');
                   end if;     
                end if;  
          end if;                          
          
   end if;
   
 
commit;    
end trg_grant_um_p_um_cli_pesJur;



--trigguer para quando inserir dados na tabela atendimento salvar os dados do atendimento na tabela de log atendimento(para uma possível auditoria)
--(trigger de COPMPOUND  usando tabela em memoria para registrar os logs em lotes);

CREATE OR REPLACE TRIGGER trg_log_atendimento
FOR INSERT OR UPDATE OR DELETE
ON tb_atendimento
COMPOUND TRIGGER
  
  TYPE t_logatendimento_changes       IS TABLE OF tb_logatendimento%ROWTYPE INDEX BY SIMPLE_INTEGER;
  v_logatendimento_changes            t_logatendimento_changes;
  
  v_index                  SIMPLE_INTEGER       := 0;
  v_threshhold    CONSTANT SIMPLE_INTEGER       := 10; --máximo número de linhas de atendimento para escrever de uma vez.
  --indicando que a cada 10 atendimentos realizados os dez serão enviados para a tabela de auditoria de logs do atendimento
  
  v_user          VARCHAR2(50); --indica o usuario logado na sessao do banco de dados no momento da manipulação da tabela de atendimento;
  
  objFuncAtendente tp_funcionario;
  objCliente tp_cliente;
  
  --precidemento util para descarregar o log da tabela de memoria para a tabela de auditoria tb_logatendimento  
  PROCEDURE descarregar_logs
  IS
    v_updates       CONSTANT SIMPLE_INTEGER := v_logatendimento_changes.count();
  BEGIN

    FORALL v_count IN 1..v_updates
        INSERT INTO tb_logatendimento
             VALUES v_logatendimento_changes(v_count);

    v_logatendimento_changes.delete();
    v_index := 0; --resetando threshold para próxima inserção em massa.

  END descarregar_logs;

  
  --depois da inserção remoção ou atualização na tabela de atendimento registre na tabela em memoria de log de atendimento
  -- caso atinga o limite de 40 atendimentos na tabela de log em memoria envie os logs para a tabela de auditoria tb_logatendimento
  AFTER EACH ROW
  IS  
  BEGIN
        
    IF INSERTING THEN
        v_index := v_index + 1;
        v_logatendimento_changes(v_index).codlog       := seq_logatendimento.nextval;
        v_logatendimento_changes(v_index).dataoperacao       := SYSTIMESTAMP;
        v_logatendimento_changes(v_index).tipoOperacao       := 'INSERÇÃO'; --INSERÇÃO
        v_logatendimento_changes(v_index).usuario_bd       := SYS_CONTEXT ('USERENV', 'SESSION_USER');        
        
        UTL_REF.SELECT_OBJECT(:NEW.ref_atendente, objFuncAtendente);
        UTL_REF.SELECT_OBJECT(:NEW.ref_cliente, objCliente);                                            
        
        v_logatendimento_changes(v_index).tupla :=  new TP_TUPLAATENDIMENTO(:new.cod,objCliente.cod,objFuncAtendente.matricula,
        :NEW.valortotal,:NEW.dataatendimento);        
                              
    ELSIF UPDATING THEN
        
                v_index := v_index + 1;
                v_logatendimento_changes(v_index).codlog       := seq_logatendimento.nextval;
                v_logatendimento_changes(v_index).dataoperacao       := SYSTIMESTAMP;
                v_logatendimento_changes(v_index).tipoOperacao       := 'ATUALIZAÇÃO'; --ATUALIZAÇÃO
                v_logatendimento_changes(v_index).usuario_bd       := SYS_CONTEXT ('USERENV', 'SESSION_USER');        
                
                UTL_REF.SELECT_OBJECT(:NEW.ref_atendente, objFuncAtendente);
                UTL_REF.SELECT_OBJECT(:NEW.ref_cliente, objCliente);                                            
                
                v_logatendimento_changes(v_index).tupla := new TP_TUPLAATENDIMENTO(:new.cod,objCliente.cod,objFuncAtendente.matricula,
                :NEW.valortotal,:NEW.dataatendimento);
                
    ELSIF DELETING THEN
    
                v_index := v_index + 1;
                v_logatendimento_changes(v_index).codlog       := seq_logatendimento.nextval;
                v_logatendimento_changes(v_index).dataoperacao       := SYSTIMESTAMP;
                v_logatendimento_changes(v_index).tipoOperacao       := 'REMOÇÃO'; --REMOÇÃO
                v_logatendimento_changes(v_index).usuario_bd       := SYS_CONTEXT('USERENV', 'SESSION_USER');        
                
                UTL_REF.SELECT_OBJECT(:NEW.ref_atendente, objFuncAtendente);
                UTL_REF.SELECT_OBJECT(:NEW.ref_cliente, objCliente);                                            
                
                v_logatendimento_changes(v_index).tupla := new TP_TUPLAATENDIMENTO(:new.cod,objCliente.cod,objFuncAtendente.matricula,
                :NEW.valortotal,:NEW.dataatendimento);
                
    END IF;
    

    --se o índice atingir o limite 40 atendimentos
    -- o log será descarregado
    IF v_index >= v_threshhold THEN
      descarregar_logs();
    END IF;

   END AFTER EACH ROW;

  -- AFTER STATEMENT Section: descarregar log ao fim dos comandos dml
  AFTER STATEMENT IS
  BEGIN
     descarregar_logs();
  END AFTER STATEMENT;

END trg_log_atendimento;



--trigguer para quando inserrir dados na tabela servicodoatendimento que seja salvo os dados na tabela de auditoria 
--de log do servico do atendimento (trigger de COPMPOUND usando tabela em memoria para registrar os logs em lotes)

create or replace TRIGGER trg_log_servAtendimento
FOR INSERT OR UPDATE OR DELETE
ON tb_servicodoatendimento
COMPOUND TRIGGER
  
  TYPE t_logservatend_changes       IS TABLE OF tb_logservicodoatendimento%ROWTYPE INDEX BY SIMPLE_INTEGER;
  v_logservatend_changes            t_logservatend_changes;
  
  v_index                  SIMPLE_INTEGER       := 0;
  v_threshhold    CONSTANT SIMPLE_INTEGER       := 10; --máximo número de linhas de serviços do atendimento para escrever de uma vez.
  --indicando que a cada 20 serviços do atendimentos realizados os vinte serão enviados para a tabela de auditoria de logs do serviços do atendimento
  
  v_user          VARCHAR2(50); --indica o usuario logado na sessao do banco de dados no momento da manipulação da tabela de serviço do atendimento;
  
  objAtendimento tp_atendimento;
  objFuncResponsavel tp_funcionario;
  objServico tp_servico;
  objDesconto tp_desconto;
  codDesconto number;
  codRegistro number;
  
  --precidemento util para descarregar o log da tabela de memoria para a tabela de auditoria tb_logservicodoatendimento  
  PROCEDURE descarregar_logs
  IS
    v_updates       CONSTANT SIMPLE_INTEGER := v_logservatend_changes.count();
  BEGIN

    FORALL v_count IN 1..v_updates
        INSERT INTO tb_logservicodoatendimento
             VALUES v_logservatend_changes(v_count);

    v_logservatend_changes.delete();
    v_index := 0; --resetando threshold para próxima inserção em massa.

  END descarregar_logs;
  
  --depois da inserção remoção ou atualização na tabela de serviço do atendimento registre na tabela em memoria de log
  --de serviço do atendimento caso atinga o limite de 20 serviços do atendimentos registrados na tabela de log em memoria 
  --envie os logs para a tabela de auditoria tb_logservicodoatendimento
  AFTER EACH ROW
  IS  
  BEGIN
        
    IF INSERTING THEN
    
        v_index := v_index + 1;
        v_logservatend_changes(v_index).codlog       := seq_logservicodoatendimento.nextval;
        v_logservatend_changes(v_index).dataoperacao       := SYSTIMESTAMP;
        v_logservatend_changes(v_index).tipoOperacao       := 'INSERÇÃO'; --INSERÇÃO
        v_logservatend_changes(v_index).usuario_bd       := SYS_CONTEXT ('USERENV', 'SESSION_USER');        
        
        UTL_REF.SELECT_OBJECT(:NEW.ref_atendimento, objAtendimento);
        UTL_REF.SELECT_OBJECT(:NEW.ref_servico, objServico);
        UTL_REF.SELECT_OBJECT(:NEW.ref_responsavel, objFuncResponsavel);
        
        if(:NEW.ref_desconto is not null)then
            UTL_REF.SELECT_OBJECT(:NEW.ref_desconto, objDesconto);
            codDesconto:=objDesconto.cod;
        else            
            codDesconto:=null;
        end if;

        v_logservatend_changes(v_index).tupla :=  
        new TP_TUPLASERVICODOATENDIMENTO(:new.coditem,objAtendimento.cod,codDesconto,objFuncResponsavel.matricula,
        :new.datahorarealizacao, objServico.cod, :NEW.observacao, :new.valorservicorealizado, :new.quantidade);        
                    
    ELSIF UPDATING THEN
        
        v_index := v_index + 1;
        v_logservatend_changes(v_index).codlog       := seq_logservicodoatendimento.nextval;
        v_logservatend_changes(v_index).dataoperacao       := SYSTIMESTAMP;
        v_logservatend_changes(v_index).tipoOperacao       := 'ATUALIZAÇÃO'; --ATUALIZIAÇÃO
        v_logservatend_changes(v_index).usuario_bd       := SYS_CONTEXT ('USERENV', 'SESSION_USER');        
        
        UTL_REF.SELECT_OBJECT(:NEW.ref_atendimento, objAtendimento);
        UTL_REF.SELECT_OBJECT(:NEW.ref_servico, objServico);
        UTL_REF.SELECT_OBJECT(:NEW.ref_responsavel, objFuncResponsavel);
        
        if(:NEW.ref_desconto is not null)then
            UTL_REF.SELECT_OBJECT(:NEW.ref_desconto, objDesconto);
            codDesconto:=objDesconto.cod;
        else            
            codDesconto:=null;
        end if;
        
        v_logservatend_changes(v_index).tupla :=  
        new TP_TUPLASERVICODOATENDIMENTO(:new.coditem,objAtendimento.cod,codDesconto,objFuncResponsavel.matricula,
        :new.datahorarealizacao, objServico.cod, :NEW.observacao, :new.valorservicorealizado, :new.quantidade);        
        
                
    ELSIF DELETING THEN
    
        v_index := v_index + 1;
        v_logservatend_changes(v_index).codlog       := seq_logservicodoatendimento.nextval;
        v_logservatend_changes(v_index).dataoperacao       := SYSTIMESTAMP;
        v_logservatend_changes(v_index).tipoOperacao       := 'REMOÇÃO'; --REMOÇÃO
        v_logservatend_changes(v_index).usuario_bd       := SYS_CONTEXT ('USERENV', 'SESSION_USER');        
        
        UTL_REF.SELECT_OBJECT(:NEW.ref_atendimento, objAtendimento);
        UTL_REF.SELECT_OBJECT(:NEW.ref_servico, objServico);
        UTL_REF.SELECT_OBJECT(:NEW.ref_responsavel, objFuncResponsavel);
        
        if(:NEW.ref_desconto is not null)then
            UTL_REF.SELECT_OBJECT(:NEW.ref_desconto, objDesconto);
            codDesconto:=objDesconto.cod;
        else            
            codDesconto:=null;
        end if;
                
        v_logservatend_changes(v_index).tupla :=  
        new TP_TUPLASERVICODOATENDIMENTO(:new.coditem,objAtendimento.cod,codDesconto,objFuncResponsavel.matricula,
        :new.datahorarealizacao, objServico.cod, :NEW.observacao, :new.valorservicorealizado, :new.quantidade); 
        
    END IF;
    

    --se o índice atingir o limite 40 atendimentos
    -- o log será descarregado
    IF v_index >= v_threshhold THEN
      descarregar_logs();
    END IF;

   END AFTER EACH ROW;

  -- AFTER STATEMENT Section: descarregar log ao fim dos comandos dml
  AFTER STATEMENT IS
  BEGIN
     descarregar_logs();
  END AFTER STATEMENT;

END trg_log_servAtendimento;

      

--trigguer para quando inserrir dados na tabela servicodoatendimento que seja salvo os dados na tabela de auditoria 
--de log do servico do atendimento (trigger de COPMPOUND usando tabela em memoria para registrar os logs em lotes)

create or replace TRIGGER trg_log_registro
FOR INSERT OR UPDATE OR DELETE
ON tb_registro
COMPOUND TRIGGER
  
  TYPE t_logregistro_changes       IS TABLE OF tb_logregistro%ROWTYPE INDEX BY SIMPLE_INTEGER;
  v_logregistro_changes            t_logregistro_changes;
  
  v_index                  SIMPLE_INTEGER       := 0;
  v_threshhold    CONSTANT SIMPLE_INTEGER       := 10; --máximo número de linhas de registros em arquivo para escrever de uma vez. Indicando que a cada 10 registros 
  --de arquvio realizados os dez serão enviados para a tabela de auditoria de logs de registros no arquivo do cartorio
  
  v_user          VARCHAR2(50); --indica o usuario logado na sessao do banco de dados no momento da manipulação da tabela de registro;
  
  objLivro tp_livro;
  objServicoRegistrado tp_servicodoatendimento;  
  codLivro number;
  codServicoRegistrado number;
  
  --precidemento util para descarregar o log da tabela de memoria para a tabela de auditoria tb_logregistro
  PROCEDURE descarregar_logs
  IS
    v_updates       CONSTANT SIMPLE_INTEGER := v_logregistro_changes.count();
  BEGIN

    FORALL v_count IN 1..v_updates
        INSERT INTO tb_logregistro
             VALUES v_logregistro_changes(v_count);

    v_logregistro_changes.delete();
    v_index := 0; --resetando threshold para próxima inserção em massa.

  END descarregar_logs;

  --depois da inserção remoção ou atualização na tabela de registro registre na tabela em memoria de log
  --de registro caso atinga o limite de 10 registros na tabela de log em memoria 
  --envie os logs para a tabela de auditoria tb_logregistro
  AFTER EACH ROW
  IS  
  BEGIN
        
    IF INSERTING THEN
    
        v_index := v_index + 1;
        v_logregistro_changes(v_index).codlog       := seq_logregistro.nextval;
        v_logregistro_changes(v_index).dataoperacao       := SYSTIMESTAMP;
        v_logregistro_changes(v_index).tipoOperacao       := 'INSERÇÃO'; --INSERÇÃO
        v_logregistro_changes(v_index).usuario_bd       := SYS_CONTEXT ('USERENV', 'SESSION_USER');        
        
        UTL_REF.SELECT_OBJECT(:NEW.ref_LIVRO, objLivro);
        UTL_REF.SELECT_OBJECT(:NEW.ref_servicodoatendimento, objServicoRegistrado);        
        
        v_logregistro_changes(v_index).tupla :=  
        new TP_TUPLAREGISTRO(:new.NUMREGISTRO,:NEW.FOLHA,objLivro.cod,objServicoRegistrado.coditem);        
                    
    ELSIF UPDATING THEN
        
        v_index := v_index + 1;
        v_logregistro_changes(v_index).codlog       := seq_logregistro.nextval;
        v_logregistro_changes(v_index).dataoperacao       := SYSTIMESTAMP;
        v_logregistro_changes(v_index).tipoOperacao       := 'ATUALIZAÇÃO'; --ATUALIZAÇÃO
        v_logregistro_changes(v_index).usuario_bd       := SYS_CONTEXT ('USERENV', 'SESSION_USER');        
        
        UTL_REF.SELECT_OBJECT(:NEW.ref_LIVRO, objLivro);
        UTL_REF.SELECT_OBJECT(:NEW.ref_servicodoatendimento, objServicoRegistrado);        
        
        v_logregistro_changes(v_index).tupla :=  
        new TP_TUPLAREGISTRO(:new.NUMREGISTRO,:NEW.FOLHA,objLivro.cod,objServicoRegistrado.coditem);             
        
                
    ELSIF DELETING THEN
    
        v_index := v_index + 1;
        v_logregistro_changes(v_index).codlog       := seq_logregistro.nextval;
        v_logregistro_changes(v_index).dataoperacao       := SYSTIMESTAMP;
        v_logregistro_changes(v_index).tipoOperacao       := 'REMOÇÃO'; --REMOÇÃO
        v_logregistro_changes(v_index).usuario_bd       := SYS_CONTEXT ('USERENV', 'SESSION_USER');        
        
        UTL_REF.SELECT_OBJECT(:NEW.ref_LIVRO, objLivro);
        UTL_REF.SELECT_OBJECT(:NEW.ref_servicodoatendimento, objServicoRegistrado);        
        
        v_logregistro_changes(v_index).tupla :=  
        new TP_TUPLAREGISTRO(:new.NUMREGISTRO,:NEW.FOLHA,objLivro.cod,objServicoRegistrado.coditem);                

    END IF;
    
    --se o índice atingir o limite 40 atendimentos
    -- o log será descarregado
    IF v_index >= v_threshhold THEN
      descarregar_logs();
    END IF;

   END AFTER EACH ROW;

  -- AFTER STATEMENT Section: descarregar log ao fim dos comandos dml
  AFTER STATEMENT IS
  BEGIN
     descarregar_logs();
  END AFTER STATEMENT;

END trg_log_registro;

      
      
---------------------------------Criação de indices para agilizar as consultas tunning de banco de dados-----------------------------

CREATE INDEX idx_tb_atendimento_data ON tb_atendimento(dataatendimento);

CREATE INDEX idx_tb_cliente_data ON tb_cliente(dataregistro);

CREATE INDEX idx_tb_fisica_nome ON tb_fisica(nome);

CREATE INDEX idx_tb_fisica_cpf_nome ON tb_fisica(cpf,nome);

CREATE INDEX idx_tb_funcionario_status ON tb_funcionario(status);

CREATE INDEX idx_tb_funcionario_salario ON tb_funcionario(salario);

CREATE INDEX idx_tb_funcionario_dataadmisao ON tb_funcionario(dataadmisao);

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
