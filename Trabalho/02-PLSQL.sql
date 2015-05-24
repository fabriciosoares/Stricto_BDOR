-- ------------------------------------ --
--      PROJETO CARTORIO (2-PL/SQL)     --
------------------------------------------
--
-- Atencao: No Eclipse abrir com (open with): "SQL Worksheet" na perspectiva "Toad Extension"
--
-- PL/SQL
CREATE OR REPLACE TYPE BODY TP_TELEFONE AS
	MEMBER FUNCTION TOSTRING RETURN VARCHAR2 AS RETORNO VARCHAR2(15);
	BEGIN
		SELECT
			SELF.TIPO ||': '||TO_CHAR(SELF.DDD) ||') ' || TO_CHAR(SELF.NUMERO) INTO RETORNO FROM DUAL;
			RETURN RETORNO;
	END TOSTRING;
	MEMBER FUNCTION GETTELEFONE RETURN VARCHAR2 AS RETORNO VARCHAR2(15);
	BEGIN
		SELECT
			'('||TO_CHAR(SELF.DDD) ||') ' || TO_CHAR(SELF.NUMERO) INTO RETORNO FROM DUAL;
			RETURN RETORNO;
	END GETTELEFONE;
END;
/
CREATE OR REPLACE TYPE BODY TP_PESSOA AS
	MEMBER FUNCTION GETENDERECO RETURN VARCHAR2 AS RETORNO VARCHAR2(550);
	BEGIN
		SELECT
			'LOGRADOURO: '||SELF.ENDERECO.LOGRADOURO ||
			' N� ' || TO_CHAR(SELF.ENDERECO.NUMERO)||
			' BAIRRO: ' || SELF.ENDERECO.BAIRRO||
			' CIDADE: '|| SELF.ENDERECO.CIDADE ||'-'||SELF.ENDERECO.UF||
			' CEP: '||SELF.ENDERECO.CEP INTO RETORNO FROM DUAL;
			RETURN RETORNO;
	END GETENDERECO;
	MEMBER FUNCTION GETFONES RETURN VARCHAR2 AS RETORNO VARCHAR2(55);
	BEGIN
		IF(SELF.TELEFONES IS NOT NULL) THEN
			RETORNO:='';
			FOR I IN 1..SELF.TELEFONES.COUNT
			LOOP
				RETORNO := RETORNO||SELF.TELEFONES(I).GETTELEFONE||' ';
			END LOOP;
		ELSE
			RETORNO := 'NENHUM';
		END IF;
		RETURN RETORNO;
	END GETFONES;
	MEMBER FUNCTION GETINFO RETURN VARCHAR2 AS RETORNO VARCHAR2(15);
	BEGIN
		SELECT
			' COD: '||TO_CHAR(SELF.COD)||
			' NOME: '||TO_CHAR(SELF.NOME)||
			' ENDERE�O: '||SELF.GETENDERECO()||
			' FONES: '||SELF.GETFONES() INTO RETORNO FROM DUAL;
		RETURN RETORNO;
	END GETINFO;
	MAP MEMBER FUNCTION GETCOD RETURN NUMBER AS
	BEGIN
		RETURN SELF.COD;
	END GETCOD;
	STATIC FUNCTION COMPARE(OBJ1 TP_PESSOA, OBJ2 TP_PESSOA) RETURN BOOLEAN AS RESULTADO BOOLEAN;
	BEGIN
		RESULTADO := FALSE;
		IF (OBJ1.COD = OBJ2.COD) THEN
			RESULTADO := TRUE;
		END IF;
		RETURN RESULTADO;
	END COMPARE;
END;
/
CREATE OR REPLACE TYPE BODY TP_FISICA AS OVERRIDING
	MEMBER FUNCTION GETINFO RETURN VARCHAR2 AS RETORNO VARCHAR2(555);
	BEGIN
		RETORNO := '';
		RETORNO := ' COD: ' || TO_CHAR(SELF.GETCOD()) ||
					' NOME: ' || SELF.NOME ||
					' CPF: ' || SELF.CPF ||
					' SEXO: ' || SELF.SEXO ||
					' ENDERECO: ' || SELF.GETENDERECO() ||
					' FONES: ' || SELF.GETFONES();
		RETURN RETORNO;
	END GETINFO;
	STATIC FUNCTION COMPARE(OBJ1 TP_FISICA, OBJ2 TP_FISICA) RETURN BOOLEAN AS RESULTADO BOOLEAN;
	BEGIN
		RESULTADO := FALSE;
		IF (OBJ1.CPF = OBJ2.CPF) THEN
			RESULTADO := TRUE;
		END IF;
		RETURN RESULTADO;
	END COMPARE;
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
		SELF.CPF := CPF;
		SELF.SEXO := SEXO;
		SELF.FOTO := NULL;
		SELF.COD := SEQ_PESSOA.NEXTVAL;
		SELF.NOME := NOME;
		SELF.ENDERECOB := ENDERECO;
		SELF.TELEFONES := FONES;
		RETURN;
	END TP_FISICA;
