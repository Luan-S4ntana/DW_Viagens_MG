CREATE TABLE TB_AUX_Funcao (
    DATA_CARGA DATETIME NOT NULL,
    anoExercicio INT NOT NULL,
    cdFuncao INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);


CREATE TABLE TB_AUX_CalendarioDias (
    DATA_CARGA DATETIME NOT NULL,
    dia INT NOT NULL,
    mes INT NOT NULL,
    ano INT NOT NULL,
    dataFormatada DATE NOT NULL
);

CREATE TABLE TB_AUX_ItemDeDespesa (
    DATA_CARGA DATETIME NOT NULL,
    cdItem INT NOT NULL,
    nome VARCHAR(200) NOT NULL
);

CREATE TABLE TB_AUX_Programa (
    DATA_CARGA DATETIME NOT NULL,
    anoExercicio INT NOT NULL,
    cdPrograma INT NOT NULL,
    nome VARCHAR(200) NOT NULL
);

CREATE TABLE TB_AUX_AcaoOrcamentaria (
    DATA_CARGA DATETIME NOT NULL,
    anoExercicio INT NOT NULL,
    cdAcao INT NOT NULL,
    nome VARCHAR(200) NOT NULL
);

CREATE TABLE TB_AUX_FavorecidoSCDP (
    DATA_CARGA DATETIME NOT NULL,
    idFuncao INT NOT NULL,
    nome VARCHAR(200) NOT NULL
);


CREATE TABLE TB_AUX_EmpenhoDespesaDiariasSCDP (
    DATA_CARGA DATETIME NOT NULL,
    anoExercicio INT NOT NULL,
    nrEmpenho INT NOT NULL,
    dtEmpenho DATE NOT NULL,
    unidadeExecutora VARCHAR(100) NOT NULL,
    tipoEmpenho VARCHAR(7) NOT NULL CHECK (tipoEmpenho IN ('EMPENHO', 'GLOBAL')),
    vrEmpenho NUMERIC(10, 2) NOT NULL,
    cdUniProgGasto INT NOT NULL,
    uniProgGasto VARCHAR(200)
);

CREATE TABLE TB_AUX_FonteDeRecurso (
    DATA_CARGA DATETIME NOT NULL,
    cdFonte INT NOT NULL,
    nome VARCHAR(200) NOT NULL
);

CREATE TABLE TB_AUX_Cidade (
    DATA_CARGA DATETIME NOT NULL,
    nome VARCHAR(200) NOT NULL
);

CREATE TABLE TB_AUX_Estado (
    DATA_CARGA DATETIME NOT NULL,
    nome VARCHAR(100) NOT NULL
);
/*Atentar a mudança na variável qtDiarias conforme pedido por andré*/ 
CREATE TABLE TB_AUX_FatoDiariasSCDP (
    DATA_CARGA DATETIME NOT NULL,
    idTempo INT NOT NULL,
    idFavorecido INT NOT NULL,
    idCargo INT NOT NULL,
    idFuncao INT NOT NULL,
    idOrgao INT NOT NULL,
    idPaisOrigem INT NOT NULL,
    idEstadoOrigem INT NOT NULL,
    idCidadeOrigem INT NOT NULL,
    idPaisDestino INT NOT NULL,
    idEstadoDestino INT NOT NULL,
    idCidadeDestino INT NOT NULL,
    idDocumentoViagem INT NOT NULL,
    idTipoViagem INT NOT NULL,
    idTipoViajante INT NOT NULL,
    idMeioTransporte INT NOT NULL,
    idMotivo INT NOT NULL,
    ordemTrecho INT NOT NULL,
    anoParticao INT NOT NULL,
    dtInicioTrecho DATE NOT NULL,
    dtFimTrecho DATE NOT NULL,
    qtDiaria INT NOT NULL DEFAULT 1,
    vrDiaria NUMERIC(10, 2) NOT NULL,
    vrPassagem NUMERIC(10, 2) NOT NULL
);

CREATE TABLE TB_AUX_FatoDiariasSCDPLiquidacaoEPagamento (
    DATA_CARGA DATETIME NOT NULL,
    idEmpenho INT NOT NULL,
    idPrograma INT NOT NULL,
    idFuncao INT NOT NULL,
    idFonte INT NOT NULL,
    idItem INT NOT NULL,
    idAcao INT NOT NULL,
    flPassagem INT NOT NULL,
    nrLiquidacao INT NOT NULL,
    nrPagamento INT NOT NULL,
    dtLiquidacao DATE NOT NULL,
    dtPagamento DATE NOT NULL,
    vrDevolvido NUMERIC(10, 2) NOT NULL,
    vrLiqPag NUMERIC(10, 2) NOT NULL
);

CREATE TABLE TB_AUX_DimCargoSCDP (
    DATA_CARGA DATETIME NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE TB_AUX_MeioTransporte (
    DATA_CARGA DATETIME NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE TB_AUX_MotivoViagem (
    DATA_CARGA DATETIME NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE TB_AUX_OrgaoSCDP (
    DATA_CARGA DATETIME NOT NULL,
    cdOrgaoSCDP INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE TB_AUX_Pais (
    DATA_CARGA DATETIME NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE TB_AUX_TipoViagem (
    DATA_CARGA DATETIME NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE TB_AUX_TipoViajante (
    DATA_CARGA DATETIME NOT NULL,
    nome VARCHAR(100) NOT NULL
);
