-------- Principais consultas e relat�rios do sistema de cart�rio ------------------------------------------------------------------------------

-- 1) �	Listar o somat�rio do valor total de gratifica��es pagas a todos os funcion�rios do cart�rio em determinado m�s X(Ex:05/2015); 

        SELECT TO_CHAR(TG.PERIODO,'MM/YYYY') AS PERIODO, SUM(TG.VALOR) AS TOTAL_GRATIFICACOES_PAGAS FROM TB_FUNCIONARIO F, TABLE(F.GRATIFICACOES) TG
        WHERE
        TO_CHAR(TG.PERIODO,'MM/YYYY')=:periodo --'05/2015'
        GROUP BY TO_CHAR(TG.PERIODO,'MM/YYYY')
        ORDER BY PERIODO DESC;

/
--2)�	Listar todos os funcion�rios ativos do cart�rio, informando um dos telefones, seu sal�rio e ordenado a consulta por tipo de cargo exercido no cart�rio; 

        select f.getInfo(), F.getCargo() as cargo from tb_funcionario f
        where f.status='A' 
        order by f.ref_cargo.descricao;

/
--3)� Listar historico de setores onde o funcionario trabalhou no cartorio

        select 
              hf.ref_funcionario.matricula as matricula, 
              hf.ref_funcionario.ref_pessoafisica.nome as Funcion�rio, 
              to_char(hf.dataentrada,'DD/MM/YYYY HH:MM:SS') as dataEntrada, 
              hf.ref_setor.descricao as setor,
              hf.ref_jornada.descricao AS jornada from tb_historico_setor_funcionario hf
            where 
              hf.ref_funcionario.matricula=&matricula
            order by hf.dataentrada desc;

/        
--4)� Retorna em qual setor determinado funcionario trabalha atualmente e qual a sua jornada de trabalho nesse setor

        select 
          hf.ref_funcionario.matricula as matricula, 
          hf.ref_funcionario.ref_pessoafisica.nome as Funcion�rio, 
          to_char(hf.dataentrada,'DD/MM/YYYY HH:MM:SS') as dataEntrada, 
          hf.ref_setor.descricao as setor,
          hf.ref_jornada.descricao AS jornada from tb_historico_setor_funcionario hf
        where 
          hf.ref_funcionario.matricula=&matricula and
          hf.dataentrada=(select max(hf2.dataentrada) 
                                from tb_historico_setor_funcionario hf2 
                                where hf2.ref_funcionario.matricula=hf.ref_funcionario.matricula); 
/

--5)� Retorna em qual setor todos os funcionarios trabalham atualmente e quais suas respectivas jornadas de trabalho em seus setores
        
        select 
          hf.ref_funcionario.matricula as matricula, 
          hf.ref_funcionario.ref_pessoafisica.nome as Funcion�rio, 
          to_char(hf.dataentrada,'DD/MM/YYYY HH:MM:SS') as dataEntrada, 
          hf.ref_setor.descricao as setor,
          hf.ref_jornada.descricao AS jornada from tb_historico_setor_funcionario hf
        where   
          hf.dataentrada=(select max(hf2.dataentrada) 
                                from tb_historico_setor_funcionario hf2 
                                where hf2.ref_funcionario.matricula=hf.ref_funcionario.matricula);                   
/

--6)�	Listar clientes pessoas f�sicas;

      select ce.getInfo() as ClientePessoaF�sica from tb_cliente ce 
      where (DEREF(Ce.REF_CLIENTE)IS OF(ONLY TP_FISICA));
/
--7)�	Listar o valor total faturado pelo cart�rio no ano com rela��o aos atendimentos a pessoa f�sica;

      select to_char(ta.dataatendimento,'YYYY') AS ANO, sum(ta.getValorTotalAtendimento()) as faturamento_pessoafisica from tb_atendimento ta 
      where (DEREF(TA.REF_CLIENTE.REF_CLIENTE)IS OF(ONLY TP_FISICA)) and to_char(ta.dataatendimento,'YYYY')=:ano --2015
      GROUP BY to_char(ta.dataatendimento,'YYYY');