END;
/
CREATE OR REPLACE TYPE BODY TP_JURIDICA AS OVERRIDING
	MEMBER FUNCTION GETINFO RETURN VARCHAR2 AS RETORNO VARCHAR2(755);
	BEGIN
		SELECT
			' COD: ' || TO_CHAR(SELF.GETCOD()) ||
			' NOME DO RESPONS�VEL PELA EMPRESA: ' || SELF.NOME ||
			' CNPJ: ' || SELF.CNPJ || ' RAZ�O SOCIAL: ' || SELF.RAZAOSOCIAL ||
			' ENDERE�O: ' || SELF.GETENDERECO() ||
			' FONES: ' || SELF.GETFONES() INTO RETORNO FROM DUAL;
			RETURN RETORNO;
	END GETINFO;
	STATIC FUNCTION COMPARE(OBJ1 TP_JURIDICA, OBJ2 TP_JURIDICA) RETURN BOOLEAN AS RESULTADO BOOLEAN;
	BEGIN
		RESULTADO := FALSE;
		IF (OBJ1.CNPJ = OBJ2.CNPJ) THEN
			RESULTADO := TRUE;
		END IF;
		RETURN RESULTADO;
	END COMPARE;
	CONSTRUCTOR FUNCTION TP_JURIDICA(CNPJ IN VARCHAR2, RAZAOSOCIAL IN VARCHAR2, NOME IN VARCHAR2, ENDLOGRADOURO IN ENDERECO.LOGRADOURO%TYPE, ENDNUMERO IN ENDERECO.NUMERO%TYPE, ENDBAIRRO IN ENDERECO.BAIRRO%TYPE, ENDCIDADE IN ENDERECO.CIDADE%TYPE, ENDUF IN ENDERECO.UF%TYPE, ENDCEP IN ENDERECO.CEP%TYPE) RETURN SELF AS RESULT AS
	BEGIN
		SELF.CNPJ := CNPJ;
		SELF.RAZAOSOCIAL := RAZAOSOCIAL;
		SELF.COD := SEQ_PESSOA.NEXTVAL;
		SELF.NOME := NOME;
		SELF.ENDERECO := NEW TP_ENDERECO(ENDLOGRADOURO, ENDNUMERO, ENDBAIRRO, ENDCIDADE, ENDUF, ENDCEP);
		SELF.TELEFONES := NULL;
		RETURN;
	END TP_JURIDICA;
	CONSTRUCTOR FUNCTION TP_JURIDICA(CNPJ IN VARCHAR2, RAZAOSOCIAL IN VARCHAR2, NOME IN VARCHAR2, ENDERECO IN ENDERECO%TYPE, FONES IN ARRAY_TELEFONE) RETURN SELF AS RESULT AS
	BEGIN
		SELF.CNPJ:=CNPJ;
		SELF.RAZAOSOCIAL:=RAZAOSOCIAL;
		SELF.COD:=SEQ_PESSOA.NEXTVAL;
		SELF.NOME:=NOME;
		SELF.ENDERECO:=ENDERECO;
		SELF.TELEFONES:=FONES;
  		RETURN;
	END TP_JURIDICA;
END;
/
CREATE OR REPLACE TYPE BODY TP_CLIENTE AS
	MEMBER FUNCTION EBAIXARENDA RETURN VARCHAR2 AS RETORNO VARCHAR2(555);
	BEGIN
		IF ((SELF.RENDA IS NOT NULL) AND SELF.RENDA <= 700.00) THEN
			RETORNO:='� CLIENTE DE BAIXA RENDA.';
		ELSE
			RETORNO:='N�O � CLIENTE DE BAIXA RENDA.';
		END IF;
		RETURN RETORNO;
	END EBAIXARENDA;
	MEMBER FUNCTION GETRENDA RETURN VARCHAR2 AS RETORNO VARCHAR2(555);
	BEGIN
		IF(SELF.RENDA IS NOT NULL) THEN
			RETORNO:=TO_CHAR(SELF.RENDA);
		ELSE
			RETORNO:='NENHUMA RENDA DECLARADA';
		END IF;
		RETURN RETORNO;
	END GETRENDA;
	MEMBER FUNCTION GETINFO RETURN VARCHAR2 AS RETORNO VARCHAR2(855);
	BEGIN
		SELECT
			' C�DIGO DO CLIENTE: ' || TO_CHAR(SELF.COD) ||
			' DATA DE CADASTRO: ' || TO_CHAR(SELF.DATAREGISTRO,'DD/MM/YYYY') ||
			' RENDA DECLARADA: ' || SELF.GETRENDA() ||
			' (' || SELF.EBAIXARENDA() || ') ' ||
			' DADOS DO CLIENTE: ' || (DEREF(SELF.REF_CLIENTE).GETINFO())
			INTO RETORNO FROM DUAL;
		RETURN RETORNO;
	END GETINFO;
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_CLIENTE) RETURN NUMBER AS
	BEGIN
		RETURN  (SELF.COD  - OBJ.COD); -- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
	END EQUALS;
	STATIC FUNCTION COMPARE(OBJ1 TP_CLIENTE, OBJ2 TP_CLIENTE) RETURN BOOLEAN AS RETORNO BOOLEAN;
	BEGIN
		RETORNO := FALSE;
		IF(TO_CHAR(OBJ1.COD) = TO_CHAR(OBJ2.COD)) THEN
			RETORNO := TRUE;
		ELSE
			RETORNO := FALSE;
		END IF;
		RETURN RETORNO;
	END COMPARE;
	CONSTRUCTOR FUNCTION TP_CLIENTE(CPF_CNPJ IN VARCHAR2) RETURN SELF AS RESULT AS REFCLIENTE REF TP_PESSOA;
	CODPESSOA NUMBER;
	V_CPF_CNPJ VARCHAR2(14);
	BEGIN
		V_CPF_CNPJ:=CPF_CNPJ;
		IF(VALIDA_CPF(V_CPF_CNPJ) = 'SIM') THEN
			SELECT REF(PF), PF.COD INTO REFCLIENTE, CODPESSOA FROM TB_FISICA PF WHERE PF.CPF=V_CPF_CNPJ;
		ELSIF(VALIDA_CNPJ(V_CPF_CNPJ) = 'SIM') THEN
			SELECT REF(PJ), PJ.COD INTO REFCLIENTE, CODPESSOA FROM TB_JURIDICA PJ WHERE PJ.CNPJ=V_CPF_CNPJ;
		END IF;
		SELF.COD := CODPESSOA;
		SELF.REF_CLIENTE := REFCLIENTE;
		SELF.DATAREGISTRO := SYSDATE;
		SELF.RENDA:=NULL;
		RETURN;
	END TP_CLIENTE;
	CONSTRUCTOR FUNCTION TP_CLIENTE(CPF IN VARCHAR2, RENDA IN NUMBER) RETURN SELF AS RESULT AS REFCLIENTEPESSOAFISICA REF TP_FISICA;
	CODPESSOA NUMBER;
	V_CPF VARCHAR2(11);
	BEGIN
		V_CPF:=CPF;
		SELECT REF(PF), PF.COD INTO REFCLIENTEPESSOAFISICA, CODPESSOA FROM TB_FISICA PF WHERE PF.CPF=V_CPF;
		SELF.COD := CODPESSOA;
		SELF.REF_CLIENTE := REFCLIENTEPESSOAFISICA;
		SELF.DATAREGISTRO := SYSDATE;
		SELF.RENDA := RENDA;
		RETURN;
	END TP_CLIENTE;
