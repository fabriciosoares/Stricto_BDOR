-------- Principais consultas e relatórios do sistema de cartório ----------------------------------------------------


--- RETORNA OS FUNCIONARIOS EM SEUS SETORES RECENTES e sua jornada de trabalho


--retornar todo o historica por onde o funcionario trabalhou no cartorio informando o setor a data de entra e sua jornada de trabalho





--a)

SELECT TO_CHAR(TG.PERIODO,'MMYYYY') AS PERIODO, SUM(TG.VALOR) AS TOTAL_GRATIFICACOES_PAGAS FROM TB_FUNCIONARIO F, TABLE(F.GRATIFICACOES) TG
WHERE
TO_CHAR(TG.PERIODO,'MMYYYY')='052015'
GROUP BY TO_CHAR(TG.PERIODO,'MMYYYY')
ORDER BY PERIODO DESC;

--b)

select f.getInfo(), F.getCargo() as cargo from tb_funcionario f
where f.status='A' 
order by f.ref_cargo.descricao;


--c) Listar historico de setores onde o funcionario trabalhou no cartorio

SELECT 
 F.GETiNFORESUMIDA() AS FUNCIONÁRIO, H.REF_SETOR.DESCRICAO AS SETOR, TO_CHAR(H.DATAENTRADA,'DDMMYYYY HH:MI:SS') AS ENTRADA   
FROM TB_FUNCIONARIO F, TB_HISTORICO_SETOR_FUNCIONARIO H
WHERE H.REF_FUNCIONARIO.MATRICULA=F.MATRICULA and f.matricula=183
ORDER BY  H.DATAENTRADA DESC;
--GROUP BY F.GETiNFORESUMIDA()


SELECT 
 F.GETiNFORESUMIDA() AS FUNCIONÁRIO, H.REF_SETOR.DESCRICAO AS SETOR, TO_CHAR(H.DATAENTRADA,'DDMMYYYY HH:MI:SS') AS ENTRADA  --, MAX(TO_CHAR(H.DATAENTRADA,'DDMMYYYY HH24:MI:SS'))
FROM TB_FUNCIONARIO F, TB_HISTORICO_SETOR_FUNCIONARIO H
WHERE H.REF_FUNCIONARIO.MATRICULA=F.MATRICULA AND
H.DATAENTRADA=(SELECT MAX(H2.DATAENTRADA) FROM TB_HISTORICO_SETOR_FUNCIONARIO H2 WHERE H2.REF_FUNCIONARIO.MATRICULA=F.MATRICULA)
GROUP BY (F.GETiNFORESUMIDA(), H.REF_SETOR.DESCRICAO, H.DATAENTRADA)
ORDER BY  H.DATAENTRADA DESC;


--d) Listar clientes pessoa fisica

select ce.getInfo() as ClientePessoaFísica from tb_cliente ce 
where (DEREF(Ce.REF_CLIENTE)IS OF(ONLY TP_FISICA));

--e)

select to_char(ta.dataatendimento,'YYYY') AS ANO, sum(ta.getValorTotalAtendimento()) as faturamento_pessoafisica from tb_atendimento ta 
where (DEREF(TA.REF_CLIENTE.REF_CLIENTE)IS OF(ONLY TP_FISICA))
GROUP BY (to_char(ta.dataatendimento,'YYYY')) ;

--f)

select  cj.ref_cliente.getInfo() as ClientesPessoaJurídica from tb_cliente cj
where (DEREF(cj.REF_CLIENTE)IS OF(ONLY TP_JURIDICA));

--g)

select to_char(ta.dataatendimento,'YYYY') AS ANO, sum(ta.getValorTotalAtendimento()) as faturamento_pessoajuridica from tb_atendimento ta 
where (DEREF(TA.REF_CLIENTE.REF_CLIENTE)IS OF(ONLY TP_juridica))
GROUP BY (to_char(ta.dataatendimento,'YYYY')) ;

--h)

select sp.ref_atendimento.getInfo() as atendimento ,sp.getInfo()as serviçoDoAtendimento 
from tb_servicodoatendimento sp 
where sp.ref_atendimento.cod=:codAtendimento;

--i)

