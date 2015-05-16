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