--DONE
CREATE TABLE TB_AUX_Funcao (
    DATA_CARGA DATETIME NOT NULL,
    anoExercicio INT NOT NULL,
    cdFuncao INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);

--TODO
CREATE TABLE TB_AUX_CalendarioDias (
    DATA_CARGA DATETIME NOT NULL,
    dia INT NOT NULL,
    mes INT NOT NULL,
    ano INT NOT NULL,
    dataFormatada DATE NOT NULL
);

--DONE
CREATE TABLE TB_AUX_FavorecidoSCDP (
    DATA_CARGA DATETIME NOT NULL,
    idFuncao INT NOT NULL,
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
/*Atentar a mudan�a na vari�vel qtDiarias conforme pedido por andr�*/ 
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
