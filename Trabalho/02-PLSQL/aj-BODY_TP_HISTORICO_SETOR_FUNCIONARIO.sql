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