END;
/
CREATE OR REPLACE TYPE BODY TP_CARGO AS 
	MEMBER FUNCTION GETINFO RETURN VARCHAR2 AS RETORNO VARCHAR2(855);
	BEGIN
		SELECT
			' C�DIGO DO CARGO: ' || TO_CHAR(SELF.COD) ||
			' DESCRICAO: ' || (SELF.DESCRICAO)
			INTO RETORNO FROM DUAL;
		RETURN RETORNO;
	END GETINFO;
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_CARGO) RETURN NUMBER AS
	BEGIN
		RETURN (SELF.COD - OBJ.COD); -- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
	END EQUALS;
	STATIC FUNCTION COMPARE(OBJ1 TP_CARGO, OBJ2 TP_CARGO) RETURN BOOLEAN AS RETORNO BOOLEAN;
	BEGIN
		RETORNO:=FALSE;
		IF (TO_CHAR(OBJ1.COD) = TO_CHAR(OBJ2.COD) OR (OBJ1.DESCRICAO=OBJ2.DESCRICAO)) THEN
			RETORNO:=TRUE;
		ELSE
			RETORNO:=FALSE;
		END IF;
		RETURN RETORNO;
	END COMPARE;
	CONSTRUCTOR FUNCTION TP_CARGO(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT AS
	BEGIN
		SELF.COD := SEQ_CARGO.NEXTVAL;
		SELF.DESCRICAO := DESCRICAO;
		RETURN;
	END TP_CARGO;
END;
/
CREATE OR REPLACE TYPE BODY TP_SETOR AS
	MEMBER FUNCTION GETINFO RETURN VARCHAR2 AS RETORNO VARCHAR2(855);
	BEGIN
		SELECT
			' C�DIGO DO SETOR: ' || TO_CHAR(SELF.COD) ||
			' DESCRI��O: ' || (SELF.DESCRICAO)
			INTO RETORNO FROM DUAL;
			RETURN RETORNO;
	END GETINFO;
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_SETOR) RETURN NUMBER AS
	BEGIN
		RETURN (SELF.COD - OBJ.COD); -- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
	END EQUALS;
	STATIC FUNCTION COMPARE(OBJ1 TP_SETOR, OBJ2 TP_SETOR) RETURN BOOLEAN AS RETORNO BOOLEAN;
	BEGIN
		RETORNO := FALSE;
		IF (TO_CHAR(OBJ1.COD) = TO_CHAR(OBJ2.COD) OR (OBJ1.DESCRICAO=OBJ2.DESCRICAO)) THEN
			RETORNO := TRUE;
		ELSE
			RETORNO := FALSE;
		END IF;
		RETURN RETORNO;
	END COMPARE;
	CONSTRUCTOR FUNCTION TP_SETOR(DESCRICAO IN VARCHAR2) RETURN SELF AS RESULT AS
	BEGIN
		SELF.COD := SEQ_SETOR.NEXTVAL;
		SELF.DESCRICAO := DESCRICAO;
		RETURN;
	END TP_SETOR;