select rc.getInfo() as dadosDoregistro, rc.ref_servicodoatendimento.getInfo() as servicosRegistrados from tb_registro rc
where to_char(rc.ref_servicodoatendimento.datahorarealizacao,'DDMMYYYY')=:dataRegistro
order by rc.ref_servicodoatendimento.datahorarealizacao;



--j)

select s.ref_tiposervico.descricao as tipo ,  s.descricao as servico  from tb_servico s
order by s.ref_tiposervico.descricao asc, s.descricao asc;

--quantidade de serviços ofertados agrupados por tipo

select s.ref_tiposervico.descricao as tipo, count(s.ref_tiposervico.cod) as quantidadeServicos from tb_servico s
group by s.ref_tiposervico.descricao;

--l)


select sp.ref_atendimento.getInfo() as atendimento ,sp.getInfo()as serviçoDoAtendimento 
from tb_servicodoatendimento sp 
where sp.ref_responsavel.ref_cargo.descricao='Tabelião' and sp.ref_responsavel.ref_pessoafisica.cpf=:cpfFuncionarioTabeliao
order by sp.datahorarealizacao desc;

--m)

--interessante deletar alguns serviços de atendimento associados a tres tipos diferentes de serviços
-- e que nao estejam associados a registros em arquivo

select  
  sa.ref_servico.ref_tiposervico.descricao as tipoDeServico, 
  count(sa.ref_servico.ref_tiposervico.cod) as quantidade
from tb_servicodoatendimento sa 
group by sa.ref_servico.ref_tiposervico.descricao
having count(sa.ref_servico.ref_tiposervico.cod)>=(

                        select max(tb_a.qtd) as cnt 
                        from 
                         (select   
                          count(sa2.ref_servico.ref_tiposervico.cod) as qtd
                        from tb_servicodoatendimento sa2 
                        group by sa2.ref_servico.ref_tiposervico.descricao) tb_a
);


--n)

select  sum(ta.getValorTotalAtendimento()) as faturamento_obtido from tb_atendimento ta 
where 
 ta.dataatendimento between to_timestamp(:dataInicio,'DDMMYYYY') and to_timestamp(:dataFim,'DDMMYYYY');


--o

select avg(tc.renda) as rendaMediaClientes from tb_cliente tc;

select avg(f.salario) as rendaMediaFuncionarios from tb_funcionario f;

--p

select 

sa.ref_responsavel.ref_pessoafisica.nome as Escrevente,
count(distinct sa.ref_atendimento.ref_cliente.cod) as qtdClientesAtendidos
from tb_servicodoatendimento sa
where 
sa.ref_responsavel.ref_cargo.descricao='Escrevente' and
sa.ref_responsavel.ref_pessoafisica.cpf=:cpfFuncionarioEscrevente
group by sa.ref_responsavel.ref_pessoafisica.nome;


--clientes que não fizeram nenhum atendimento
select tc.cod, tc.ref_cliente.nome from tb_cliente tc 
where 
tc.cod not in (select tb.ref_cliente.cod from tb_atendimento tb);





--q

select to_char(ta.dataatendimento,'MMYYYY') as periodo, sum(ta.getValorTotalAtendimento()) as faturamento from tb_atendimento ta 
where to_char(ta.dataatendimento,'YYYY')=EXTRACT(YEAR FROM sysdate)
group by to_char(ta.dataatendimento,'MMYYYY')
HAVING sum(ta.getValorTotalAtendimento())>=
(
select max(ta.faturamento_mensal) from 
(
select sum(ta.getValorTotalAtendimento()) as faturamento_mensal from tb_atendimento ta 
where to_char(ta.dataatendimento,'YYYY')=EXTRACT(YEAR FROM sysdate)
group by to_char(ta.dataatendimento,'MMYYYY')
) ta
)
order by to_char(ta.dataatendimento,'MMYYYY') desc;

--r---------------------------------------------------------------------------------------------------------------------------

