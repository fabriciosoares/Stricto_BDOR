--------------------------------------------------------------------------------------------------------
-----------------comandos de carga do banco de dados-------------------------------



--inserindo pessoas fisicas no sistema

insert into tb_fisica VALUES(tp_fisica('01210449390','M','WILTON','Rua Jos� Olegario Correia',33,'Alto da Guia','Floriano','PI','64800000'));
insert into tb_fisica VALUES(tp_fisica('53125548632','F','VERONICA','Rua Jos� Olegario Correia',3433,'Alto da Guia','Floriano','PI','64800000'));
insert into tb_fisica VALUES(tp_fisica('44122665671','M','WILTON','Rua Arlindo Nogueira',3243,'Carimbo','Floriano','PI','64800000'));
insert into tb_fisica VALUES(tp_fisica('51492421448','F','VALERIA','Avenida Guararapes',1333,'Santo Ant�nio','Recife','PE','50010000'));
insert into tb_fisica VALUES(tp_fisica('12084546923','M','JO�O','Rua Joel Rodrigues',323,'Mocambinho','Floriano','PI','64800000'));
insert into tb_fisica VALUES(tp_fisica('36245802997','F','CAROLINA','Rua Duarte Coelho',4373,'Santa Teresa','Olinda','PE','53010005'));
insert into tb_fisica VALUES(tp_fisica('93097207511','F','MARIANA','Rua do Joquias Barroso',3343,'Melad�o','Floriano','PI','64800000'));
insert into tb_fisica VALUES(tp_fisica('88571144303','M','CESAR',TP_ENDERECO('Rua do Amarante',233,'Curtume','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Residencial','089','32275682'),TP_TELEFONE('Comercial','089','35156428'))));
insert into tb_fisica VALUES(tp_fisica('10172073057','F','TARSILA',TP_ENDERECO('Rua do Joquias Barroso',2233,'Melad�o','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Residencial','089','32364512'))));
insert into tb_fisica VALUES(tp_fisica('57566231243','F','MARILIA',TP_ENDERECO('Rua do Jose Bonifacio',973,'Centro','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Residencial','089','36564512'))));
insert into tb_fisica VALUES(tp_fisica('56844627238','F','JANAINA',TP_ENDERECO('Rua Joel Rodrigues',221,'Centro','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Comercial','089','32323412'))));
insert into tb_fisica VALUES(tp_fisica('84561662197','M','FLAVIO',TP_ENDERECO('Rua Neucina Pereira da Silva',13,'Melad�o','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Residencial','089','32362534'))));

insert into tb_fisica VALUES(tp_fisica('45355537340','M','FELIPE','Rua Clementino Ribeiro',1654,'Centro','Teresina','PI','64023200'));
insert into tb_fisica VALUES(tp_fisica('79945193937','M','JULIANO','Rua Tr�s Cora��es',3313,'Taboca','Bar�o de Graja�','MA','64800000'));
insert into tb_fisica VALUES(tp_fisica('08185128731','F','FRANCISCA','Rua da Costa e Silva',3311,'Lourival Parente','Floriano','PI','64800000'));
insert into tb_fisica VALUES(tp_fisica('18267230807','M','JONATHAS',TP_ENDERECO('Rua do Joquinha freire',178,'Taboca','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Residencial','089','32338472'))));
insert into tb_fisica VALUES(tp_fisica('52454366550','F','LIVIA',TP_ENDERECO('Rua Bonito',38,'Curadouro','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Empresarial','089','32368374'))));
insert into tb_fisica VALUES(tp_fisica('71698661533','M','OLAVO',TP_ENDERECO('Rua do Piza',57,'Pedro Simplicio','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Empresarial','089','32329872'))));
insert into tb_fisica VALUES(tp_fisica('85481536447','F','RITA',TP_ENDERECO('Rua Monte Castelo',43,'Renascer','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Empresarial','089','32364635'))));
insert into tb_fisica VALUES(tp_fisica('67034615624','M','HENZO',TP_ENDERECO('Rua Jener de Sousa',931,'Jockey','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Comercial','089','32362143'))));


--inserindo pessoas juridicas no sistema


insert into tb_juridica VALUES(tp_juridica('55776472000122','Diamantes Lingerie Variedades Ltda','VERONICA','Rua Jos� Olegario Correia',33,'Alto da Guia','Floriano','PI','64800000'));
insert into tb_juridica VALUES(tp_juridica('81813655000180','Griffes Modas Ltda','TARSILA',TP_ENDERECO('Rua do Joquias Barroso',2233,'Melad�o','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Empresarial','089','35356418'))));
insert into tb_juridica VALUES(tp_juridica('96427338000101','Auto Pe�as Moura Ltda','LEANDRO',TP_ENDERECO('Rua Felix Pacheco',76,'Aldeota','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Empresarial','089','35353422'))));
insert into tb_juridica VALUES(tp_juridica('54552735000157','RM Sistemas Ltda','BRIGIDA',TP_ENDERECO('Rua Bonito',45,'Taboca','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Empresarial','089','35352222'))));
insert into tb_juridica VALUES(tp_juridica('71854793000154','Comer Bem Ltda','LUCAS',TP_ENDERECO('Rua do Anaquim Barros',12,'Castro Alves','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Empresarial','089','35354573'))));
insert into tb_juridica VALUES(tp_juridica('70228623000100','Armarinho do Zeca Ltda','JOSE CARLOS',TP_ENDERECO('Rua do Jaime Rodrigues',374,'Centro','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Empresarial','089','35357362'))));
insert into tb_juridica VALUES(tp_juridica('81326646000165','Ivan Varieades Ltda','IVAN GOMES',TP_ENDERECO('Rua do Jaime Rodrigues',129,'Centro','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Empresarial','089','35350978'))));
insert into tb_juridica VALUES(tp_juridica('58112903000144','Construtrotora Franquel Ltda','RAQUEL',TP_ENDERECO('Rua do Jaime Rodrigues',1456,'Centro','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Empresarial','089','35354625'))));
insert into tb_juridica VALUES(tp_juridica('79562568000156','Globo Papelaria Modas Ltda','FATIMA',TP_ENDERECO('Rua do Anaquim Barros',938,'Castro Alves','Floriano','PI','64800000'),ARRAY_TELEFONE(TP_TELEFONE('Empresarial','089','35352382'))));


insert into tb_cargo values(TP_CARGO('Recepcionista'));
insert into tb_cargo values(TP_CARGO('Atendente'));
insert into tb_cargo values(TP_CARGO('Auxiliar de cart�rio'));
insert into tb_cargo values(TP_CARGO('Escrevente'));
insert into tb_cargo values(TP_CARGO('Tabeli�o'));
insert into tb_cargo values(TP_CARGO('Auxiliar de limpeza'));
insert into tb_cargo values(TP_CARGO('Telefonista'));

--inserindo os setores onde os funcion�rios poder�o atuar no cart�rio

insert into tb_setor values(TP_SETOR('Recep��o'));
insert into tb_setor values(TP_SETOR('Registro Civil'));
insert into tb_setor values(TP_SETOR('Registro de Notas'));
insert into tb_setor values(TP_SETOR('Arquivamento'));
insert into tb_setor values(TP_SETOR('Digita��o'));
insert into tb_setor values(TP_SETOR('Geral'));

