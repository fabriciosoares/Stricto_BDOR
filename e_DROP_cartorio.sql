-----------------comandos de drop---------------------------------------------------------------------

DROP TABLE "TB_CARGO" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_SETOR" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_JORNADA" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_HISTORICO_SETOR_FUNCIONARIO" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_ATENDIMENTO" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_CLIENTE" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_DESCONTO" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_FISICA" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_FUNCIONARIO" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_JURIDICA" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_LIVRO" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_REGISTRO" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_SERVICO" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_SERVICODOATENDIMENTO" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_TIPOSERVICO" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_LOGATENDIMENTO" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_LOGSERVICODOATENDIMENTO" CASCADE CONSTRAINTS PURGE;

DROP TABLE "TB_LOGREGISTRO" CASCADE CONSTRAINTS PURGE;

DROP type "TP_SETOR" force;

DROP type "TP_CARGO" force;

DROP type "TP_ATENDIMENTO" force;

DROP type "TP_CLIENTE" force;

DROP type "TP_DESCONTO" force;

DROP type "TP_ENDERECO" force;

DROP type "TP_FISICA" force;

DROP type "TP_TELEFONE" force;

DROP type "ARRAY_TELEFONE" force;

DROP type "TP_FUNCIONARIO" force;

DROP type "TP_GRATIFICACAO" force;

DROP type "TP_JURIDICA" force;

DROP type "TP_LIVRO" force;

DROP type "TP_PESSOA" force;

DROP type "TP_REGISTRO" force;

DROP type "TP_SERVICO" force;

DROP type "TP_SERVICODOATENDIMENTO" force;

DROP type "TP_TIPOSERVICO" force;

DROP type "TP_TUPLAATENDIMENTO" force;

DROP type "TP_TUPLASERVICODOATENDIMENTO" force;

DROP type "TP_TUPLAREGISTRO" force;

DROP type "NESTED_GRATIFICACAO" force;

DROP type "TP_HISTORICO_SETOR_FUNCIONARIO" force;

drop type "TP_JORNADA" force;

DROP sequence "SEQ_PESSOA";

DROP sequence "SEQ_CARGO";

DROP sequence "SEQ_SETOR";

DROP sequence "SEQ_JORNADA";

DROP sequence "SEQ_LIVRO";

DROP sequence "SEQ_TIPOSERVICO";

DROP sequence "SEQ_SERVICO";

DROP sequence "SEQ_DESCONTO";

DROP sequence "SEQ_REGISTRO";

DROP sequence "SEQ_ATENDIMENTO";

DROP sequence "SEQ_SERVICODOATENDIMENTO"; 

DROP function "VALIDA_CNPJ"; 

DROP function "VALIDA_CPF";  

DROP SEQUENCE SEQ_LOGSERVICODOATENDIMENTO;

DROP SEQUENCE SEQ_LOGATENDIMENTO; 

drop sequencE SEQ_LOGREGISTRO;