END;
/
CREATE OR REPLACE TYPE BODY TP_JORNADA AS MEMBER FUNCTION GETINFO RETURN VARCHAR2 AS RETORNO VARCHAR2(855);
	BEGIN
		SELECT
		' C�DIGO DO JORNADA: ' || TO_CHAR(SELF.COD) ||
		' DESCRI��O: ' || (SELF.DESCRICAO) ||
		' HOR�RIO INICIO: ' || TO_CHAR((SELF.HORAINICIO), 'HH24:MI:SS')||
		' HOR�RIO FIM: ' || TO_CHAR((SELF.HORAFIM), 'HH24:MI:SS')
		INTO RETORNO FROM DUAL;
		RETURN RETORNO;
	END GETINFO;
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_JORNADA) RETURN NUMBER AS
	BEGIN
		RETURN (SELF.COD - OBJ.COD); -- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
	END EQUALS;
	STATIC FUNCTION COMPARE(OBJ1 TP_JORNADA, OBJ2 TP_JORNADA) RETURN BOOLEAN AS RETORNO BOOLEAN;
	BEGIN
		RETORNO:=FALSE;
	IF(TO_CHAR(OBJ1.COD) = TO_CHAR(OBJ2.COD) OR (OBJ1.DESCRICAO=OBJ2.DESCRICAO)) THEN
		RETORNO:=TRUE;
	ELSE
		RETORNO:=FALSE;
	END IF;
	RETURN RETORNO;
	END COMPARE;
	CONSTRUCTOR FUNCTION TP_JORNADA(DESCRICAO IN VARCHAR2, HORAINICIO IN INTERVAL DAY TO SECOND, HORAFIM IN INTERVAL DAY TO SECOND) RETURN SELF AS RESULT AS
	BEGIN
			SELF.COD := SEQ_JORNADA.NEXTVAL;
			SELF.DESCRICAO := DESCRICAO;
			SELF.HORAINICIO := HORAINICIO;
			SELF.HORAFIM := HORAFIM);
		RETURN;
	END TP_JORNADA;