insert into tb_jornada values(tp_jornada('De 07:30 �s 17:30',interval '0 07:30:00' day(0) to second, interval '0 17:30:00' day(0) to second));
insert into tb_jornada values(tp_jornada('De 07:30 �s 12:30',interval '0 07:30:00' day(0) to second, interval '0 12:30:00' day(0) to second));
insert into tb_jornada values(tp_jornada('De 12:30 �s 17:30',interval '0 12:30:00' day(0) to second, interval '0 17:30:00' day(0) to second));
insert into tb_jornada values(tp_jornada('De 17:30 �s 21:30',interval '0 17:30:00' day(0) to second, interval '0 21:30:00' day(0) to second));

commit;
--------------------------------------------------------------------------------------------------
--inserindo funcionarios do cart�rio 

--Felipe nao possui supervisor e nem gratificacoes
INSERT INTO TB_FUNCIONARIO VALUES(TP_FUNCIONARIO(SYSDATE,
(SELECT P.COD FROM TB_FISICA P WHERE P.CPF='45355537340'),
'felipe12345',4500,'A',(SELECT REF(P) FROM TB_FISICA P WHERE P.CPF='45355537340'),
(SELECT REF(CT) FROM TB_CARGO CT WHERE CT.DESCRICAO LIKE '%Tabeli�o%'),NULL,NULL));


--Olavo n�o possui supervisor e recebe gratificacoes no m�s pois tem experiencia como escrevente
INSERT INTO TB_FUNCIONARIO VALUES(TP_FUNCIONARIO(SYSDATE,
(SELECT P.COD FROM TB_FISICA P WHERE P.CPF='71698661533'),
'olavo86',1500,'A',(SELECT REF(P) FROM TB_FISICA P WHERE P.CPF='71698661533'),
(SELECT REF(CT) FROM TB_CARGO CT WHERE CT.DESCRICAO LIKE '%Escrevente%'),NULL,nested_gratificacao(tp_gratificacao(to_date('062015','MMYYYY'),150),tp_gratificacao(to_date('052015','MMYYYY'),150))));


--Jonatas supevisionado por felipe. Jonatas alem disso recebe gratifica��es por supervisionar auxiliares de cartorio.
INSERT INTO TB_FUNCIONARIO VALUES(TP_FUNCIONARIO(SYSDATE,
(SELECT P.COD FROM TB_FISICA P WHERE P.CPF='18267230807'),
'jonatas2015',1500,'A',(SELECT REF(P) FROM TB_FISICA P WHERE P.CPF='18267230807'),
(SELECT REF(CT) FROM TB_CARGO CT WHERE CT.DESCRICAO LIKE '%Escrevente%'),(select ref(f) from tb_funcionario f where f.ref_pessoafisica.cpf='45355537340'),nested_gratificacao(tp_gratificacao(to_date('062015','MMYYYY'),150),tp_gratificacao(to_date('052015','MMYYYY'),150))));

--Henzo supervisionado pelo olavo
INSERT INTO TB_FUNCIONARIO VALUES(TP_FUNCIONARIO(SYSDATE,
(SELECT P.COD FROM TB_FISICA P WHERE P.CPF='67034615624'),
'henzo123',850,'A',(SELECT REF(P) FROM TB_FISICA P WHERE P.CPF='67034615624'),
(SELECT REF(CT) FROM TB_CARGO CT WHERE CT.DESCRICAO LIKE '%Auxiliar de cart�rio%'),(SELECT REF(F) FROM TB_FUNCIONARIO F WHERE F.REF_PESSOAFISICA.CPF='71698661533'),NULL));


--Livia supevisionada por felipe e nao possui gratificacoes
INSERT INTO TB_FUNCIONARIO VALUES(TP_FUNCIONARIO(SYSDATE,
(SELECT P.COD FROM TB_FISICA P WHERE P.CPF='52454366550'),
'livialinda',1500,'A',(SELECT REF(P) FROM TB_FISICA P WHERE P.CPF='52454366550'),
(SELECT REF(CT) FROM TB_CARGO CT WHERE CT.DESCRICAO LIKE '%Escrevente%'),(SELECT REF(F) FROM TB_FUNCIONARIO F WHERE F.REF_PESSOAFISICA.CPF='45355537340'),NULL));


--Juliano supervisionado pela livia
INSERT INTO TB_FUNCIONARIO VALUES(TP_FUNCIONARIO(SYSDATE,
(SELECT P.COD FROM TB_FISICA P WHERE P.CPF='79945193937'),
'juliano1985',850,'A',(SELECT REF(P) FROM TB_FISICA P WHERE P.CPF='79945193937'),
(SELECT REF(CT) FROM TB_CARGO CT WHERE CT.DESCRICAO LIKE '%Auxiliar de cart�rio%'),(SELECT REF(F) FROM TB_FUNCIONARIO F WHERE F.REF_PESSOAFISICA.CPF='52454366550'),NULL));

--Rita supervisionada pelo jonatas
INSERT INTO TB_FUNCIONARIO VALUES(TP_FUNCIONARIO(SYSDATE,
(SELECT P.COD FROM TB_FISICA P WHERE P.CPF='85481536447'),
'ritacadilac',790,'A',(SELECT REF(P) FROM TB_FISICA P WHERE P.CPF='85481536447'),
(SELECT REF(CT) FROM TB_CARGO CT WHERE CT.DESCRICAO LIKE '%Atendente%'),(SELECT REF(F) FROM TB_FUNCIONARIO F WHERE F.REF_PESSOAFISICA.CPF='18267230807'),NULL));

--Francisca supervisionada pelo jonatas
INSERT INTO TB_FUNCIONARIO VALUES(TP_FUNCIONARIO(SYSDATE,
(SELECT P.COD FROM TB_FISICA P WHERE P.CPF='08185128731'),
'chica12345',790,'A',(SELECT REF(P) FROM TB_FISICA P WHERE P.CPF='08185128731'),
(SELECT REF(CT) FROM TB_CARGO CT WHERE CT.DESCRICAO LIKE '%Atendente%'),(SELECT REF(F) FROM TB_FUNCIONARIO F WHERE F.REF_PESSOAFISICA.CPF='18267230807'),NULL));



--indicando em que setor cada funcion�rio ir� atuar (A tabela armazena tamb�m o hist�rico de setores por onde o funcion�rio trabalhou)