select 
TSA.REF_SERVICO.DESCRICAO as servico, count(tsa.REF_SERVICO.COD) as quantidadeSolicitada
from tb_servicodoatendimento tsa
where 
(DEREF(tsa.ref_atendimento.REF_CLIENTE.REF_CLIENTE)IS OF(ONLY TP_FISICA)) and
TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_FISICA).sexo='F'
group by TSA.REF_SERVICO.DESCRICAO
having count(tsa.REF_SERVICO.COD) >= (select max(tb.quantidade) 
                                      from 
                                                               (
                                                                select TSA.REF_SERVICO.DESCRICAO as servico,count(tsa.REF_SERVICO.COD) as quantidade from tb_servicodoatendimento tsa
                                                                where (DEREF(tsa.ref_atendimento.REF_CLIENTE.REF_CLIENTE)IS OF(ONLY TP_FISICA)) and TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_FISICA).sexo='F'
                                                                group by TSA.REF_SERVICO.DESCRICAO
                                                                ) tb
                                      )
order by  TSA.REF_SERVICO.DESCRICAO;                                     



--s

select ta.ref_atendente.ref_pessoafisica.nome as atendente,
count(ta.cod) qtdAtendimentos 
from tb_atendimento ta
where ta.ref_atendente.ref_cargo.descricao='Atendente' and
to_timestamp(to_char(ta.dataatendimento,'DDMMYYYY'),'DDMMYYYY')=to_timestamp(:dataAtendimento,'DDMMYYYY')
GROUP BY ta.ref_atendente.ref_pessoafisica.nome
HAVING count(ta.cod)>=
                      ( 
                          select max(tb.qtdatendimentos) from 
                          (
                          select ta.ref_atendente.ref_pessoafisica.nome as atendente,
                          count(ta.cod) qtdAtendimentos 
                          from tb_atendimento ta
                          where ta.ref_atendente.ref_cargo.descricao='Atendente' and
                          to_timestamp(to_char(ta.dataatendimento,'DDMMYYYY'),'DDMMYYYY')=to_timestamp(:dataAtendimento,'DDMMYYYY')
                          GROUP BY ta.ref_atendente.ref_pessoafisica.nome
                          ) tb
                      )
order by ta.ref_atendente.ref_pessoafisica.nome desc;


--t

select 
    TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_JURIDICA).razaosocial as empresa,
    TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_JURIDICA).cnpj as cnpj,
    TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_JURIDICA).nome as dono,
    tsa.ref_servico.descricao as servicoSolicitado,
    :dataInicial||' a '||:dataFinal as periodo,
    COUNT(tsa.coditem) as quantidadeSolicitada
from tb_servicodoatendimento tsa
where 
(DEREF(tsa.ref_atendimento.REF_CLIENTE.REF_CLIENTE)IS OF(ONLY TP_JURIDICA)) and
(to_timestamp(to_char(tsa.datahorarealizacao,'DDMMYYYY'),'DDMMYYYY') between
to_timestamp(:dataInicial,'DDMMYYYY') and  to_timestamp(:dataFinal,'DDMMYYYY'))
and tsa.ref_servico.cod=:codigoDoServico
group by 
      TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_JURIDICA).razaosocial,
      TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_JURIDICA).cnpj,
      TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_JURIDICA).nome,
      tsa.ref_servico.descricao,:dataInicial||' a '||:dataFinal  


having COUNT(tsa.coditem)>=
                              (
                              select max(tb.quantidadesolicitada)  from 
                                  (                                          
                                  select 
                                      TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_JURIDICA).razaosocial as empresa,   
                                      COUNT(tsa.coditem) as quantidadeSolicitada
                                  from tb_servicodoatendimento tsa
                                  where 
                                  (DEREF(tsa.ref_atendimento.REF_CLIENTE.REF_CLIENTE)IS OF(ONLY TP_JURIDICA)) and
                                  (to_timestamp(to_char(tsa.datahorarealizacao,'DDMMYYYY'),'DDMMYYYY') between
                                  to_timestamp(:dataInicial,'DDMMYYYY') and  to_timestamp(:dataFinal,'DDMMYYYY'))
                                  and tsa.ref_servico.cod=:codigoDoServico
                                  group by 
                                        TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_JURIDICA).razaosocial
                                  ) tb
                              )
order by TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_JURIDICA).razaosocial desc;      


--u