END;
/
CREATE OR REPLACE TYPE BODY TP_FUNCIONARIO AS
	MEMBER FUNCTION GETSUMALLGRATIFICACOES RETURN NUMBER AS CONT INTEGER;
	TOTAL NUMBER(8,2);
	BEGIN
		TOTAL:=0;
		IF(SELF.GRATIFICACOES IS NOT NULL) THEN
			FOR CONT IN 1..SELF.GRATIFICACOES.COUNT LOOP
				TOTAL := TOTAL + SELF.GRATIFICACOES(CONT).VALOR;
			END LOOP;
		END IF;
		RETURN TOTAL;
	END GETSUMALLGRATIFICACOES;
	MEMBER FUNCTION GETTOTGRATIFICACOESBYANO(ANO IN INTEGER) RETURN NUMBER AS TOTAL NUMBER(8,2);
	BEGIN
		TOTAL:=0;
		IF(SELF.GRATIFICACOES IS NOT NULL AND UTL_COLL.IS_LOCATOR(SELF.GRATIFICACOES)) THEN
			SELECT SUM(G.VALOR) INTO TOTAL
				FROM TABLE(CAST(SELF.GRATIFICACOES AS NESTED_GRATIFICACAO)) G
				WHERE TO_CHAR(G.PERIODO,'YYYY') = TO_CHAR(ANO);
		END IF;
		RETURN TOTAL;
	END GETTOTGRATIFICACOESBYANO;
	MEMBER FUNCTION GETTOTGRATIFICACOESBYPERIODO(DATAINI IN DATE, DATAFIM IN DATE) RETURN NUMBER AS TOTAL NUMBER(8,2);
	BEGIN
		TOTAL := 0;
		IF (SELF.GRATIFICACOES IS NOT NULL AND UTL_COLL.IS_LOCATOR(SELF.GRATIFICACOES)) THEN
			SELECT SUM(G.VALOR) INTO TOTAL
				FROM TABLE(CAST(SELF.GRATIFICACOES AS NESTED_GRATIFICACAO)) G
				WHERE R(G.PERIODO,'DD/MM/YYYY') BETWEEN TO_CHAR(DATAINI,'DD/MM/YYYY') AND TO_CHAR(DATAFIM,'DD/MM/YYYY');
		END IF;
	END GETTOTGRATIFICACOESBYPERIODO;
	MEMBER FUNCTION GETTOTGRATIFICACOESBYMESANO(MES IN INTEGER,ANO IN INTEGER) RETURN NUMBER AS TOTAL NUMBER(8,2);
	MESANO VARCHAR2(8);
	BEGIN
		TOTAL := 0;
		IF(SELF.GRATIFICACOES IS NOT NULL AND UTL_COLL.IS_LOCATOR(SELF.GRATIFICACOES)) THEN
			MESANO := TO_CHAR(MES) || '/' || TO_CHAR(ANO);
			SELECT SUM(G.VALOR) INTO TOTAL 
				FROM TABLE(CAST(SELF.GRATIFICACOES AS NESTED_GRATIFICACAO)) G
				WHERE TO_CHAR(G.PERIODO,'MM/YYYY') = MESANO;
		END IF;
	RETURN TOTAL;
	END GETTOTGRATIFICACOESBYMESANO;
	MEMBER FUNCTION GETCARGO RETURN VARCHAR2 AS
	RETORNO VARCHAR2(455);
	BEGIN
		SELECT DEREF(F.REF_CARGO).GETINFO() INTO RETORNO
			FROM TB_FUNCIONARIO F
			WHERE SELF.MATRICULA=F.MATRICULA;
		RETURN RETORNO;
	END GETCARGO;
	MEMBER FUNCTION GETSTATUS RETURN VARCHAR2 AS
	RETORNO VARCHAR2(25);
	BEGIN
		IF(SELF.STATUS='A') THEN
			RETORNO:='ATIVO';
		ELSE
			RETORNO:='INATIVO';
		END IF;
		RETURN RETORNO;
	END GETSTATUS;
	MEMBER FUNCTION GETINFO RETURN VARCHAR2 AS RETORNO VARCHAR2(1255);
	INFOFUNC VARCHAR(550);
	BEGIN
		SELECT DEREF(F.REF_PESSOAFISICA).GETINFO() INTO INFOFUNC 
			FROM TB_FUNCIONARIO F 
			WHERE F.MATRICULA=SELF.MATRICULA;
		RETORNO := ' DATA DE ADMISS�O: ' || TO_CHAR(SELF.DATAADMISSAO,'DD/MM/YYYY');
		RETORNO := RETORNO || ' MATR�CULA: ' || TO_CHAR(SELF.MATRICULA);
		RETORNO := RETORNO || ' SAL�RIO: ' || TO_CHAR(SELF.SALARIO);
		RETORNO := RETORNO || ' STATUS: ' || TO_CHAR(SELF.GETSTATUS());
		RETORNO := RETORNO || ' DADOS DO FUNCION�RIO: ' || INFOFUNC;
		RETURN RETORNO;
	END GETINFO;
	MEMBER FUNCTION GETINFORESUMIDA RETURN VARCHAR2 AS RETORNO VARCHAR2(1255);
	NOMEFUNC VARCHAR2(50);
	BEGIN
		SELECT DEREF(F.REF_PESSOAFISICA).NOME INTO NOMEFUNC 
			FROM TB_FUNCIONARIO F 
			WHERE F.MATRICULA=SELF.MATRICULA;
		RETORNO:=' MATR�CULA: '||TO_CHAR(SELF.MATRICULA)||' NOME DO FUNCION�RIO: '||NOMEFUNC;
		RETURN RETORNO;
	END GETINFORESUMIDA;
	MEMBER FUNCTION GETINFOSUPERVISOR RETURN VARCHAR2 AS RETORNO VARCHAR2(1255);
	INFOSUPERVISOR VARCHAR2(550);
	BEGIN
		SELECT DEREF(F.REF_SUPERVISOR).GETINFO() INTO INFOSUPERVISOR 
			FROM TB_FUNCIONARIO F 
			WHERE F.MATRICULA=SELF.MATRICULA;
		RETORNO := ' DADOS DO SUPERVISOR: ' || INFOSUPERVISOR;
		RETURN RETORNO;
	END GETINFOSUPERVISOR;
	MEMBER FUNCTION POSSUISUPERVISOR RETURN BOOLEAN AS RETORNO BOOLEAN;
	REFFUNC REF TP_FUNCIONARIO;
	BEGIN
		SELECT REF(F) INTO REFFUNC
			FROM TB_FUNCIONARIO F
			WHERE F.MATRICULA=SELF.MATRICULA AND (F.REF_SUPERVISOR IS NOT DANGLING);
		IF(SELF.REF_SUPERVISOR IS NOT NULL AND REFFUNC IS NOT NULL) THEN
			RETORNO := TRUE;
		ELSE
			RETORNO:=FALSE;
		END IF;
		RETURN RETORNO;
	END POSSUISUPERVISOR;
	MEMBER FUNCTION GETFUNCIOARIOSSUPERVISIONADOS RETURN VARCHAR2 AS RETORNO VARCHAR2(2855);
	CONT NUMBER;
	CURSOR C_FSUPERVISIONADOS IS 
		SELECT F.GETINFORESUMIDA() AS FUNC 
			FROM TB_FUNCIONARIO F
			WHERE (F.REF_SUPERVISOR IS NOT DANGLING AND
				F.REF_SUPERVISOR IS NOT NULL AND
				SELF.MATRICULA=DEREF(F.REF_SUPERVISOR).MATRICULA)
			ORDER BY (DEREF(F.REF_PESSOAFISICA).NOME);
	V_FSUPERVISIONADOS C_FSUPERVISIONADOS%ROWTYPE;
	BEGIN
		RETORNO:='';
		CONT:=0;
		FOR V_FSUPERVISIONADOS IN C_FSUPERVISIONADOS LOOP
			CONT:=CONT+1;
			RETORNO := RETORNO || ' FUNCION�RIO SUPERVISIONADO ' || TO_CHAR(CONT);
			RETORNO := RETORNO || '� - ' || V_FSUPERVISIONADOS.FUNC;
		END LOOP;
		RETURN RETORNO;
	END GETFUNCIOARIOSSUPERVISIONADOS;
	MAP MEMBER FUNCTION GETMATRICULA RETURN NUMBER AS
	BEGIN
		RETURN SELF.MATRICULA;
	END GETMATRICULA;
	STATIC FUNCTION COMPARE(OBJ1 TP_FUNCIONARIO, OBJ2 TP_FUNCIONARIO) RETURN BOOLEAN AS RETORNO BOOLEAN;
	BEGIN
		RETORNO := FALSE;
		IF(TO_CHAR(OBJ1.MATRICULA)=TO_CHAR(OBJ2.MATRICULA)) THEN
			RETORNO := TRUE;
		ELSE
			RETORNO := FALSE;
		END IF;
		RETURN RETORNO;
	END COMPARE;