insert into tb_historico_setor_funcionario values(tp_historico_setor_funcionario((select f.matricula as matricula from tb_funcionario f where deref(f.ref_pessoafisica).cpf='45355537340'),'Geral','De 17:30 �s 21:30'));
insert into tb_historico_setor_funcionario values(tp_historico_setor_funcionario((select f.matricula as matricula from tb_funcionario f where deref(f.ref_pessoafisica).cpf='52454366550'),'Registro Civil','De 07:30 �s 17:30',to_date('01052015 18:38:30','DDMMYYYY HH24:MI:ss')));
insert into tb_historico_setor_funcionario values(tp_historico_setor_funcionario((select f.matricula from tb_funcionario f where deref(f.ref_pessoafisica).cpf='71698661533'),'Registro Civil','De 07:30 �s 12:30',to_date('02052015 18:38:30','DDMMYYYY HH24:MI:ss')));
insert into tb_historico_setor_funcionario values(tp_historico_setor_funcionario((select f.matricula from tb_funcionario f where deref(f.ref_pessoafisica).cpf='18267230807'),'Registro de Notas','De 07:30 �s 17:30',to_date('03052015 18:38:30','DDMMYYYY HH24:MI:ss')));
insert into tb_historico_setor_funcionario values(tp_historico_setor_funcionario((select f.matricula from tb_funcionario f where deref(f.ref_pessoafisica).cpf='67034615624'),'Arquivamento','De 07:30 �s 17:30',to_date('04052015 18:20:35','DDMMYYYY HH24:MI:ss')));
insert into tb_historico_setor_funcionario values(tp_historico_setor_funcionario((select f.matricula from tb_funcionario f where deref(f.ref_pessoafisica).cpf='79945193937'),'Digita��o','De 07:30 �s 17:30',to_date('04052015 18:20:30','DDMMYYYY HH24:MI:ss')));
insert into tb_historico_setor_funcionario values(tp_historico_setor_funcionario((select f.matricula from tb_funcionario f where deref(f.ref_pessoafisica).cpf='85481536447'),'Recep��o','De 07:30 �s 17:30',to_date('05052015 18:37:30','DDMMYYYY HH24:MI:ss')));
insert into tb_historico_setor_funcionario values(tp_historico_setor_funcionario((select f.matricula from tb_funcionario f where deref(f.ref_pessoafisica).cpf='08185128731'),'Recep��o','De 07:30 �s 17:30',to_date('05052015 18:37:20','DDMMYYYY HH24:MI:ss')));


--inserindo os clientes do cart�rio

  --clientes pessoa fisica
insert into tb_cliente values(tp_cliente('01210449390')); --cliente pf wilton
insert into tb_cliente values(tp_cliente('53125548632')); --cliente pf veronica
insert into tb_cliente values(tp_cliente('44122665671')); --cliente pf wilton outro
insert into tb_cliente values(tp_cliente('12084546923'));--cliente pf JO�O
insert into tb_cliente values(tp_cliente('93097207511'));--cliente pf MARIANA
insert into tb_cliente values(tp_cliente('10172073057'));--cliente pf TARSILA
insert into tb_cliente values(tp_cliente('56844627238'));--cliente pf JANAINA
insert into tb_cliente values(tp_cliente('84561662197'));--cliente pf FLAVIO
insert into tb_cliente values(tp_cliente('51492421448',450));--cliente pf valeria declarou renda 
insert into tb_cliente values(tp_cliente('88571144303',670));--cliente pf CESAR declarou renda
insert into tb_cliente values(tp_cliente('57566231243',890));--cliente pf MARILIA declarou renda
insert into tb_cliente values(tp_cliente('36245802997',1250));--cliente pf CAROLINA declarou renda


  --clientes pessoa juridica
    
insert into tb_cliente values(tp_cliente('55776472000122'));--cliente pj veronica diamantes
insert into tb_cliente values(tp_cliente('81813655000180'));--cliente pj TARSILA Griffes
insert into tb_cliente values(tp_cliente('96427338000101'));--cliente pj leandro Auto Pe�as
insert into tb_cliente values(tp_cliente('54552735000157'));--cliente pj brigida RM Sistemas
insert into tb_cliente values(tp_cliente('71854793000154'));--cliente pj lucas Comer Bem
insert into tb_cliente values(tp_cliente('70228623000100'));--cliente pj jose carlos Armarinho do Zeca
insert into tb_cliente values(tp_cliente('81326646000165'));--cliente pj Ivan Varieades ivan
insert into tb_cliente values(tp_cliente('58112903000144'));--cliente pj raquel Construtrotora Franquel 
insert into tb_cliente values(tp_cliente('79562568000156'));--cliente pj fatima Globo Papelaria


-- inserir tipos de servicos ofertados pelo cart�rio

insert into tb_tiposervico values(tp_tiposervico('Oficiais do Registro Civil'));
insert into tb_tiposervico values(tp_tiposervico('Oficiais de Protesto de T�tulos'));
insert into tb_tiposervico values(tp_tiposervico('Oficiais do Registro de T�tulos e Documentos  Pessoas Jur�dicas'));
insert into tb_tiposervico values(tp_tiposervico('Oficiais de Registro de Im�veis'));
insert into tb_tiposervico values(tp_tiposervico('Tabeli�es de Notas'));
insert into tb_tiposervico values(tp_tiposervico('Diversos - Atos Comuns e Isolados'));

