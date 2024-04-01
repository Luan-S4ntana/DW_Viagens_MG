--Quais cidades de origem tiveram mais viagens de um determinado período?
SELECT 
    C.CIDADE,
    COUNT(*) AS QUANTIDADE 
FROM 
    FATO_DIARIA F 
INNER JOIN 
    DIM_CIDADE C ON C.ID_CIDADE = F.ID_CIDADE_ORIGEM 
INNER JOIN 
    DIM_TEMPO T ON T.ID_TEMPO = F.ID_DATA_COMPRA 
WHERE 
    T.NOME_MES = 'January' AND T.ANO = 2022 
GROUP BY 
    C.CIDADE 
ORDER BY 
    QUANTIDADE DESC;


-- Quais cidades de destino tiveram mais viagens de um determinado período?
SELECT  
    C.CIDADE,
    COUNT(*) AS QUANTIDADE
FROM 
    FATO_DIARIA F 
INNER JOIN 
    DIM_CIDADE C ON C.ID_CIDADE = F.ID_CIDADE_DESTINO 
INNER JOIN 
    DIM_TEMPO T ON T.ID_TEMPO = F.ID_DATA_COMPRA 
WHERE 
    T.NOME_MES = 'January' AND T.ANO = 2022 
GROUP BY 
    C.CIDADE 
ORDER BY 
    QUANTIDADE DESC;


--Quais estados de origem tiveram mais viagens de um determinado período?
SELECT 
    E.ESTADO,
    COUNT(*) AS QUANTIDADE 
FROM 
    FATO_DIARIA F 
INNER JOIN 
    DIM_ESTADO E ON E.ID_ESTADO = F.ID_ESTADO_ORIGEM 
INNER JOIN 
    DIM_TEMPO T ON T.ID_TEMPO = F.ID_DATA_COMPRA
WHERE 
    T.NOME_MES = 'January' AND T.ANO = 2022 
GROUP BY 
    E.ESTADO 
ORDER BY 
    QUANTIDADE DESC;


--Quais estados de destino tiveram mais viagens de um determinado período?
SELECT 
    E.ESTADO,
    COUNT(*) AS QUANTIDADE,  
FROM 
    FATO_DIARIA F 
INNER JOIN 
    DIM_ESTADO E ON E.ID_ESTADO = F.ID_ESTADO_DESTINO 
INNER JOIN 
    DIM_TEMPO T ON T.ID_TEMPO = F.ID_DATA_COMPRA 
WHERE 
    T.NOME_MES = 'January' AND T.ANO = 2022 
GROUP BY 
    E.ESTADO 
ORDER BY 
    QUANTIDADE DESC;


--Quais países de origem tiveram mais viagens de um determinado período?
SELECT 
    P.PAIS,
    COUNT(*) AS QUANTIDADE 
FROM 
    FATO_DIARIA F 
INNER JOIN 
    DIM_PAIS P ON P.ID_PAIS = F.ID_PAIS_ORIGEM 
INNER JOIN 
    DIM_TEMPO T ON T.ID_TEMPO = F.ID_DATA_COMPRA 
WHERE 
    T.NOME_MES = 'January' AND T.ANO = 2022 
GROUP BY 
    P.PAIS 
ORDER BY 
    QUANTIDADE DESC;


--Quais países de destino tiveram mais viagens de um determinado período?
SELECT 
    P.PAIS,
    COUNT(*) AS QUANTIDADE
FROM 
    FATO_DIARIA F 
INNER JOIN 
    DIM_PAIS P ON P.ID_PAIS = F.ID_PAIS_DESTINO 
INNER JOIN 
    DIM_TEMPO T ON T.ID_TEMPO = F.ID_DATA_COMPRA 
WHERE 
    T.NOME_MES = 'January' AND T.ANO = 2022 
GROUP BY 
    P.PAIS 
ORDER BY 
    QUANTIDADE DESC;


--Quais cargos tiveram mais ocorrência em um determinado período de tempo?
SELECT 
    CAR.NOME,
    COUNT(*) AS TOTAL_CARGO, 
FROM 
    FATO_DIARIA F 
INNER JOIN 
    DIM_CARGO CAR ON CAR.ID_CARGO = F.ID_CARGO
INNER JOIN 
    DIM_TEMPO T ON T.ID_TEMPO = F.ID_DATA_COMPRA 
WHERE 
    T.NOME_MES = 'January' AND T.ANO = 2022 
GROUP BY 
    CAR.NOME 
ORDER BY 
    TOTAL_CARGO DESC;


--Quais os meios de transporte mais utilizado de um determinado período?
SELECT 
    TRANS.NOME,
    COUNT(*) AS TOTAL_MEIO_TRANSPORTE  
FROM 
    FATO_DIARIA F 
INNER JOIN 
    DIM_MEIO_DE_TRANSPORTE TRANS ON TRANS.ID_MEIO_DE_TRANSPORTE = F.ID_MEIO_DE_TRANSPORTE
INNER JOIN 
    DIM_TEMPO T ON T.ID_TEMPO = F.ID_DATA_PARTIDA 
WHERE 
    T.NOME_MES = 'January' AND T.ANO = 2022 
GROUP BY 
    TRANS.NOME 
ORDER BY 
    TOTAL_MEIO_TRANSPORTE DESC;


--Quais foram os tipos de viagem que mais ocorreram em determinado período?
SELECT 
    TV.NOME,
    COUNT(*) AS TOTAL
FROM 
    FATO_DIARIA F 
INNER JOIN 
    DIM_TIPO_DE_VIAGEM TV ON TV.ID_TIPO_DE_VIAGEM = F.ID_TIPO_DE_VIAGEM
INNER JOIN 
    DIM_TEMPO T ON T.ID_TEMPO = F.ID_DATA_COMPRA  
WHERE 
    T.NOME_MES = 'January' AND T.ANO = 2022 
GROUP BY 
    TV.NOME 
ORDER BY 
    TOTAL DESC;