END;
/
CREATE OR REPLACE TYPE BODY TP_HISTORICO_SETOR_FUNCIONARIO AS
	STATIC  FUNCTION GETHISTORICOFUNCIONARIO(MATRICULA IN NUMBER) RETURN VARCHAR2 AS RETORNO VARCHAR2(32767);
	CURSOR C_HISTFUN IS
	SELECT TO_CHAR(H.DATAENTRADA,'DD/MM/YYYY HH:MI:SS') AS ENTRADA,
		DEREF(H.REF_SETOR).DESCRICAO AS SETOR,
		TO_CHAR(DEREF(H.REF_FUNCIONARIO).MATRICULA) AS MATRICULA,
		H.REF_JORNADA.GETINFO() AS JORNADA
		FROM TB_HISTORICO_SETOR_FUNCIONARIO H
		WHERE DEREF(H.REF_FUNCIONARIO).MATRICULA=MATRICULA
		ORDER BY H.DATAENTRADA DESC;
	V_HISTFUN C_HISTFUN%ROWTYPE;
	BEGIN
		RETORNO := 'MATRICULA: ' || TO_CHAR(MATRICULA) || CHR(13);
		FOR V_HISTFUN IN C_HISTFUN LOOP
			RETORNO := RETORNO || ' SETOR: ' || V_HISTFUN.SETOR || ' DATA DE ENTRADA: ' || V_HISTFUN.ENTRADA || CHR(13);
			RETORNO := RETORNO || ' SETOR: ' || V_HISTFUN.SETOR || ' DATA DE ENTRADA: ' || V_HISTFUN.ENTRADA || CHR(13);
			RETORNO := RETORNO || V_HISTFUN.JORNADA || CHR(13);
		END LOOP;
		RETURN RETORNO;
	END GETHISTORICOFUNCIONARIO;
	STATIC  FUNCTION GETSETORRECENTEFUNCIONARIO(P_MATRICULA IN NUMBER) RETURN VARCHAR2 AS SETORRECENTE VARCHAR2(32767);
	JORNADA VARCHAR2(32767);
	BEGIN
		SELECT DEREF(H.REF_SETOR).DESCRICAO AS SETOR, H.REF_JORNADA.GETINFO()
		INTO SETORRECENTE, JORNADA
		FROM TB_HISTORICO_SETOR_FUNCIONARIO H
		WHERE DEREF(H.REF_FUNCIONARIO).MATRICULA = P_MATRICULA AND
			H.DATAENTRADA = (SELECT MAX(H2.DATAENTRADA) AS ULTIMADTENTRADA FROM TB_HISTORICO_SETOR_FUNCIONARIO H2 WHERE DEREF(H2.REF_FUNCIONARIO).MATRICULA = P_MATRICULA);
		IF (SETORRECENTE IS NOT NULL) THEN
			SETORRECENTE := 'SETOR RECENTE: ' || TO_CHAR(SETORRECENTE) || CHR(13);
			SETORRECENTE := SETORRECENTE || JORNADA;
		ELSE
			SETORRECENTE := 'SETOR RECENTE: <NENHUM>';
		END IF;
		RETURN SETORRECENTE;
	END GETSETORRECENTEFUNCIONARIO;
	STATIC FUNCTION GETFUNCIONARIOSDOSETOR(DESCSETOR IN VARCHAR2) RETURN VARCHAR2 AS RETORNO VARCHAR2(32767);
	CURSOR C_HISTFUNSETOR IS
		SELECT DISTINCT DEREF(H.REF_FUNCIONARIO).MATRICULA AS MATRICULA,
			DEREF(DEREF(H.REF_FUNCIONARIO).REF_PESSOAFISICA).NOME AS FUNCIONARIO,
			TO_CHAR(H.DATAENTRADA,'DD/MM/YYYY HH:MI:SS') AS ENTRADA
			FROM TB_HISTORICO_SETOR_FUNCIONARIO H
			WHERE DEREF(H.REF_SETOR).DESCRICAO = DESCSETOR AND
				H.DATAENTRADA = (SELECT MAX(H2.DATAENTRADA) AS ULTIMADTENTRADA
								FROM TB_HISTORICO_SETOR_FUNCIONARIO H2
								WHERE DEREF(H2.REF_FUNCIONARIO).MATRICULA=DEREF(H.REF_FUNCIONARIO).MATRICULA);
	V_HISTFUNSETOR C_HISTFUNSETOR%ROWTYPE;
	BEGIN
		RETORNO := 'SETOR: ' || DESCSETOR || CHR(13);
		FOR V_HISTFUNSETOR IN C_HISTFUNSETOR LOOP
			RETORNO := RETORNO || ' MATR�CULA: ' || V_HISTFUNSETOR.MATRICULA || ' FUNCION�RIO: ' ||
			V_HISTFUNSETOR.FUNCIONARIO || CHR(13) || ' DATA DE ENTRADA: ' || V_HISTFUNSETOR.ENTRADA || CHR(13);
		END LOOP;
		RETURN RETORNO;
	END GETFUNCIONARIOSDOSETOR;
	ORDER MEMBER FUNCTION EQUALS(OBJ TP_HISTORICO_SETOR_FUNCIONARIO) RETURN NUMBER AS COD INTEGER;
	BEGIN
		IF (SELF.DATAENTRADA = OBJ.DATAENTRADA) THEN
			COD := 0; --DATA DO OBJETO � IGUAL
		ELSIF (SELF.DATAENTRADA > OBJ.DATAENTRADA) THEN
			COD := -1; --DATA DO OBJETO � MENOR
		ELSE
			COD := 1; --DATA DO OBJETO � MAIOR
		END IF;
		RETURN  COD;-- ZERO: SELF > OBJ | NEGATIVO: SELF < OBJ | POSITIVO: SELF > OBJ
	END EQUALS;
	STATIC FUNCTION COMPARE(OBJ1 TP_HISTORICO_SETOR_FUNCIONARIO, OBJ2 TP_HISTORICO_SETOR_FUNCIONARIO) RETURN BOOLEAN AS RETORNO BOOLEAN;
	BEGIN
		RETORNO := FALSE;
		IF(TO_CHAR(OBJ1.DATAENTRADA,'DD/MM/YYYY/ HH:MI:SS') = TO_CHAR(OBJ2.DATAENTRADA,'DD/MM/YYYY/ HH:MI:SS')) THEN
			RETORNO:=TRUE;
		ELSE
			RETORNO:=FALSE;
		END IF;
		RETURN RETORNO;
	END COMPARE;
	CONSTRUCTOR FUNCTION TP_HISTORICO_SETOR_FUNCIONARIO(MATRICULA IN NUMBER, DESCSETOR IN VARCHAR2,DESCJORNADA IN VARCHAR2)  RETURN SELF AS RESULT AS REFSETOR REF TP_SETOR;
	REFFUNCIONARIO REF TP_FUNCIONARIO;
	REFJORNADA REF TP_JORNADA;
	V_MATRICULA NUMBER;
	BEGIN
		V_MATRICULA := MATRICULA;
		SELF.DATAENTRADA := SYSTIMESTAMP;
		SELECT REF(S) INTO REFSETOR FROM TB_SETOR S WHERE S.DESCRICAO=DESCSETOR;
		SELF.REF_SETOR := REFSETOR;
		SELECT REF(F) INTO REFFUNCIONARIO FROM TB_FUNCIONARIO F WHERE F.MATRICULA = V_MATRICULA;
		SELF.REF_FUNCIONARIO := REFFUNCIONARIO;
		SELECT REF(J) INTO REFJORNADA FROM TB_JORNADA J WHERE J.DESCRICAO = DESCJORNADA;
		SELF.REF_JORNADA := REFJORNADA;
		RETURN;
	END TP_HISTORICO_SETOR_FUNCIONARIO;
	CONSTRUCTOR FUNCTION TP_HISTORICO_SETOR_FUNCIONARIO(MATRICULA IN NUMBER, DESCSETOR IN VARCHAR2, DESCJORNADA IN VARCHAR2, MOMENTOENTRADA IN TIMESTAMP) RETURN SELF AS RESULT AS REFSETOR REF TP_SETOR;
	REFFUNCIONARIO REF TP_FUNCIONARIO;
	REFJORNADA REF TP_JORNADA;
	V_MATRICULA NUMBER;
	BEGIN
		V_MATRICULA := MATRICULA;
		SELF.DATAENTRADA := MOMENTOENTRADA;
		SELECT REF(S) INTO REFSETOR FROM TB_SETOR S WHERE S.DESCRICAO = DESCSETOR;
		SELF.REF_SETOR := REFSETOR;
		SELECT REF(F) INTO REFFUNCIONARIO FROM TB_FUNCIONARIO F WHERE F.MATRICULA = V_MATRICULA;
		SELF.REF_FUNCIONARIO := REFFUNCIONARIO;
		SELECT REF(J) INTO REFJORNADA FROM TB_JORNADA J WHERE J.DESCRICAO = DESCJORNADA;
		SELF.REF_JORNADA := REFJORNADA;
		RETURN;
	END TP_HISTORICO_SETOR_FUNCIONARIO;