-- inserir servicos ofertados pelo cart�rio 
 
  --servi�os de registro civil realizados pelo cartorio
  insert into tb_servico values(tp_servico('Casamento Civil',162.33,'Oficiais do Registro Civil'));
  insert into tb_servico values(tp_servico('Casamento Civil com efeito religioso',186.69,'Oficiais do Registro Civil'));
  insert into tb_servico values(tp_servico('2� Via de certid�o de nascimento, casamento e �bito, al�m da busca',12.99,'Oficiais do Registro Civil'));
  insert into tb_servico values(tp_servico('Averba��o de escritura de separa��o e div�rcio consensual',97.41	,'Oficiais do Registro Civil'));
  insert into tb_servico values(tp_servico('Termo de reconhecimento de paternidade, inclusive a averba��o e certid�o',129.88	,'Oficiais do Registro Civil'));
  insert into tb_servico values(tp_servico('Averba��o no registro de nascimento, casamento ou �bito, em virtude de senten�a',64.93	,'Oficiais do Registro Civil'));
  insert into tb_servico values(tp_servico('Inscri��o, transcri��o ou registro de senten�a, escritura de interdi��o, emancipa��o ou aus�ncia',64.93,'Oficiais do Registro Civil'));

  --servi�os de protesto de titulos realizados pelo cartorio
    
  insert into tb_servico values(tp_servico('Protesto de T�tulos de 61,93',19.48,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('Protesto de T�tulos de 61,94 a 92,90',35.72,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('Protesto de T�tulos de 92,91 a 139,35',43.82,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('Protesto de T�tulos acima de 139,35',64.93,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('Apontamento do t�tulo no prazo de 72:00 horas (Al�m da tarifa dos correios)',11.36,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('Apontamento lan�ado no protesto',11.36,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('1� Via da Baixa de Protesto com respectiva certid�o',16.24,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('Retirada, desist�ncia, susta��o de t�tulo (al�m da tarifa dos correios)',11.36,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('Arquivamento do registro do protesto',8.11,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('Certid�o negativapositiva de protesto',16.24,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('S�cio excedente (acima de dois) nas Certid�es negativapositiva de protesto',4.85,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('Certid�o de 2� via de baixa de protesto',16.24,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('Certid�o de 2� via de instrumento de protesto',16.24,'Oficiais de Protesto de T�tulos'));  
  insert into tb_servico values(tp_servico('Informa��o de protesto de t�tulos por nome (Rela��o de T�tulos)	',3.25,'Oficiais de Protesto de T�tulos'));  

  --servi�os Oficiais do Registro de T�tulos e Documentos  Pessoas Jur�dicas realizados pelo cartorio

  insert into tb_servico values(tp_servico('Registro de T�tulo com Valor Declarado at� 32,00',56.83,'Oficiais do Registro de T�tulos e Documentos  Pessoas Jur�dicas'));   
  insert into tb_servico values(tp_servico('Registro de T�tulo com Valor Declarado de 32,01	a	84,64',89.29,'Oficiais do Registro de T�tulos e Documentos  Pessoas Jur�dicas'));   
  insert into tb_servico values(tp_servico('Registro de T�tulo com Valor Declarado de 84,65	a 336,51',121.75,'Oficiais do Registro de T�tulos e Documentos  Pessoas Jur�dicas'));   
  insert into tb_servico values(tp_servico('Registro de T�tulo com Valor Declarado  acima de 336,51',138.00,'Oficiais do Registro de T�tulos e Documentos  Pessoas Jur�dicas'));   
  insert into tb_servico values(tp_servico('Registro de t�tulos, contratos ou documentos sem valor financeiro',48.71,'Oficiais do Registro de T�tulos e Documentos  Pessoas Jur�dicas'));   
  insert into tb_servico values(tp_servico('Notifica��o, al�m do registro',40.59,'Oficiais do Registro de T�tulos e Documentos  Pessoas Jur�dicas'));

  -- servi�os Oficiais de Registro de Im�veis realizados pelo cartorio

  insert into tb_servico values(tp_servico('Registros e Contratos at� 386,06',170.45,'Oficiais de Registro de Im�veis'));
  insert into tb_servico values(tp_servico('Registros e Contratos de 386,07 a 772,12',194.80,'Oficiais de Registro de Im�veis'));
  insert into tb_servico values(tp_servico('Registros e Contratos acima de 772,13',227.26,'Oficiais de Registro de Im�veis'));
  insert into tb_servico values(tp_servico('Registros e Contratos (SFH  FGTS) ',0.0,'Oficiais de Registro de Im�veis'));
  insert into tb_servico values(tp_servico('Registros e Contratos (PAR) ',0.0,'Oficiais de Registro de Im�veis'));
  insert into tb_servico values(tp_servico('Registro de Hipoteca, C�dula Rural, por im�vel ',154.23,'Oficiais de Registro de Im�veis'));
  insert into tb_servico values(tp_servico('Averba��o com valor financeiro at� 10.735,31',97.41,'Oficiais de Registro de Im�veis'));
  insert into tb_servico values(tp_servico('Averba��o com valor financeiro de 10.735,32 a 63.792,50 ',154.23,'Oficiais de Registro de Im�veis'));
  insert into tb_servico values(tp_servico('Averba��o com valor financeiro acima de 63.792,50',227.26,'Oficiais de Registro de Im�veis'));
  

  -- servi�os de Tabeli�es de Notas realizados pelo cartorio
 
  insert into tb_servico values(tp_servico('Escritura, incluindo o 1� Traslado at� 851,60',194.80,'Tabeli�es de Notas')); 
  insert into tb_servico values(tp_servico('Escritura, incluindo o 1� Traslado de 851,61 a 1.156,11',227.26,'Tabeli�es de Notas')); 
  insert into tb_servico values(tp_servico('Escritura, incluindo o 1� Traslado acima de 1.156,11 ',259.74,'Tabeli�es de Notas')); 
  insert into tb_servico values(tp_servico('Escritura sem valor declarado',121.75,'Tabeli�es de Notas')); 


  -- servi�os Diversos - Atos Comuns e Isolados realizados pelo cartorio
  
  insert into tb_servico values(tp_servico('Reconhecimento de Firma (por assinatura)',3.5,'Diversos - Atos Comuns e Isolados')); 
  insert into tb_servico values(tp_servico('Arquivamento de firma ou sinal',3.5,'Diversos - Atos Comuns e Isolados')); 
  insert into tb_servico values(tp_servico('Autentica��o de c�pia reprogr�fica (documento)',2.19,'Diversos - Atos Comuns e Isolados')); 
  insert into tb_servico values(tp_servico('Certid�o negativapositiva por pessoa f�sica ou jur�dica (individual)',14.60,'Diversos - Atos Comuns e Isolados')); 
  insert into tb_servico values(tp_servico('Certid�o por c�pia reprogr�fica',16.24,'Diversos - Atos Comuns e Isolados')); 
  insert into tb_servico values(tp_servico('Certid�o por c�pia reprogr�fica com �nus',32.46,'Diversos - Atos Comuns e Isolados')); 
  insert into tb_servico values(tp_servico('Certid�o de 2� via de Registro de Im�veis',16.24,'Diversos - Atos Comuns e Isolados')); 
  insert into tb_servico values(tp_servico('Certid�o de 2� via de Registro de Im�veis com �nus',32.46,'Diversos - Atos Comuns e Isolados')); 
  insert into tb_servico values(tp_servico('Arquivamento de documentos',8.11,'Diversos - Atos Comuns e Isolados')); 
  
-- inserir descontos que poder�o ser dados a certos servicos ofertados pelo cart�rio dependendo do usu�rio se ele for de baixa renda

  insert into tb_desconto values(tp_desconto('10% de desconto',10)); 
  insert into tb_desconto values(tp_desconto('20% de desconto',20)); 
  insert into tb_desconto values(tp_desconto('30% de desconto',30)); 
  insert into tb_desconto values(tp_desconto('40% de desconto',40)); 
  insert into tb_desconto values(tp_desconto('50% de desconto',50)); 
  insert into tb_desconto values(tp_desconto('60% de desconto',60)); 
  insert into tb_desconto values(tp_desconto('70% de desconto',70)); 
  insert into tb_desconto values(tp_desconto('80% de desconto',80)); 
  insert into tb_desconto values(tp_desconto('90% de desconto',90)); 
  insert into tb_desconto values(tp_desconto('100% de desconto',100)); 
  
  
-- inserir OS LIVROS ONDE SER�O REGISTRADOS OS REGISTROS DE ARQUIVAMENTO PARA OS SERVI�OS QUE DEPENDEM DE ARQUIVAMENTO DE DOCUEMENTOS

  insert into tb_livro values(tp_livro('Livro de arquivamento de firma 01'));
  insert into tb_livro values(tp_livro('Livro de arquivamento de firma 02'));
  insert into tb_livro values(tp_livro('Livro de arquivamento de firma 03'));
  insert into tb_livro values(tp_livro('Livro de arquivamento de documentos 01'));
  insert into tb_livro values(tp_livro('Livro de arquivamento de documentos 02'));
  insert into tb_livro values(tp_livro('Livro de arquivamento de documentos 03'));
  insert into tb_livro values(tp_livro('Livro de arquivamento de registro de protesto 01'));
  insert into tb_livro values(tp_livro('Livro de arquivamento de registro de protesto 02'));
  insert into tb_livro values(tp_livro('Livro de arquivamento de registro de protesto 03'));
  
  

  commit;
-- inserir atendimentos realizados no cartorio.
  
    --Funcionarios com o cargo de atendentes aptos a atenderem os clientes que chegam no cart�rio    
    --Rita 85481536447 Atendente 
    --Francisca 08185128731 Atendente 
    
    --inserir atendimentos a clientes pessoa fisica
    
    insert into tb_atendimento values(tp_atendimento('01210449390','85481536447',to_timestamp('01022015 11:00:00','DDMMYYYY HH24:MI:SS')));--cliente pf '01210449390','WILTON'    
    insert into tb_atendimento values(tp_atendimento('53125548632','08185128731',to_timestamp('01022015 12:30:00','DDMMYYYY HH24:MI:SS')));--cliente pf '53125548632'VERONICA'
    
    insert into tb_atendimento values(tp_atendimento('36245802997','85481536447',to_timestamp('02032015 13:00:00','DDMMYYYY HH24:MI:SS')));--cliente pf '36245802997'CAROLINA'
    insert into tb_atendimento values(tp_atendimento('93097207511','08185128731',to_timestamp('02032015 14:30:00','DDMMYYYY HH24:MI:SS')));--cliente pf '93097207511'MARIANA'  
    
    insert into tb_atendimento values(tp_atendimento('51492421448','85481536447',to_timestamp('25042015 15:00:00','DDMMYYYY HH24:MI:SS')));--cliente pf '51492421448'VALERIA'
    insert into tb_atendimento values(tp_atendimento('12084546923','08185128731',to_timestamp('25042015 16:30:00','DDMMYYYY HH24:MI:SS')));--cliente pf '12084546923''JO�O'
          
    insert into tb_atendimento values(tp_atendimento('88571144303','85481536447',to_timestamp('26052015 17:00:00','DDMMYYYY HH24:MI:SS')));--cliente pf '88571144303''CESAR'
    insert into tb_atendimento values(tp_atendimento('10172073057','08185128731',to_timestamp('26052015 07:30:00','DDMMYYYY HH24:MI:SS')));--cliente pf '10172073057'TARSILA'
    
    insert into tb_atendimento values(tp_atendimento('57566231243','85481536447',to_timestamp('05062015 08:00:00','DDMMYYYY HH24:MI:SS')));--cliente pf '57566231243'MARILIA'
    insert into tb_atendimento values(tp_atendimento('56844627238','08185128731',to_timestamp('07062015 09:30:00','DDMMYYYY HH24:MI:SS')));--cliente pf '56844627238'JANAINA'
    
    insert into tb_atendimento values(tp_atendimento('84561662197','85481536447',to_timestamp('27072015 10:00:00','DDMMYYYY HH24:MI:SS')));--cliente pf '84561662197''FLAVIO'
    insert into tb_atendimento values(tp_atendimento('51492421448','85481536447',to_timestamp('27072015 11:00:00','DDMMYYYY HH24:MI:SS')));--cliente pf '51492421448'VALERIA'
    
    insert into tb_atendimento values(tp_atendimento('01210449390','85481536447',to_timestamp('17082015 12:30:00','DDMMYYYY HH24:MI:SS')));--cliente pf '01210449390','WILTON'
    insert into tb_atendimento values(tp_atendimento('53125548632','08185128731',to_timestamp('17082015 13:30:00','DDMMYYYY HH24:MI:SS')));--cliente pf '53125548632'VERONICA'          
    
    insert into tb_atendimento values(tp_atendimento('36245802997','85481536447',to_timestamp('14092015 14:30:00','DDMMYYYY HH24:MI:SS')));--cliente pf '36245802997'CAROLINA'
    insert into tb_atendimento values(tp_atendimento('93097207511','08185128731',to_timestamp('14092015 15:30:00','DDMMYYYY HH24:MI:SS')));--cliente pf '93097207511'MARIANA'  
    
    insert into tb_atendimento values(tp_atendimento('88571144303','85481536447',to_timestamp('28102015 16:00:00','DDMMYYYY HH24:MI:SS')));--cliente pf '88571144303''CESAR'
    insert into tb_atendimento values(tp_atendimento('12084546923','08185128731',to_timestamp('28102015 17:30:00','DDMMYYYY HH24:MI:SS')));--cliente pf '12084546923''JO�O'
    
    insert into tb_atendimento values(tp_atendimento('10172073057','08185128731',to_timestamp('29112015 07:30:00','DDMMYYYY HH24:MI:SS')));--cliente pf '10172073057'TARSILA'        
    insert into tb_atendimento values(tp_atendimento('84561662197','85481536447',to_timestamp('30112015 08:30:00','DDMMYYYY HH24:MI:SS')));--cliente pf '84561662197''FLAVIO'
    
    insert into tb_atendimento values(tp_atendimento('57566231243','85481536447',to_timestamp('26122015 09:10:00','DDMMYYYY HH24:MI:SS')));--cliente pf '57566231243'MARILIA'
    insert into tb_atendimento values(tp_atendimento('56844627238','08185128731',to_timestamp('23122015 10:10:00','DDMMYYYY HH24:MI:SS')));--cliente pf '56844627238'JANAINA'
    
    --inserir atendimentos a clientes pessoa juridica
    insert into tb_atendimento values(tp_atendimento('55776472000122','85481536447',to_timestamp('01122014 11:32:00','DDMMYYYY HH24:MI:SS')));--cliente pj '55776472000122','Diamantes Lingerie Variedades Ltda','VERONICA'
    insert into tb_atendimento values(tp_atendimento('81813655000180','08185128731',to_timestamp('01122014 13:33:00','DDMMYYYY HH24:MI:SS')));--cliente pj '81813655000180','Griffes Modas Ltda','TARSILA'
    insert into tb_atendimento values(tp_atendimento('96427338000101','85481536447',to_timestamp('02012015 14:01:00','DDMMYYYY HH24:MI:SS')));--cliente pj  '96427338000101','Auto Pe�as Moura Ltda','LEANDRO'
    insert into tb_atendimento values(tp_atendimento('54552735000157','08185128731',to_timestamp('02012015 15:31:00','DDMMYYYY HH24:MI:SS')));--cliente pj '54552735000157','RM Sistemas Ltda','BRIGIDA'
    insert into tb_atendimento values(tp_atendimento('71854793000154','85481536447',to_timestamp('03022015 16:32:00','DDMMYYYY HH24:MI:SS')));--cliente pj '71854793000154','Comer Bem Ltda','LUCAS'
    insert into tb_atendimento values(tp_atendimento('70228623000100','08185128731',to_timestamp('03022015 17:31:00','DDMMYYYY HH24:MI:SS')));--cliente pj '70228623000100','Armarinho do Zeca Ltda', 'Jose Carlos'
    insert into tb_atendimento values(tp_atendimento('81326646000165','85481536447',to_timestamp('04032015 18:01:00','DDMMYYYY HH24:MI:SS')));--cliente pj '81326646000165','Ivan Varieades Ltda','IVAN GOMES'
    insert into tb_atendimento values(tp_atendimento('58112903000144','08185128731',to_timestamp('04032015 07:35:00','DDMMYYYY HH24:MI:SS')));--cliente pj '58112903000144','Construtrotora Franquel Ltda','RAQUEL'
    insert into tb_atendimento values(tp_atendimento('79562568000156','85481536447',to_timestamp('05042015 08:03:00','DDMMYYYY HH24:MI:SS')));--cliente pj '79562568000156','Globo Papelaria Modas Ltda','FATIMA'    
    insert into tb_atendimento values(tp_atendimento('55776472000122','85481536447',to_timestamp('05042015 09:32:00','DDMMYYYY HH24:MI:SS')));--cliente pj '55776472000122','Diamantes Lingerie Variedades Ltda','VERONICA'
    insert into tb_atendimento values(tp_atendimento('81813655000180','08185128731',to_timestamp('06052015 10:31:00','DDMMYYYY HH24:MI:SS')));--cliente pj '81813655000180','Griffes Modas Ltda','TARSILA'
    insert into tb_atendimento values(tp_atendimento('96427338000101','85481536447',to_timestamp('06052015 11:01:00','DDMMYYYY HH24:MI:SS')));--cliente pj  '96427338000101','Auto Pe�as Moura Ltda','LEANDRO'
    insert into tb_atendimento values(tp_atendimento('54552735000157','08185128731',to_timestamp('07062015 12:30:00','DDMMYYYY HH24:MI:SS')));--cliente pj '54552735000157','RM Sistemas Ltda','BRIGIDA'
    insert into tb_atendimento values(tp_atendimento('71854793000154','85481536447',to_timestamp('07062015 13:32:00','DDMMYYYY HH24:MI:SS')));--cliente pj '71854793000154','Comer Bem Ltda','LUCAS'
    insert into tb_atendimento values(tp_atendimento('70228623000100','08185128731',to_timestamp('08072015 14:31:00','DDMMYYYY HH24:MI:SS')));--cliente pj '70228623000100','Armarinho do Zeca Ltda', 'Jose Carlos'
    insert into tb_atendimento values(tp_atendimento('81326646000165','85481536447',to_timestamp('08072015 15:01:00','DDMMYYYY HH24:MI:SS')));--cliente pj '81326646000165','Ivan Varieades Ltda','IVAN GOMES'
    insert into tb_atendimento values(tp_atendimento('58112903000144','08185128731',to_timestamp('09082015 16:31:00','DDMMYYYY HH24:MI:SS')));--cliente pj '58112903000144','Construtrotora Franquel Ltda','RAQUEL'
    insert into tb_atendimento values(tp_atendimento('79562568000156','85481536447',to_timestamp('09082015 17:30:00','DDMMYYYY HH24:MI:SS')));--cliente pj '79562568000156','Globo Papelaria Modas Ltda','FATIMA'  
    
    --inserindo usando o novo contrutor padrao do objeto tp_atendimento --cliente pj '79562568000156','Globo Papelaria Modas Ltda','FATIMA'    
    insert into tb_atendimento values(tp_atendimento(seq_atendimento.nextval,SYSTIMESTAMP, 0.0,
    (select ref(fa) from tb_funcionario fa where fa.ref_pessoafisica.cpf='85481536447'),
    (select ref(ca) from tb_cliente ca where treat(deref(ca.ref_cliente) as tp_juridica).cnpj='79562568000156')));    
    
    
  

              
    --vai dar erro nos quatro inserts abaixo pois Juliano n�o possui o cargo de atendente no cart�rio.
    --insert into tb_atendimento values(tp_atendimento('56844627238','79945193937'));--cliente pf '56844627238'JANAINA'
    --insert into tb_atendimento values(tp_atendimento('79562568000156','79945193937'));--cliente pj '79562568000156','Globo Papelaria Modas Ltda','FATIMA'  
    --insert into tb_atendimento values(tp_atendimento('84561662197','79945193937',to_date('','DDMMYYYY')));--cliente pf '84561662197''FLAVIO'
    --insert into tb_atendimento values(tp_atendimento('58112903000144','79945193937',to_date('','DDMMYYYY')));--cliente pj '58112903000144','Construtrotora Franquel Ltda','RAQUEL'            
    --insert into tb_atendimento values(tp_atendimento(seq_atendimento.nextval,sysdate, 0.0, (select ref(fa) from tb_funcionario fa where fa.ref_pessoafisica.cpf='79945193937'),(select ref(ca) from tb_cliente ca where treat(deref(ca.ref_cliente) as tp_juridica).cnpj='58112903000144')));--cliente pj '58112903000144','Construtrotora Franquel Ltda','RAQUEL'
  
    commit;
   
 
  Set serveroutput on;
 
DECLARE        
    PRAGMA AUTONOMOUS_TRANSACTION;
    
    --PEGA TODOS OS ATENDIMENTOS REALIZADOS
    CURSOR C_ATENDIMENTO IS SELECT AR.COD AS CODATENDIMENTO, AR.DATAATENDIMENTO AS DATAATENDIMENTO, AR.VALORTOTAL AS VALORTOTAL,
                                    AR.REF_ATENDENTE.MATRICULA AS MATRICULAATENDENTE, AR.REF_CLIENTE.COD AS CODCLIENTE,
                                    AR.REF_ATENDENTE.REF_PESSOAFISICA.NOME AS NOMEFUNCIONARIO,
                                    AR.REF_CLIENTE.REF_CLIENTE.NOME AS NOMECLIENTE,
                                    AR.REF_CLIENTE.eBaixaRenda() as CLIENTEBAIXARENDA
                                    FROM TB_ATENDIMENTO AR
                                    ORDER BY AR.DATAATENDIMENTO ASC;
    
    V_REG_ATENDIMENTO C_ATENDIMENTO%ROWTYPE;
    
    CPFFUNCIONARIORESPONSAVEL varchar2(11);
    CLIENTEBAIXARENDA VARCHAR2(250);   
    DESCDESCONTO VARCHAR(250);    
        
    DT_HORA_SERVPREST TIMESTAMP;    
    codServicoAtendidoCorrente number;
 
    
    DESCSERVICO VARCHAR2(950);
    TIPOSERVICODESC VARCHAR2(250);
    refservico ref tp_servico;    
    reflivro ref tp_livro;    
    refservicoDoAtendimento ref tp_servicodoatendimento;
    
    objServicoAtendido tp_servicodoatendimento;
    
    objregistro tp_registro;
    livro_var tp_livro;    
    servico_var tp_servico;
    resp_var tp_funcionario;
    desconto_var tp_desconto;
    
  BEGIN
  
   OPEN C_ATENDIMENTO;
   
     LOOP 
      FETCH C_ATENDIMENTO INTO V_REG_ATENDIMENTO;
      EXIT WHEN C_ATENDIMENTO%NOTFOUND;
      
          DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------------------------');
          DBMS_OUTPUT.PUT('C�digo do Atendimento: '||TO_CHAR(V_REG_ATENDIMENTO.CODATENDIMENTO));
          DBMS_OUTPUT.PUT_LINE(' Data do atendimento: '||TO_CHAR(V_REG_ATENDIMENTO.DATAATENDIMENTO,'DDMMYYYY'));         
          DBMS_OUTPUT.PUT_LINE('Matricula do Atendente: '||TO_CHAR(V_REG_ATENDIMENTO.MATRICULAATENDENTE)||'  Funcion�rio: '||V_REG_ATENDIMENTO.NOMEFUNCIONARIO);
          DBMS_OUTPUT.PUT_LINE('C�digo do Cliente: '||TO_CHAR(V_REG_ATENDIMENTO.CODCLIENTE)||'  Cliente: '||V_REG_ATENDIMENTO.NOMECLIENTE||' ( '||V_REG_ATENDIMENTO.CLIENTEBAIXARENDA||')');
          DBMS_OUTPUT.PUT_LINE('');
          
            
    
                --PARA CADA ATENDIMENTO CADASTRADO FAZER OUTRO LOOP DE 1 ATE 4 QUE IR� CADASTRAR QUATRO SERVICOS DO ATENDIMENTO  
                FOR CONT IN 1..4 LOOP
                                        
                   --SELECIONANDO QUATROS SERVI�OS DISTINTOS OFERECIDOS PELO CARTORIO
                   IF(CONT=1)THEN
                      --1� UM SERVI�O NORMAL, CONT=1 
                      SELECT SA.REF_TIPOSERVICO.DESCRICAO, SA.DESCRICAO, ref(sa) 
                      INTO TIPOSERVICODESC, DESCSERVICO, refservico
                      FROM TB_SERVICO SA WHERE SA.DESCRICAO LIKE '%Escritura, incluindo o 1� Traslado acima de 1.156,11%';
                   ELSIF(CONT=2)THEN
                      -- 2� UM SERVI�O PARA SER REGISTRADO EM ARQUIVO,  CONT=2
                      SELECT SA.REF_TIPOSERVICO.DESCRICAO, SA.DESCRICAO, ref(sa) INTO TIPOSERVICODESC, DESCSERVICO, refservico 
                      FROM TB_SERVICO SA WHERE SA.DESCRICAO LIKE '%Arquivamento do registro do protesto%';
                   ELSIF(CONT=3)THEN
                      -- 3� UM SERVI�O PARA SER DE DESCONTO CASO O CLIENTE SEJA BAIXA RENDA CONT=3
                      SELECT SA.REF_TIPOSERVICO.DESCRICAO, SA.DESCRICAO, ref(sa) INTO TIPOSERVICODESC, DESCSERVICO, refservico 
                      FROM TB_SERVICO SA WHERE SA.DESCRICAO LIKE '%Reconhecimento de Firma (por assinatura)%';
                   ELSIF(CONT=4)THEN
                      -- 4� UM SERVI�O QUE N�O TENHA CUSTOS NO CART�RIO SERVI�O QUE SEJA DE GRA�A DO CART�RIO CONT=4           
                      SELECT SA.REF_TIPOSERVICO.DESCRICAO, SA.DESCRICAO, ref(sa) INTO TIPOSERVICODESC, DESCSERVICO, refservico 
                      FROM TB_SERVICO SA WHERE SA.DESCRICAO  LIKE '%Registros e Contratos (SFH  FGTS)%';
                   END IF;
                   
                                                 
                   --FAZER PEGAR O funcionario responsavel pelo servico 
                   --DE ACORDO COM o tipo do SERVICO pego anteriormente
                   IF(TIPOSERVICODESC='Oficiais do Registro Civil')THEN
                   -- 79945193937  JULIANO AUXILIAR DE CARTORIO
                     SELECT FR.REF_PESSOAFISICA.CPF INTO CPFFUNCIONARIORESPONSAVEL FROM TB_FUNCIONARIO FR WHERE FR.REF_PESSOAFISICA.CPF='79945193937';
                   ELSIF(TIPOSERVICODESC='Oficiais de Protesto de T�tulos')THEN 
                   -- ESCREVENTE 71698661533 OLAVO
                     SELECT FR.REF_PESSOAFISICA.CPF INTO CPFFUNCIONARIORESPONSAVEL FROM TB_FUNCIONARIO FR WHERE FR.REF_PESSOAFISICA.CPF='71698661533';
                   ELSIF(TIPOSERVICODESC='Oficiais do Registro de T�tulos e Documentos  Pessoas Jur�dicas')THEN
                   -- 18267230807 - JONATAS ESCREVENTE, 
                     SELECT FR.REF_PESSOAFISICA.CPF INTO CPFFUNCIONARIORESPONSAVEL FROM TB_FUNCIONARIO FR WHERE FR.REF_PESSOAFISICA.CPF='18267230807';
                   ELSIF(TIPOSERVICODESC='Oficiais de Registro de Im�veis')THEN
                   -- 52454366550 - LIVIA ESCREVENTE
                     SELECT FR.REF_PESSOAFISICA.CPF INTO CPFFUNCIONARIORESPONSAVEL FROM TB_FUNCIONARIO FR WHERE FR.REF_PESSOAFISICA.CPF='52454366550';
                   ELSIF(TIPOSERVICODESC='Tabeli�es de Notas')THEN
                   -- 45355537340 FELIPE TABELIAO
                     SELECT FR.REF_PESSOAFISICA.CPF INTO CPFFUNCIONARIORESPONSAVEL FROM TB_FUNCIONARIO FR WHERE FR.REF_PESSOAFISICA.CPF='45355537340';
                   ELSIF(TIPOSERVICODESC='Diversos - Atos Comuns e Isolados')THEN
                   -- 67034615624 HENZO AUXILIAR DE CARTORIO
                     SELECT FR.REF_PESSOAFISICA.CPF INTO CPFFUNCIONARIORESPONSAVEL FROM TB_FUNCIONARIO FR WHERE FR.REF_PESSOAFISICA.CPF='67034615624';
                   END IF;
                                                                                           
                   
                                    
                 
                      
                      SELECT to_timestamp(TO_CHAR((V_REG_ATENDIMENTO.DATAATENDIMENTO+NUMTODSINTERVAL(CONT, 'MINUTE')),'DDMMYYYY HH24:MI:SS'),'DDMMYYYY HH24:MI:SS') 
                      INTO DT_HORA_SERVPREST FROM DUAL;
                                          
                  
                   
                                     
                 --VERIFICAR SE CLIENTE � BAIXA RENDA: SE FOR ELE TERA UM DESCONTO DE 20,30,40 OU 50%
                 IF(V_REG_ATENDIMENTO.CLIENTEBAIXARENDA='� cliente de baixa renda.')THEN                     
                      SELECT DS.descricao INTO DESCDESCONTO FROM TB_DESCONTO DS WHERE DS.VALOR=to_number(to_char((CONT*10))); 
                          objServicoAtendido := new tp_servicodoatendimento(V_REG_ATENDIMENTO.CODATENDIMENTO, DESCSERVICO, CPFFUNCIONARIORESPONSAVEL,'Cliente baixa renda. Desconto',CONT,DESCDESCONTO,DT_HORA_SERVPREST);
                        insert into TB_servicodoatendimento values(objServicoAtendido);                                               
                      commit;
                 ELSE                      
                       objServicoAtendido := new tp_servicodoatendimento(V_REG_ATENDIMENTO.CODATENDIMENTO,DESCSERVICO,CPFFUNCIONARIORESPONSAVEL,NULL,CONT,NULL,DT_HORA_SERVPREST);
                       insert into TB_servicodoatendimento values(objServicoAtendido);                         
                      commit;
                 END IF;
                 
                 
                 UTL_REF.SELECT_OBJECT(objServicoAtendido.ref_servico, servico_var);
                 UTL_REF.SELECT_OBJECT(objServicoAtendido.ref_responsavel, resp_var);
                 
                 
                 
                 DBMS_OUTPUT.PUT('    Item: '||to_char(cont)||' ');   
                 DBMS_OUTPUT.PUT_LINE('    Servico: '|| servico_var.descricao||' ');
                 DBMS_OUTPUT.PUT_LINE('    Funcion�rio respons�vel item: '|| resp_var.getInfoResumida()||' ');                 
                 DBMS_OUTPUT.PUT('    Valor Unit�rio: R$ '|| servico_var.valor||' ');
                 DBMS_OUTPUT.PUT_LINE(' Qtd: '|| objServicoAtendido.quantidade||' ');
                 
                 IF(objServicoAtendido.ref_desconto is not null)then                 
                   UTL_REF.SELECT_OBJECT(objServicoAtendido.ref_desconto, desconto_var);
                   DBMS_OUTPUT.PUT_LINE('    Desconto: '|| desconto_var.descricao||' ');
                 end if;
                 
                 DBMS_OUTPUT.PUT_LINE('    Total do item: R$ '|| objServicoAtendido.valorServicoRealizado||' ');
                 
                 IF(objServicoAtendido.observacao is not NULL)THEN
                    DBMS_OUTPUT.PUT_LINE('    Obs: '|| objServicoAtendido.observacao||' ');
                 END IF;
                 DBMS_OUTPUT.PUT_LINE(' **************************************************************');
                
                 
                 
                 --tem que dar um update no valorTotalDoServico do atendimento;         
                 UPDATE TB_ATENDIMENTO AR SET AR.VALORTOTAL=AR.getValorTotalAtendimento() WHERE AR.COD=V_REG_ATENDIMENTO.CODATENDIMENTO;
                 commit;
                                                                 
                
                --verificar se o servico do atendimento possui arquivamento se possuir;
         --INSERIR REGISTRO NO LIVRO DE ACORDO COM O SERVICO PRESTADO;         
           IF(DESCSERVICO='Arquivamento de firma ou sinal')THEN
                 if(cont<=3)then--POIS S� CONT�M TRES LIVROS DE ARQUIVAMENTO DE FIRMA
                    SELECT REF(LR) INTO REFLIVRO FROM TB_LIVRO LR where 
                    lr.descricao LIKE '%Livro de arquivamento de firma 0'||to_char(cont)||'%'; 
                 else
                    SELECT REF(LR) INTO REFLIVRO FROM TB_LIVRO LR where 
                    lr.descricao like '%Livro de arquivamento de firma 0'||to_char(cont-1)||'%'; 
                 end if;                  
                                  
                  select ref(sa) into refservicoDoAtendimento from tb_servicodoatendimento sa
                  where sa.coditem=objServicoAtendido.codItem;
                 
                objregistro := new tp_registro(SEQ_REGISTRO.NEXTVAL,1,refLivro,refservicoDoAtendimento);
                insert into TB_REGISTRO values(objregistro);                 
                UTL_REF.SELECT_OBJECT(objregistro.ref_livro, livro_var);                 
                DBMS_OUTPUT.PUT_LINE('    ******Item registrado no arquivo do cart�rio com os seguinte c�digo:');
                DBMS_OUTPUT.PUT_LINE('    N� do registro: '||to_char(objregistro.numregistro)||
                ' folha: '||to_char(objregistro.folha)||' livro: '||livro_var.descricao||'.');
                
                 commit;             
           ElSIF(DESCSERVICO='Arquivamento de documentos')THEN
                if(cont<=3)then--POIS S� CONT�M TRES LIVROS DE ARQUIVAMENTO DE DOCUMENTOS
                    SELECT REF(LR) INTO REFLIVRO FROM TB_LIVRO LR where 
                    lr.descricao LIKE '%Livro de arquivamento de documentos 0'||to_char(cont)||'%'; 
                 else
                    SELECT REF(LR) INTO REFLIVRO FROM TB_LIVRO LR where 
                    lr.descricao like '%Livro de arquivamento de documentos 0'||to_char(cont-1)||'%'; 
                 end if;                  
                 
                  
                  select ref(sa) into refservicoDoAtendimento from tb_servicodoatendimento sa
                  where sa.coditem=objServicoAtendido.codItem;      
                  
                  
                 
                objregistro := new tp_registro(SEQ_REGISTRO.NEXTVAL,1,refLivro,refservicoDoAtendimento);
                insert into TB_REGISTRO values(objregistro);                 
                UTL_REF.SELECT_OBJECT(objregistro.ref_livro, livro_var);                 
                DBMS_OUTPUT.PUT_LINE('    ******Item registrado no arquivo do cart�rio com os seguinte c�digo:');
                DBMS_OUTPUT.PUT_LINE('    N� do registro: '||to_char(objregistro.numregistro)||
                ' folha: '||to_char(objregistro.folha)||' livro: '||livro_var.descricao||'.');
                
                commit;
                
           ELSIF(DESCSERVICO='Arquivamento do registro do protesto')THEN
                 if(cont<=3)then--POIS SO CONTEM TRES LIVROS DE ARQUIVAMENTO DE REGISTRO DE PROTESTO
                    SELECT REF(LR) INTO REFLIVRO FROM TB_LIVRO LR where 
                    lr.descricao LIKE '%Livro de arquivamento de registro de protesto 0'||to_char(cont)||'%'; 
                 else
                    SELECT REF(LR) INTO REFLIVRO FROM TB_LIVRO LR where 
                    lr.descricao like '%Livro de arquivamento de registro de protesto 0'||to_char(cont-1)||'%'; 
                 end if;            
                                
                                
                  
                  select ref(sa) into refservicoDoAtendimento from tb_servicodoatendimento sa
                  where sa.coditem=objServicoAtendido.coditem;
                                                                                                                                                                                                                                        
                objregistro := new tp_registro(SEQ_REGISTRO.NEXTVAL,1,refLivro,refservicoDoAtendimento);
                insert into TB_REGISTRO values(objregistro);                 
                UTL_REF.SELECT_OBJECT(objregistro.ref_livro, livro_var);                 
                DBMS_OUTPUT.PUT('    **** ');
                DBMS_OUTPUT.PUT(' Item registrado no arquivo do cart�rio com o ');
                DBMS_OUTPUT.PUT('n� do registro: '||to_char(objregistro.numregistro)||
                ' na folha: '||to_char(objregistro.folha)||' do '||livro_var.descricao||'.');
                DBMS_OUTPUT.PUT_LINE(' **** ');
                
                 commit;
           END IF;
                
                
                   
               
                              
                END LOOP;       
                
                select ar.valortotal into V_REG_ATENDIMENTO.VALORTOTAL from tb_atendimento ar where ar.cod=V_REG_ATENDIMENTO.CODATENDIMENTO;
                DBMS_OUTPUT.PUT_LINE(' ============================================================= Valor total do atendimento: R$ '                
                ||TO_CHAR(V_REG_ATENDIMENTO.VALORTOTAL));
                DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------------------------------------------');
                DBMS_OUTPUT.PUT_LINE('');
    
          END LOOP;
 
      
      CLOSE C_ATENDIMENTO;
      

   
  END;
  
    
  
  
commit;

