DROP TABLE TB_VIO_DIARIA
DROP TABLE FATO_DIARIA
DROP TABLE DIM_TEMPO
DROP TABLE DIM_PAIS
DROP TABLE DIM_ESTADO
DROP TABLE DIM_CIDADE
DROP TABLE DIM_TIPO_FUNCIONARIO
DROP TABLE DIM_CARGO
DROP TABLE DIM_FUNCIONARIO
DROP TABLE DIM_ORGAO_SCDP
DROP TABLE DIM_MEIO_DE_TRANSPORTE
DROP TABLE DIM_MOTIVO_VIAGEM
DROP TABLE DIM_TIPO_DE_VIAGEM
DROP TABLE DIM_FUNCAO

CREATE TABLE DIM_TEMPO (
	ID_TEMPO BIGINT	NOT NULL IDENTITY(1,1) PRIMARY KEY,
	NIVEL VARCHAR(8) NOT NULL CHECK (NIVEL IN('DIA', 'MES', 'ANO')),
	DATA DATETIME NULL,
	DIA	INT	NULL,
	DIA_SEMANA VARCHAR(50) NULL,
	FIM_SEMANA VARCHAR(5) NULL CHECK (FIM_SEMANA IN('SIM', 'NAO')),
	FERIADO	VARCHAR(100) NULL,
	FL_FERIADO VARCHAR(5) NULL CHECK (FL_FERIADO IN ('SIM', 'NAO')),
	MES	INT	NULL,
	NOME_MES VARCHAR(100) NULL,
	TRIMESTRE INT NULL,
	NOME_TRIMESTRE VARCHAR(100) NULL,
	SEMESTRE INT NULL,
	NOME_SEMESTRE VARCHAR(100) NULL,
	ANO	INT	NOT NULL
)

-- PROCEDURE OKAY
CREATE TABLE DIM_PAIS (
    ID_PAIS INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    COD_PAIS INT NOT NULL,
    PAIS VARCHAR(100) NOT NULL
)

-- PROCEDURE OKAY
CREATE TABLE DIM_ESTADO (
    ID_ESTADO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COD_ESTADO INT NOT NULL,
	ESTADO VARCHAR(100) NOT NULL,
	SIGLA VARCHAR(2) NOT NULL,
)

-- PROCEDURE OKAY
CREATE TABLE DIM_CIDADE (
    ID_CIDADE INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COD_CIDADE INT NOT NULL,
	CIDADE VARCHAR(100) NOT NULL,
)


-- PROCEDURE OKAY
CREATE  TABLE  DIM_TIPO_FUNCIONARIO(
    ID_TIPO_FUNCIONARIO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    COD_TIPO_FUNCIONARIO INT NOT NULL,
    NOME VARCHAR(255) NOT NULL
)

-- PROCEDURE OKAY
CREATE TABLE DIM_CARGO (
    ID_CARGO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    COD_CARGO INT NOT NULL,
    NOME VARCHAR(45) NOT NULL
)

-- PROCEDURE OKAY
CREATE TABLE DIM_FUNCIONARIO (
    ID_FUNCIONARIO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    COD_FUNCIONARIO INT NOT NULL,
    NOME VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) NOT NULL,
)

-- PROCEDURE OKAY
CREATE TABLE DIM_ORGAO_SCDP (
    ID_ORGAO_SCDP INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    COD_ORGAO_SCDP INT NOT NULL,
    NOME VARCHAR(255) NOT NULL,
)

-- PROCEDURE OKAY
CREATE TABLE DIM_MEIO_DE_TRANSPORTE(
    ID_MEIO_DE_TRANSPORTE INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    COD_MEIO_DE_TRANSPORTE INT NOT NULL,
    NOME VARCHAR(100) NOT NULL
)

-- PROCEDURE OKAY
CREATE TABLE DIM_MOTIVO_VIAGEM(
    ID_MOTIVO_VIAGEM INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    COD_MOTIVO_VIAGEM INT NOT NULL,
    NOME VARCHAR(255) NOT NULL
)

CREATE TABLE DIM_TIPO_DE_VIAGEM(
    ID_TIPO_DE_VIAGEM INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    COD_TIPO_DE_VIAGEM INT NOT NULL,
    NOME VARCHAR(255) NOT NULL
)