END;
/







------ cria��o de fun��es e procedimentos �teis no sistema de cart�rio; 
  
  --VALIDA��O DE CPF
  
 create or replace FUNCTION valida_cpf(CPF VARCHAR2 ) RETURN VARCHAR2 IS
  V_CPF_NUMBER  VARCHAR2(14) := REGEXP_REPLACE(CPF, '[^0-9]');
  cpf_c         NUMBER       := lpad(V_CPF_NUMBER,11,'0');
  tam           NUMBER(2)    := LENGTH(SUBSTR(V_CPF_NUMBER,-2,2));
  tot1          NUMBER(4)    := 0;
  tot2          NUMBER(4)    := 0;
  multiplicador NUMBER(2)    := 9;
  digito        NUMBER(1)    := 0;
  resto1        NUMBER(2)    := 0;
  resto2        NUMBER(2)    := 0;
  dc1_cpf       NUMBER(1)    := 0;
  dc2_cpf       NUMBER(1)    := 0;
  digito_dig    CHAR(2)      := SUBSTR(V_CPF_NUMBER,-2,2);
  cpf_x         NUMBER       := SUBSTR(lpad(TO_CHAR(cpf_c),11,'0'),1,9);
  tamanho       NUMBER(2)    := LENGTH(TO_CHAR(cpf_x));
  dc_cpf        CHAR(2);