/
--8)�	Listar clientes pessoas jur�dicas exibindo o nome do respons�vel pela empresa;

      select  cj.ref_cliente.getInfo() as ClientesPessoaJur�dica from tb_cliente cj
      where (DEREF(cj.REF_CLIENTE)IS OF(ONLY TP_JURIDICA));
/
--9)� Listar o valor total faturado pelo cart�rio no ano com rela��o aos atendimentos a pessoa jur�dica;

    select to_char(ta.dataatendimento,'YYYY') AS ANO, sum(ta.getValorTotalAtendimento()) as faturamento_pessoajuridica from tb_atendimento ta 
    where (DEREF(TA.REF_CLIENTE.REF_CLIENTE)IS OF(ONLY TP_juridica)) and to_char(ta.dataatendimento,'YYYY')=:ano --2015
    GROUP BY to_char(ta.dataatendimento,'YYYY');

/
--10)�	Listar todos os servi�os prestados para um determinado atendimento; 

    select sp.ref_atendimento.getInfo() as atendimento ,sp.getInfo()as servi�oDoAtendimento 
    from tb_servicodoatendimento sp 
    where sp.ref_atendimento.cod=:codAtendimento--1;

/
--11)�	Listar todos os servi�os registrados nos livros do cart�rio em uma determinada data
--     (servi�os prestados por funcion�rios nos atendimentos a clientes que envolveram a guarda de documentos no arquivo do cart�rio); 

    select rc.getInfo() as dadosDoregistro, rc.ref_servicodoatendimento.getInfo() as servicosRegistrados from tb_registro rc
    where to_char(rc.ref_servicodoatendimento.datahorarealizacao,'DD/MM/YYYY')=:dataRegistro --DD/MM/YYYY
    order by rc.ref_servicodoatendimento.datahorarealizacao;
    
/
--12)�	Listar todos os servi�os oferecidos pelo cart�rio, agrupados por tipo de servi�o; 

      select s.ref_tiposervico.descricao as tipo ,  s.descricao as servico  from tb_servico s
      order by s.ref_tiposervico.descricao asc, s.descricao asc;

/

--13)�	Listar os servi�os que foram recebidos por certo tabeli�o; 

      select sp.ref_atendimento.getInfo() as atendimento ,sp.getInfo()as servi�oDoAtendimento 
      from tb_servicodoatendimento sp 
      where sp.ref_responsavel.ref_cargo.descricao='Tabeli�o' and sp.ref_responsavel.ref_pessoafisica.cpf=:cpfFuncionarioTabeliao --45355537340 FELIPE
      order by sp.datahorarealizacao desc;

/

--l4)�	Listar o tipo de servi�o mais realizado; 

    
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
    )
    ORDER BY sa.ref_servico.ref_tiposervico.descricao DESC;

/

--15) �	Listar quanto foi faturado pelo cart�rio entre duas datas espec�ficas; 

    select 
    to_timestamp(:dataInicio,'DD/MM/YYYY') as dataInicio, 
    to_timestamp(:dataFim,'DD/MM/YYYY') as dataFim,
    sum(ta.getValorTotalAtendimento()) as faturamento_obtido from tb_atendimento ta     
    where 
     ta.dataatendimento between to_timestamp(:dataInicio,'DD/MM/YYYY') and to_timestamp(:dataFim,'DD/MM/YYYY')
    group by to_timestamp(:dataInicio,'DD/MM/YYYY'), to_timestamp(:dataFim,'DD/MM/YYYY');

/

--16)�	Listar a renda m�dia dos clientes (pessoa f�sica) cadastrados no cart�rio; 

    --renda m�dia clientes pessoa fisica
    select avg(tc.renda) as rendaMediaClientes from tb_cliente tc
    where (DEREF(tc.REF_CLIENTE)IS OF(ONLY TP_FISICA)) and tc.renda is not null;
    
    --renda m�dia funcion�rios
    select avg(f.salario) as rendaMediaFuncionarios from tb_funcionario f;
    
