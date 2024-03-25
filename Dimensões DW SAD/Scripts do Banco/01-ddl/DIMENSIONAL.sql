CREATE TABLE DimFuncao (
    idFuncao INT NOT NULL,
    anoExercicio INT NOT NULL,
    cdFuncao INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE DimCalendarioDias (
    idTempo INT NOT NULL,
    dia INT NOT NULL,
    mes INT NOT NULL,
    ano INT NOT NULL,
    dataFormatada DATE NOT NULL
);

CREATE TABLE DimFavorecidoSCDP (
    idFavorecido INT NOT NULL,
    idFuncao INT NOT NULL,
    nome VARCHAR(200) NOT NULL
);

CREATE TABLE DimCidade (
    idCidade INT NOT NULL,
    nome VARCHAR(200) NOT NULL
);

CREATE TABLE DimEstado (
    idEstado INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);
/*Atentar a mudança na variável qtDiarias conforme pedido por andré*/ 
CREATE TABLE FatoDiariasSCDP (
    idFatoDiariasSCDP INT NOT NULL,
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


CREATE TABLE DimCargoSCDP (
    idCargoSCDP INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE DimMeioTransporte (
    idMeioTransporte INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE DimMotivoViagem (
    idMotivoViagem INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE DimOrgaoSCDP (
    idOrgaoSCDP INT NOT NULL,
    cdOrgaoSCDP INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE DimPais (
    idPais INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE DimTipoViagem (
    idTipoViagem INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE DimTipoViajante (
    idTipoViajante INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);
