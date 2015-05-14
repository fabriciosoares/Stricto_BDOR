CREATE OR REPLACE proc_gratificacao(v_mes INTEGER, v_ano INTEGER) AS
DECLARE
	v_vlr_mes NUMBER(8,2);
	v_vlr_ant NUMBER(8,2);
	v_matricula INTEGER;
	v_qtd_gratificacao INTEGER;
	CURSOR c_func IS
		SELECT matricula FROM tb_funcionario WHERE status = 'A';
BEGIN
	IF ((v_mes BETWEEN 1 AND 12) AND (v_ano BETWEEN 1980 AND EXTRACT(YEAR FROM SYSDATE)))
	THEN
		SELECT SUM(valortotal) INTO v_vlr_mes FROM tb_atendimento WHERE EXTRACT(MONTH FROM dataatendimento) = v_mes;
		SELECT SUM(valortotal) INTO v_vlr_ant FROM tb_atendimento WHERE EXTRACT(MONTH FROM dataatendimento) = (v_mes - 1);
		SELECT COUNT(*) INTO v_qtd_gratificacao FROM nstb_gratificacoes WHERE periodo = (to_char(v_month) || to_char(v_ano));
		IF (v_vlr_mes > v_vlr_ant AND v_qtd_gratificacao = 0)
		THEN
			OPEN c_func
				LOOP
					FETCH c_func INTO v_matricula;
					INSERT INTO nstb_gratificacoes VALUES (tp_gratificacao(
						v_matricula,
						to_date(tochar(v_mes) || tochar(v_ano),'MMYYYY'),
						(SELECT salario FROM tb_funcionario WHERE matricula = v_matricula) * 0.02))
				END LOOP;
			CLOSE c_func;
		END IF;
		COMMIT;
	ELSE THEN
		DBMS_OUTPUT.ENABLE(1000000);
		DBMS_OUTPUT.PUT_LINE('Os dados inseridos são inválidos!');
	END IF;
	
	EXCEPTION WHEN OTHERS
	THEN
		raise_application_error(-20001,'Erro encontrado - '||SQLCODE||' - ERRO - '||SQLERRM);
		
END proc_gratificacao;