/

--17) �	Listar quantos clientes solicitaram servi�os ao escrevente X; 
    
      select       
         sa.ref_responsavel.ref_pessoafisica.nome as Escrevente,
         count(distinct sa.ref_atendimento.ref_cliente.cod) as qtdClientesAtendidos
      from tb_servicodoatendimento sa
      where 
        sa.ref_responsavel.ref_cargo.descricao='Escrevente' and sa.ref_responsavel.ref_pessoafisica.cpf=:cpfFuncionarioEscrevente --71698661533 Olavo
      group by sa.ref_responsavel.ref_pessoafisica.nome;    
      
/

--18) �	Listar em qual m�s do ano houve maior faturamento no cart�rio; 

      select to_char(ta.dataatendimento,'MM/YYYY') as periodo, sum(ta.getValorTotalAtendimento()) as faturamentoMaior from tb_atendimento ta 
      where to_char(ta.dataatendimento,'YYYY')=EXTRACT(YEAR FROM sysdate)
      group by to_char(ta.dataatendimento,'MM/YYYY')
      HAVING sum(ta.getValorTotalAtendimento())>=
                                                  (
                                                  select max(ta.faturamento_mensal) from 
                                                                                        (select sum(ta.getValorTotalAtendimento()) as faturamento_mensal from tb_atendimento ta 
                                                                                         where to_char(ta.dataatendimento,'YYYY')=EXTRACT(YEAR FROM sysdate)
                                                                                         group by to_char(ta.dataatendimento,'MM/YYYY')
                                                                                         ) ta
                                                  )
      order by to_char(ta.dataatendimento,'MM/YYYY') desc;

/

--19) �	Listar qual o servi�o mais solicitado por mulheres; 

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
                                                    select 
                                                        TSA.REF_SERVICO.DESCRICAO as servico,
                                                        count(tsa.REF_SERVICO.COD) as quantidade 
                                                      from tb_servicodoatendimento tsa
                                                      where (DEREF(tsa.ref_atendimento.REF_CLIENTE.REF_CLIENTE)IS OF(ONLY TP_FISICA))
                                                            and TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_FISICA).sexo='F'
                                                    group by (TSA.REF_SERVICO.DESCRICAO)
                                                    ) tb
                                              )
        order by  TSA.REF_SERVICO.DESCRICAO;   

/

--20) �	Listar qual funcion�rio realizou mais atendimentos na data X; 

        select ta.ref_atendente.ref_pessoafisica.nome as atendente,
        count(ta.cod) qtdAtendimentos 
        from tb_atendimento ta
        where ta.ref_atendente.ref_cargo.descricao='Atendente' and
        to_timestamp(to_char(ta.dataatendimento,'DD/MM/YYYY'),'DD/MM/YYYY')=to_timestamp(:dataAtendimento,'DD/MM/YYYY')
        GROUP BY ta.ref_atendente.ref_pessoafisica.nome
        HAVING count(ta.cod)>=
                              ( 
                                  select max(tb.qtdatendimentos) from 
                                  (
                                  select ta.ref_atendente.ref_pessoafisica.nome as atendente,
                                  count(ta.cod) qtdAtendimentos 
                                  from tb_atendimento ta
                                  where ta.ref_atendente.ref_cargo.descricao='Atendente' and
                                  to_timestamp(to_char(ta.dataatendimento,'DD/MM/YYYY'),'DD/MM/YYYY')=to_timestamp(:dataAtendimento,'DD/MM/YYYY')
                                  GROUP BY (ta.ref_atendente.ref_pessoafisica.nome)
                                  ) tb
                              )
        order by ta.ref_atendente.ref_pessoafisica.nome desc;


/

--21) �	Listar qual cliente (pessoa jur�dica) solicitou mais servi�os Z, entre as datas X e Y; 

