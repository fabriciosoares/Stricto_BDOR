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