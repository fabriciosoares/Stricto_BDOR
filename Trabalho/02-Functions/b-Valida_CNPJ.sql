-- CREATE FUNCTION
CREATE OR REPLACE FUNCTION VALIDA_CNPJ(V_CNPJ VARCHAR2) RETURN VARCHAR2
IS TYPE ARRAY_DV IS VARRAY(2) OF PLS_INTEGER;
	V_ARRAY_DV ARRAY_DV := ARRAY_DV(0, 0);
	CNPJ_DIGIT CONSTANT PLS_INTEGER := 14;
	IS_CNPJ BOOLEAN;
	V_CNPJ_NUMBER VARCHAR2(20);
	TOTAL NUMBER := 0;
	COEFICIENTE NUMBER := 0;
	DV1 NUMBER := 0;
	DV2 NUMBER := 0;
	DIGITO NUMBER := 0;
	J INTEGER;
	I INTEGER;
BEGIN
	IF V_CNPJ IS NULL THEN
		RETURN 'N�O';
	END IF;
	-- Retira os caracteres n�o num�ricos do CNPJ caso seja enviado para valida��o um valor com a m�scara.
	V_CNPJ_NUMBER := REGEXP_REPLACE(V_CNPJ, '[^0-9]');
	-- Verifica se o valor passado � um CNPJ atrav�s do n�mero de d�gitos informados. CNPJ = 14
	IS_CNPJ := (LENGTH(V_CNPJ_NUMBER) = CNPJ_DIGIT);
	IF (IS_CNPJ) THEN
		TOTAL := 0;
	ELSE
		RETURN 'N�O';
	END IF;
	-- Armazena os valores de d�gitos informados para posterior compara��o com os d�gitos verificadores calculados.
	DV1 := TO_NUMBER(SUBSTR(V_CNPJ_NUMBER, LENGTH(V_CNPJ_NUMBER) - 1, 1));
	DV2 := TO_NUMBER(SUBSTR(V_CNPJ_NUMBER, LENGTH(V_CNPJ_NUMBER), 1));
	V_ARRAY_DV(1) := 0;
	V_ARRAY_DV(2) := 0;
	-- La�o para c�lculo dos d�gitos verificadores. � utilizado m�dulo 11 conforme norma da Receita Federal.
	FOR J IN 1 .. 2
	LOOP
		TOTAL := 0;
	    COEFICIENTE := 2;
		FOR I IN REVERSE 1 .. ((LENGTH(V_CNPJ_NUMBER) - 3) + J)
		LOOP
			DIGITO := TO_NUMBER(SUBSTR(V_CNPJ_NUMBER, I, 1));
			TOTAL := TOTAL + (DIGITO * COEFICIENTE);
			COEFICIENTE := COEFICIENTE + 1;
			IF (COEFICIENTE > 9) AND IS_CNPJ THEN
				COEFICIENTE := 2;
			END IF;
		END LOOP;
		V_ARRAY_DV(J) := 11 - MOD(TOTAL, 11);
		IF (V_ARRAY_DV(J) >= 10) THEN
			V_ARRAY_DV(J) := 0;
		END IF;
	END LOOP;
	-- Compara os d�gitos calculados com os informados para informar resultado.
	IF((DV1 = V_ARRAY_DV(1)) AND(DV2 = V_ARRAY_DV(2)))THEN
		RETURN 'SIM';
	ELSE
		RETURN 'N�O';
	END IF;
END VALIDA_CNPJ;