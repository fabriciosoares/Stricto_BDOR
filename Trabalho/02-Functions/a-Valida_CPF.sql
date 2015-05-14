-- CREATE FUNCTION
CREATE OR REPLACE FUNCTION valida_cpf(CPF VARCHAR2 ) RETURN VARCHAR2 IS
	V_CPF_NUMBER VARCHAR2(14) := REGEXP_REPLACE(CPF, '[^0-9]');
	cpf_c NUMBER := lpad(V_CPF_NUMBER,11,'0');
	tam NUMBER(2) := LENGTH(SUBSTR(V_CPF_NUMBER,-2,2));
	tot1 NUMBER(4) := 0;
	tot2 NUMBER(4) := 0;
	multiplicador NUMBER(2) := 9;
	digito NUMBER(1) := 0;
	resto1 NUMBER(2) := 0;
	resto2 NUMBER(2) := 0;
	dc1_cpf NUMBER(1) := 0;
	dc2_cpf NUMBER(1) := 0;
	digito_dig CHAR(2) := SUBSTR(V_CPF_NUMBER,-2,2);
	cpf_x NUMBER := SUBSTR(lpad(TO_CHAR(cpf_c),11,'0'),1,9);
	tamanho NUMBER(2) := LENGTH(TO_CHAR(cpf_x));
	dc_cpf CHAR(2);
BEGIN
	FOR i IN reverse 1..tamanho
	LOOP
		tot1 := tot1 + multiplicador * (SUBSTR(TO_CHAR(cpf_x),i,1));
		multiplicador := multiplicador - 1;
	END LOOP;
	resto1 := mod(tot1,11);
	IF resto1 = 10 THEN
		dc1_cpf := 0;
	ELSE
		dc1_cpf := resto1;
	END IF;
	digito := dc1_cpf;
	tot2 := tot2 + 9 * digito;
	multiplicador := 8;
	FOR i IN reverse 1..tamanho
	LOOP
		tot2 := tot2 + multiplicador * (SUBSTR(TO_CHAR(cpf_x),i,1));
		multiplicador := multiplicador - 1;
	END LOOP;
	resto2 := mod(tot2,11);
	IF resto2 = 10 THEN
		dc2_cpf := 0;
	ELSE
		dc2_cpf := resto2;
	END IF;
	dc_cpf := TO_CHAR(dc1_cpf) || TO_CHAR(dc2_cpf);
	IF dc_cpf = digito_dig THEN
		RETURN 'SIM';
	ELSE
		RETURN 'NÃO';
	END IF;
END valida_cpf;