/*Atentar a mudança na variável qtDiarias conforme pedido por andré*/ 
CREATE TABLE FATO_DIARIA (
    ID_DIARIA INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    COD_DIARIA INT NOT NULL,
    QUANTIDADE_DIARIAS INT NOT NULL,
    VALOR NUMERIC(10,2) NOT NULL,
    ID_DATA_COMPRA BIGINT NOT NULL,
    ID_DATA_PARTIDA BIGINT NOT NULL,
    ID_DATA_CHEGADA BIGINT NOT NULL,
    ID_CIDADE_ORIGEM INT NOT NULL,
    ID_CIDADE_DESTINO INT NOT NULL,
    ID_ESTADO_ORIGEM INT NOT NULL,
    ID_ESTADO_DESTINO INT NOT NULL,
    ID_PAIS_ORIGEM INT NOT NULL,
    ID_PAIS_DESTINO INT NOT NULL,
    ID_FUNCIONARIO INT NOT NULL,
    ID_ORGAO_SCDP INT NOT NULL,
    ID_MEIO_DE_TRANSPORTE INT NOT NULL,
    ID_TIPO_DE_VIAGEM INT NOT NULL,
    ID_TIPO_FUNCIONARIO INT NOT NULL,
    ID_MOTIVO_VIAGEM INT NOT NULL,
    CONSTRAINT FK_DIM_DATA_COMPRA FOREIGN KEY (ID_DATA_COMPRA) REFERENCES DIM_TEMPO (ID_TEMPO),
    CONSTRAINT FK_DIM_DATA_PARTIDA FOREIGN KEY (ID_DATA_PARTIDA) REFERENCES DIM_TEMPO (ID_TEMPO),
    CONSTRAINT FK_DIM_DATA_CHEGADA FOREIGN KEY (ID_DATA_CHEGADA) REFERENCES DIM_TEMPO (ID_TEMPO),
    CONSTRAINT FK_DIM_CIDADE_ORIGEM FOREIGN KEY (ID_CIDADE_ORIGEM) REFERENCES DIM_CIDADE (ID_CIDADE),
    CONSTRAINT FK_DIM_CIDADE_DESTINO FOREIGN KEY (ID_CIDADE_DESTINO) REFERENCES DIM_CIDADE (ID_CIDADE),
    CONSTRAINT FK_DIM_ESTADO_ORIGEM FOREIGN KEY (ID_ESTADO_ORIGEM) REFERENCES DIM_ESTADO (ID_ESTADO),
    CONSTRAINT FK_DIM_ESTADO_DESTINO FOREIGN KEY (ID_ESTADO_DESTINO) REFERENCES DIM_ESTADO (ID_ESTADO),
    CONSTRAINT FK_DIM_PAIS_ORIGEM FOREIGN KEY (ID_PAIS_ORIGEM) REFERENCES DIM_PAIS (ID_PAIS),
    CONSTRAINT FK_DIM_PAIS_DESTINO FOREIGN KEY (ID_PAIS_DESTINO) REFERENCES DIM_PAIS (ID_PAIS),
    CONSTRAINT FK_DIM_FUNCIONARIO FOREIGN KEY (ID_FUNCIONARIO) REFERENCES DIM_FUNCIONARIO (ID_FUNCIONARIO),
    CONSTRAINT FK_DIM_ORGAO_SCDP FOREIGN KEY (ID_ORGAO_SCDP) REFERENCES DIM_ORGAO_SCDP (ID_ORGAO_SCDP),
    CONSTRAINT FK_DIM_MEIO_DE_TRANSPORTE FOREIGN KEY (ID_MEIO_DE_TRANSPORTE) REFERENCES DIM_MEIO_DE_TRANSPORTE (ID_MEIO_DE_TRANSPORTE),
    CONSTRAINT FK_DIM_TIPO_VIAGEM FOREIGN KEY (ID_TIPO_DE_VIAGEM) REFERENCES DIM_TIPO_DE_VIAGEM (ID_TIPO_DE_VIAGEM),
    CONSTRAINT FK_DIM_TIPO_FUNCIONARIO FOREIGN KEY (ID_TIPO_FUNCIONARIO) REFERENCES DIM_TIPO_FUNCIONARIO (ID_TIPO_FUNCIONARIO),
    CONSTRAINT FK_DIM_MOTIVO_VIAGEM FOREIGN KEY (ID_MOTIVO_VIAGEM) REFERENCES DIM_MOTIVO_VIAGEM (ID_MOTIVO_VIAGEM),
)


CREATE TABLE TB_VIO_DIARIA (
    ID_VIOLACAO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	DATA_CARGA DATETIME NOT NULL,
	DATA_COMPRA DATETIME NULL,
    DATA_PARTIDA DATETIME NULL,
    DATA_CHEGADA DATETIME NULL,
	COD_DIARIA INT NULL,
    COD_CIDADE_ORIGEM INT NULL,
    COD_CIDADE_DESTINO INT NULL,
    COD_ESTADO_ORIGEM INT NULL,
    COD_ESTADO_DESTINO INT NULL,
    COD_PAIS_ORIGEM INT NULL,
    COD_PAIS_DESTINO INT NULL,
	COD_FUNCIONARIO INT  NULL,
	COD_ORGAO_SCDP INT NULL,
	COD_MEIO_DE_TRANSPORTE INT NULL,
    COD_TIPO_DE_VIAGEM INT NULL,
    COD_MOTIVO_VIAGEM INT NULL,
	QUANTIDADE_DIARIAS INT NULL,
	VALOR NUMERIC(10,2) NULL,
	DT_ERRO DATETIME NOT NULL,
    VIOLACAO VARCHAR(255) NOT NULL
)