BEGIN
        FOR i IN reverse 1..tamanho
        LOOP
          tot1          := tot1          + multiplicador * (SUBSTR(TO_CHAR(cpf_x),i,1));
          multiplicador := multiplicador - 1;
        END LOOP;
        resto1    := mod(tot1,11);
        IF resto1  = 10 THEN
          dc1_cpf := 0;
        ELSE
          dc1_cpf := resto1;
        END IF;
        digito        := dc1_cpf;
        tot2          := tot2 + 9 * digito;
        multiplicador := 8;
        FOR i IN reverse 1..tamanho
        LOOP
          tot2          := tot2          + multiplicador * (SUBSTR(TO_CHAR(cpf_x),i,1));
          multiplicador := multiplicador - 1;
        END LOOP;
        resto2    := mod(tot2,11);
        IF resto2  = 10 THEN
          dc2_cpf := 0;
        ELSE
          dc2_cpf := resto2;
        END IF;
        dc_cpf   := TO_CHAR(dc1_cpf) || TO_CHAR(dc2_cpf);
        IF dc_cpf = digito_dig THEN
          RETURN 'SIM';
        ELSE
          RETURN 'N�O';
        END IF;
END valida_cpf;

/

    --VALIDA��O DE CNPJ

CREATE OR REPLACE FUNCTION VALIDA_CNPJ(
  V_CNPJ VARCHAR2)
RETURN VARCHAR2
IS
TYPE ARRAY_DV IS VARRAY(2) OF PLS_INTEGER;
V_ARRAY_DV ARRAY_DV             := ARRAY_DV(0, 0);
CNPJ_DIGIT    CONSTANT PLS_INTEGER := 14;
IS_CNPJ       BOOLEAN;
V_CNPJ_NUMBER VARCHAR2(20);
TOTAL         NUMBER := 0;
COEFICIENTE   NUMBER := 0;
DV1           NUMBER := 0;
DV2           NUMBER := 0;
DIGITO        NUMBER := 0;
J             INTEGER;
I             INTEGER;
BEGIN
  IF V_CNPJ IS NULL THEN
    RETURN 'N�O';
  END IF;
  /*
  Retira os caracteres n�o num�ricos do CNPJ
  caso seja enviado para valida��o um valor com
  a m�scara.
  */
  V_CNPJ_NUMBER := REGEXP_REPLACE(V_CNPJ, '[^0-9]');
  /*
  Verifica se o valor passado � um CNPJ atrav�s do
  n�mero de d�gitos informados. CNPJ = 14
  */
  IS_CNPJ := (LENGTH(V_CNPJ_NUMBER) = CNPJ_DIGIT);
  IF (IS_CNPJ) THEN
    TOTAL := 0;
  ELSE
    RETURN 'N�O';
  END IF;
  /*
  Armazena os valores de d�gitos informados para
  posterior compara��o com os d�gitos verificadores calculados.
  */
  DV1           := TO_NUMBER(SUBSTR(V_CNPJ_NUMBER, LENGTH(V_CNPJ_NUMBER) - 1, 1));
  DV2           := TO_NUMBER(SUBSTR(V_CNPJ_NUMBER, LENGTH(V_CNPJ_NUMBER), 1));
  V_ARRAY_DV(1) := 0;
  V_ARRAY_DV(2) := 0;
  /*
  La�o para c�lculo dos d�gitos verificadores.
  � utilizado m�dulo 11 conforme norma da Receita Federal.
  */
  FOR J IN 1 .. 2
  LOOP
    TOTAL       := 0;
    COEFICIENTE := 2;
    FOR I IN REVERSE 1 .. ((LENGTH(V_CNPJ_NUMBER) - 3) + J)
    LOOP
      DIGITO         := TO_NUMBER(SUBSTR(V_CNPJ_NUMBER, I, 1));
      TOTAL          := TOTAL       + (DIGITO * COEFICIENTE);
      COEFICIENTE    := COEFICIENTE + 1;
      IF (COEFICIENTE > 9) AND IS_CNPJ THEN
        COEFICIENTE  := 2;
      END IF;
    END LOOP; --for i
    V_ARRAY_DV(J)     := 11 - MOD(TOTAL, 11);
    IF (V_ARRAY_DV(J) >= 10) THEN
      V_ARRAY_DV(J)   := 0;
    END IF;
  END LOOP; --for j in 1..2
  /*
  Compara os d�gitos calculados com os informados para informar resultado.
  */
  IF((DV1 = V_ARRAY_DV(1)) AND(DV2 = V_ARRAY_DV(2)))THEN
    RETURN 'SIM';
  ELSE
    RETURN 'N�O';
  END IF;
END VALIDA_CNPJ;

/