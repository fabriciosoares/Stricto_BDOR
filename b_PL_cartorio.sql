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
          RETURN 'NÃO';
        END IF;
END valida_cpf;
/
--FUNÇÃO DE VALIDAÇÃO DE CNPJ
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
    RETURN 'NÃO';
  END IF;
  *
  Retira os caracteres não numéricos do CNPJ
  caso seja enviado para validação um valor com
  a máscara.
  *
  V_CNPJ_NUMBER := REGEXP_REPLACE(V_CNPJ, '[^0-9]');
  *
  Verifica se o valor passado é um CNPJ através do
  número de dígitos informados. CNPJ = 14
  *
  IS_CNPJ := (LENGTH(V_CNPJ_NUMBER) = CNPJ_DIGIT);
  IF (IS_CNPJ) THEN
    TOTAL := 0;
  ELSE
    RETURN 'NÃO';
  END IF;
  *
  Armazena os valores de dígitos informados para
  posterior comparação com os dígitos verificadores calculados.
  *
  DV1           := TO_NUMBER(SUBSTR(V_CNPJ_NUMBER, LENGTH(V_CNPJ_NUMBER) - 1, 1));
  DV2           := TO_NUMBER(SUBSTR(V_CNPJ_NUMBER, LENGTH(V_CNPJ_NUMBER), 1));
  V_ARRAY_DV(1) := 0;
  V_ARRAY_DV(2) := 0;
  *
  Laço para cálculo dos dígitos verificadores.
  É utilizado módulo 11 conforme norma da Receita Federal.
  *
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
  *
  Compara os dígitos calculados com os informados para informar resultado.
  *
  IF((DV1 = V_ARRAY_DV(1)) AND(DV2 = V_ARRAY_DV(2)))THEN
    RETURN 'SIM';
  ELSE
    RETURN 'NÃO';
  END IF;
END VALIDA_CNPJ;
/