/

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
(to_timestamp(to_char(tsa.datahorarealizacao,'DD/MM/YYYY'),'DD/MM/YYYY') between
to_timestamp(:dataInicial,'DD/MM/YYYY') and  to_timestamp(:dataFinal,'DD/MM/YYYY'))
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
                                  (to_timestamp(to_char(tsa.datahorarealizacao,'DD/MM/YYYY'),'DD/MM/YYYY') between
                                  to_timestamp(:dataInicial,'DD/MM/YYYY') and  to_timestamp(:dataFinal,'DD/MM/YYYY'))
                                  and tsa.ref_servico.cod=:codigoDoServico
                                  group by 
                                        TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_JURIDICA).razaosocial
                                  ) tb
                              )
order by TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_JURIDICA).razaosocial desc;      


/

--19) �	Listar qual cliente solicitou mais servi�os no m�s X;

      select  
          :periodoMesAno as periodo,
          COUNT(tsa.coditem) as quantidadeSolicitada,
          tsa.ref_atendimento.ref_cliente.getInfo() as cliente  
      from tb_servicodoatendimento tsa
      where 
      (to_timestamp(to_char(tsa.datahorarealizacao,'MM/YYYY'),'MM/YYYY')=to_timestamp(:periodoMesAno,'MM/YYYY'))
      
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
                                        (to_timestamp(to_char(tsa.datahorarealizacao,'MM/YYYY'),'MM/YYYY')=to_timestamp(:periodoMesAno,'MM/YYYY'))
                                        
                                        group by 
                                              (tsa.ref_atendimento.ref_cliente.getInfo(),:periodoMesAno)                                    
                                        ) tb
                                    )
      order by tsa.ref_atendimento.ref_cliente.getInfo() desc; 


/

--20)�	Emitir relat�rio com os dados cadastrais de todos os funcion�rios ativos do cart�rio;

        select f.getInfo() from tb_funcionario f where f.status='A';

/

--21) �	Emitir relat�rio com os dados cadastrais de todos os funcion�rios que exercem determinado cargo X no cart�rio;
    
    --Exemplo1
    select f.getInfo() as Funcion�rios from tb_funcionario f where f.ref_cargo.cod=&codigoCargo;   
    --Exemplo2
    select f.getInfo() as Funcion�rios  from tb_funcionario f where f.ref_cargo.descricao like '%'||:descricao||'%';
    --Exemplo3
    select f.getInfo() as Funcion�rios from tb_funcionario f where f.ref_cargo.descricao=:descricao;
    
/
--22) �	Emitir relat�rio com os dados cadastrais dos funcion�rios do cart�rio por per�odo de contrata��o;

    --Filtra os funcionario por periodo de admiss�o por periodoInicio dd/mm/yyyy e fim dd/mm/yyyy
    select f.getInfo()  as Funcion�rios from tb_funcionario f 
    where to_char(f.dataadmisao,'DD/MM/YYYY') between  :dataInicio and :dataFim;

/

--23) �	Emitir relat�rio de todos os clientes cadastrados no cart�rio;


       select oc.getInfo()  as Clientes from tb_cliente oc;
    
/

--24) �	Emitir relat�rio de todos os clientes pessoa f�sica cadastrados no cart�rio;  

      select oc.getInfo()  as ClientesPessoaF�sica from tb_cliente oc
      where (DEREF(oc.REF_CLIENTE)IS OF(ONLY TP_fisica));

/

--25) �	Emitir relat�rio de todos os clientes pessoa jur�dica cadastrados no cart�rio;

      select oc.getInfo()  as ClientesPessoaJur�dica from tb_cliente oc
      where (DEREF(oc.REF_CLIENTE)IS OF(ONLY TP_JURIDICA));
      
/

