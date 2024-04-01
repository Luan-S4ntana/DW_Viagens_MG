USE DW_VIAGENS_MG

DROP TABLE TB_DIARIA
DROP TABLE TB_FUNCIONARIO
DROP TABLE TB_TIPO_FUNCIONARIO
DROP TABLE TB_CARGO
DROP TABLE TB_FUNCAO
DROP TABLE TB_CIDADE
DROP TABLE TB_ESTADO
DROP TABLE TB_PAIS
DROP TABLE TB_ORGAO_SCDP
DROP TABLE TB_MEIO_DE_TRANSPORTE
DROP TABLE TB_MOTIVO_VIAGEM
DROP TABLE TB_TIPO_DE_VIAGEM

-- --------------------------------------------------------

--
-- Estrutura para tabela `CIDADE`
--

-- POVOAMENTO OK
CREATE TABLE TB_PAIS (
  COD_PAIS INT NOT NULL PRIMARY KEY,
  PAIS VARCHAR(100) NOT NULL
)

-- POVOAMENTO OK
CREATE TABLE TB_ESTADO (
	COD_ESTADO INT NOT NULL PRIMARY KEY,
	ESTADO VARCHAR(100) NOT NULL,
	SIGLA VARCHAR(2) NOT NULL,
  COD_PAIS INT NOT NULL,
  CONSTRAINT FK_PAIS FOREIGN KEY (COD_PAIS) REFERENCES TB_PAIS (COD_PAIS)
)

-- POVOAMENTO OK
CREATE TABLE TB_CIDADE (
	COD_CIDADE INT NOT NULL PRIMARY KEY,
	CIDADE VARCHAR(100) NOT NULL,
	COD_ESTADO INT NOT NULL,
	CONSTRAINT FK_ESTADO FOREIGN KEY (COD_ESTADO) REFERENCES TB_ESTADO (COD_ESTADO)
)
-- --------------------------------------------------------

--
-- Estrutura para tabela `Tipo de FUNCIONARIO`
--

-- POVOAMENTO OK
CREATE TABLE TB_TIPO_FUNCIONARIO(
  COD_TIPO_FUNCIONARIO INT NOT NULL PRIMARY KEY,
  NOME VARCHAR(255) NOT NULL
)

-- --------------------------------------------------------

--
-- Estrutura para tabela `CARGO` 
--

-- POVOAMENTO OK
CREATE TABLE TB_CARGO (
  COD_CARGO INT NOT NULL PRIMARY KEY,
  NOME VARCHAR(45) NOT NULL,
)
-- --------------------------------------------------------

--
-- Estrutura para tabela `Funcionario`
--

-- POVOAMENTO OK
CREATE TABLE TB_FUNCIONARIO (
  COD_FUNCIONARIO INT NOT NULL PRIMARY KEY,
  NOME VARCHAR(45) NOT NULL,
  SOBRENOME VARCHAR(45) NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  COD_TIPO_FUNCIONARIO INT NOT NULL,
  COD_CARGO INT NOT NULL,
  CONSTRAINT FK_TIPO_FUNCIONARIO FOREIGN KEY (COD_TIPO_FUNCIONARIO) REFERENCES TB_TIPO_FUNCIONARIO (COD_TIPO_FUNCIONARIO),
  CONSTRAINT FK_CARGO FOREIGN KEY (COD_CARGO) REFERENCES TB_CARGO (COD_CARGO)
)

CREATE INDEX CPF_FUN_INDEX ON TB_FUNCIONARIO (CPF);
-- --------------------------------------------------------

--
-- Estrutura para tabela `Orgão SCDP`
--

-- POVOAMENTO OK
CREATE TABLE TB_ORGAO_SCDP (
  COD_ORGAO_SCDP INT NOT NULL PRIMARY KEY,
  NOME VARCHAR(255) NOT NULL,
 
)
-- --------------------------------------------------------

--
-- Estrutura para tabela `Meio de transporte`
--

-- POVOAMENTO OK
CREATE TABLE TB_MEIO_DE_TRANSPORTE(
  COD_MEIO_DE_TRANSPORTE INT NOT NULL PRIMARY KEY,
  NOME VARCHAR(100) NOT NULL
)

-- --------------------------------------------------------

--
-- Estrutura para tabela `Motivo da Viagem`
--

-- POVOAMENTO OK
CREATE TABLE TB_MOTIVO_VIAGEM(
  COD_MOTIVO_VIAGEM INT NOT NULL PRIMARY KEY,
  NOME VARCHAR(255) NOT NULL
)

-- --------------------------------------------------------

--
-- Estrutura para tabela `Tipo de viagem`
--

CREATE TABLE TB_TIPO_DE_VIAGEM(
  COD_TIPO_DE_VIAGEM INT NOT NULL PRIMARY KEY,
  NOME VARCHAR(255) NOT NULL
)

-- --------------------------------------------------------

--
-- Estrutura para tabela `Passagem`
--



CREATE TABLE TB_DIARIA (
  COD_DIARIA INT NOT NULL PRIMARY KEY,
  DATA_COMPRA DATETIME NOT NULL,
  DATA_PARTIDA DATETIME NOT NULL,
  DATA_CHEGADA DATETIME NOT NULL,
  QUANTIDADE_DIARIAS INT NOT NULL,
  VALOR NUMERIC(10,2) NOT NULL,
  COD_CIDADE_ORIGEM INT NOT NULL,
  COD_CIDADE_DESTINO INT NOT NULL,
  COD_FUNCIONARIO INT NOT NULL,
  COD_ORGAO_SCDP INT NOT NULL,
  COD_MEIO_DE_TRANSPORTE INT NOT NULL,
  COD_TIPO_DE_VIAGEM INT NOT NULL,
  COD_MOTIVO_VIAGEM INT NOT NULL,
  CONSTRAINT FK_CIDADE_ORIGEM FOREIGN KEY (COD_CIDADE_ORIGEM) REFERENCES TB_CIDADE (COD_CIDADE),
  CONSTRAINT FK_CIDADE_DESTINO FOREIGN KEY (COD_CIDADE_DESTINO) REFERENCES TB_CIDADE (COD_CIDADE),
  CONSTRAINT FK_FUNCIONARIO FOREIGN KEY (COD_FUNCIONARIO) REFERENCES TB_FUNCIONARIO (COD_FUNCIONARIO),
  CONSTRAINT FK_ORGAO_SCDP FOREIGN KEY (COD_ORGAO_SCDP) REFERENCES TB_ORGAO_SCDP (COD_ORGAO_SCDP),
  CONSTRAINT FK_MEIO_DE_TRANSPORTE FOREIGN KEY (COD_MEIO_DE_TRANSPORTE) REFERENCES TB_MEIO_DE_TRANSPORTE (COD_MEIO_DE_TRANSPORTE),
  CONSTRAINT FK_TIPO_VIAGEM FOREIGN KEY (COD_TIPO_DE_VIAGEM) REFERENCES TB_TIPO_DE_VIAGEM (COD_TIPO_DE_VIAGEM),
  CONSTRAINT FK_MOTIVO_VIAGEM FOREIGN KEY (COD_MOTIVO_VIAGEM) REFERENCES TB_MOTIVO_VIAGEM (COD_MOTIVO_VIAGEM),
)


-- --------------------------------------------------------