select  
    :periodoMesAno as periodo,
    COUNT(tsa.coditem) as quantidadeSolicitada,
    tsa.ref_atendimento.ref_cliente.getInfo() as cliente  
from tb_servicodoatendimento tsa
where 
(to_timestamp(to_char(tsa.datahorarealizacao,'MMYYYY'),'MMYYYY')=to_timestamp(:periodoMesAno,'MMYYYY'))

group by 
      tsa.ref_atendimento.ref_cliente.getInfo(),:periodoMesAno      
having COUNT(tsa.coditem)>=
                              (
                              select max(tb.quantidadesolicitada)  from 
                                  (          
                                  select     
                                      tsa.ref_atendimento.ref_cliente.getInfo() as cliente,
                                      :periodoMesAno as periodo,
                                      COUNT(tsa.coditem) as quantidadeSolicitada
                                  from tb_servicodoatendimento tsa
                                  where 
                                  (to_timestamp(to_char(tsa.datahorarealizacao,'MMYYYY'),'MMYYYY')=to_timestamp(:periodoMesAno,'MMYYYY'))
                                  
                                  group by 
                                        tsa.ref_atendimento.ref_cliente.getInfo(),:periodoMesAno  
                                  
                                  ) tb
                              )
order by tsa.ref_atendimento.ref_cliente.getInfo() desc;  





-- V

select f.getInfo() from tb_funcionario f where f.status='A';

--X

select f.getInfo() as Funcionários from tb_funcionario f where f.ref_cargo.cod=&codigoCargo;   
select f.getInfo() as Funcionários  from tb_funcionario f where f.ref_cargo.descricao like '%'||:descricao||'%';
select f.getInfo() as Funcionários from tb_funcionario f where f.ref_cargo.descricao=:descricao;


--Z

select f.getInfo()  as Funcionários from tb_funcionario f 
where to_char(f.dataadmisao,'DDMMYYYY')between  :dataInicio and :dataFim;

--A1

select oc.getInfo()  as Clientes from tb_cliente oc;

--B1

select oc.getInfo()  as ClientesPessoaFísica from tb_cliente oc
where (DEREF(oc.REF_CLIENTE)IS OF(ONLY TP_fisica));

--C1

select oc.getInfo()  as ClientesPessoaJurídica from tb_cliente oc
where (DEREF(oc.REF_CLIENTE)IS OF(ONLY TP_JURIDICA));

--D1

SELECT :periodoDiaMesAno as Periodo , tsa.getInfo() as servicosPrestado from tb_servicodoatendimento tsa
where to_timestamp(to_char(tsa.datahorarealizacao,'DDMMYYYY'),'DDMMYYYY')=to_timestamp(:periodoDiaMesAno,'DDMMYYYY');


--E1

SELECT tsa.ref_servico.cod as CodigoDoServico , tsa.getInfo() as ServicoPrestado from tb_servicodoatendimento tsa
where tsa.ref_servico.cod=:codigoServico
order by tsa.datahorarealizacao desc;


--F1

SELECT  tsa.ref_atendimento.ref_cliente.getInfo() as cliente , tsa.getInfo() as ServicoPrestado from tb_servicodoatendimento tsa
where UPPER(tsa.ref_atendimento.ref_cliente.ref_cliente.nome) like '%'||UPPER(to_char(:nomeCliente))||'%' or
tsa.ref_atendimento.ref_cliente.cod=:codigoCliente
order by tsa.datahorarealizacao desc;

--G1

SELECT 
TSA.GETiNFO() AS SERVICOPRESTADO 
FROM tb_servicodoatendimento TSA
WHERE TSA.REF_RESPONSAVEL.REF_CARGO.DESCRICAO='Escrevente' and
TSA.REF_RESPONSAVEL.ref_pessoafisica.cpf=:cpfEscrevente
order by TSA.datahorarealizacao desc;

--H1

SELECT 
TSA.GETiNFO() AS SERVICOPRESTADO 
FROM tb_servicodoatendimento TSA
WHERE TSA.REF_RESPONSAVEL.REF_CARGO.DESCRICAO='Tabelião' and
TSA.REF_RESPONSAVEL.ref_pessoafisica.cpf=:cpfTabeliao
order by TSA.datahorarealizacao desc;