--26) �	Emitir relat�rio de servi�os prestados em determinada data;

      SELECT :periodoDiaMesAno as Periodo , tsa.getInfo() as servicosPrestado from tb_servicodoatendimento tsa
      where to_timestamp(to_char(tsa.datahorarealizacao,'DD/MM/YYYY'),'DD/MM/YYYY')=to_timestamp(:periodoDiaMesAno,'DD/MM/YYYY');

/

--27) �	Emitir relat�rio de servi�os prestados por c�digo de servi�o;

      SELECT tsa.ref_servico.cod as CodigoDoServico , tsa.getInfo() as ServicoPrestado from tb_servicodoatendimento tsa
      where tsa.ref_servico.cod=:codigoServico
      order by tsa.datahorarealizacao desc;

/

--28) �	Emitir relat�rio de servi�os prestados a um dado cliente do cart�rio;


      --BUSCA PELO C�DIGO DO CLIENTE
      SELECT  tsa.ref_atendimento.ref_cliente.getInfo() as cliente , tsa.getInfo() as ServicoPrestado from tb_servicodoatendimento tsa
      where UPPER(tsa.ref_atendimento.ref_cliente.ref_cliente.nome) like '%'||UPPER(to_char(:nomeCliente))||'%' or
      tsa.ref_atendimento.ref_cliente.cod=:codigoCliente
      order by tsa.datahorarealizacao desc;
      
      --BUSCA PELO CPF DO CLIENTE
      SELECT  tsa.ref_atendimento.ref_cliente.getInfo() as cliente , tsa.getInfo() as ServicoPrestado from tb_servicodoatendimento tsa
      where UPPER(tsa.ref_atendimento.ref_cliente.ref_cliente.nome) like '%'||UPPER(to_char(:nomeCliente))||'%' or      
      TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_FISICA).cpf=:cpfCliente      
      order by tsa.datahorarealizacao desc;
      
      --BUSCA PELO CNPJ DO CLIENTE
      
      SELECT  tsa.ref_atendimento.ref_cliente.getInfo() as cliente , tsa.getInfo() as ServicoPrestado from tb_servicodoatendimento tsa
      where UPPER(tsa.ref_atendimento.ref_cliente.ref_cliente.nome) like '%'||UPPER(to_char(:nomeCliente))||'%' or      
      TREAT(DEREF(tsa.ref_atendimento.ref_cliente.ref_cliente) AS TP_JURIDICA).cnpj=:cnpjCliente
      order by tsa.datahorarealizacao desc;

/

--29) �	Emitir relat�rio de servi�os prestados por escrevente;

      SELECT 
      TSA.GETiNFO() AS SERVICOPRESTADO 
      FROM tb_servicodoatendimento TSA
      WHERE TSA.REF_RESPONSAVEL.REF_CARGO.DESCRICAO='Escrevente' and
      TSA.REF_RESPONSAVEL.ref_pessoafisica.cpf=:cpfEscrevente
      order by TSA.datahorarealizacao desc;

/

--30) �	Emitir relat�rio de servi�os prestados por tabeli�o.

      SELECT 
      TSA.GETiNFO() AS SERVICOPRESTADO 
      FROM tb_servicodoatendimento TSA
      WHERE TSA.REF_RESPONSAVEL.REF_CARGO.DESCRICAO='Tabeli�o' and
      TSA.REF_RESPONSAVEL.ref_pessoafisica.cpf=:cpfTabeliao
      order by TSA.datahorarealizacao desc;

/

--31)�	Emitir relat�rio que exiba os tipos de servi�os ofertados pelo cart�rio e a quantidade de servi�os associado a cada tipo de servi�o.

      select s.ref_tiposervico.descricao as tipo, count(s.ref_tiposervico.cod) as quantidadeServicos from tb_servico s
      group by s.ref_tiposervico.descricao;

/

--32) � Emitir relat�rio que exiba os clientes cadastrados no sistema e que n�o receberam nenhum atendimento
      select tc.cod, tc.ref_cliente.nome from tb_cliente tc 
      where 
      tc.cod not in (select tb.ref_cliente.cod from tb_atendimento tb);
      
/