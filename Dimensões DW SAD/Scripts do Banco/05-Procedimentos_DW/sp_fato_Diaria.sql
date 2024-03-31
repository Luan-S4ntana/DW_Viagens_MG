CREATE OR ALTER PROCEDURE sp_fato_Diaria(@data_carga DATETIME)
AS
BEGIN

    DECLARE @COD_DIARIA INT
    DECLARE @DATA_COMPRA DATETIME 
    DECLARE @DATA_PARTIDA DATETIME
    DECLARE @DATA_CHEGADA DATETIME 
    DECLARE @QUANTIDADE_DIARIAS INT
    DECLARE @VALOR NUMERIC(10,2)
    DECLARE @COD_CIDADE_ORIGEM INT
    DECLARE @COD_CIDADE_DESTINO INT
    DECLARE @COD_ESTADO_ORIGEM INT
    DECLARE @COD_ESTADO_DESTINO INT
    DECLARE @COD_PAIS_ORIGEM INT
    DECLARE @COD_PAIS_DESTINO INT
    DECLARE @COD_FUNCIONARIO INT 
    DECLARE @COD_ORGAO_SCDP INT 
    DECLARE @COD_MEIO_DE_TRANSPORTE INT 
    DECLARE @COD_TIPO_DE_VIAGEM INT
    DECLARE @COD_MOTIVO_VIAGEM INT

    DECLARE @ID_DATA_COMPRA BIGINT 
    DECLARE @ID_DATA_PARTIDA BIGINT 
    DECLARE @ID_DATA_CHEGADA BIGINT
    DECLARE @ID_CIDADE_ORIGEM INT 
    DECLARE @ID_CIDADE_DESTINO INT 
    DECLARE @ID_ESTADO_ORIGEM INT 
    DECLARE @ID_ESTADO_DESTINO INT
    DECLARE @ID_PAIS_ORIGEM INT 
    DECLARE @ID_PAIS_DESTINO INT
    DECLARE @ID_FUNCIONARIO INT 
    DECLARE @ID_ORGAO_SCDP INT 
    DECLARE @ID_MEIO_DE_TRANSPORTE INT
    DECLARE @ID_TIPO_DE_VIAGEM INT 
    DECLARE @ID_MOTIVO_VIAGEM INT

    DECLARE @ID_VIOLACAO INT

    DECLARE CUR CURSOR FOR
    SELECT
        COD_DIARIA,
        DATA_COMPRA,
        DATA_PARTIDA,
        DATA_CHEGADA,
        QUANTIDADE_DIARIAS,
        VALOR,
        COD_CIDADE_ORIGEM,
        COD_CIDADE_DESTINO,
        COD_ESTADO_ORIGEM,
        COD_ESTADO_DESTINO,
        COD_PAIS_ORIGEM,
        COD_PAIS_DESTINO
        COD_FUNCIONARIO,
        COD_ORGAO_SCDP,
        COD_MEIO_DE_TRANSPORTE,
        COD_TIPO_DE_VIAGEM,
        COD_MOTIVO_VIAGEM
    FROM
        TB_AUX_DIARIA
    WHERE
        DATA_CARGA = @data_carga

    OPEN CUR
    FETCH NEXT FROM CUR INTO @COD_DIARIA, @DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA, @QUANTIDADE_DIARIAS, @VALOR, @COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO, @COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE, @COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @ID_DATA_COMPRA = NULL 
        SET @ID_DATA_PARTIDA = NULL 
        SET @ID_DATA_CHEGADA = NULL 
        SET @ID_CIDADE_ORIGEM = NULL 
        SET @ID_CIDADE_DESTINO = NULL 
        SET @ID_ESTADO_ORIGEM = NULL 
        SET @ID_ESTADO_DESTINO = NULL
        SET @ID_PAIS_ORIGEM = NULL 
        SET @ID_PAIS_DESTINO = NULL
        SET @ID_FUNCIONARIO = NULL 
        SET @ID_ORGAO_SCDP = NULL 
        SET @ID_MEIO_DE_TRANSPORTE = NULL
        SET @ID_TIPO_DE_VIAGEM = NULL 
        SET @ID_MOTIVO_VIAGEM = NULL

        SET @ID_VIOLACAO = NULL

        SELECT @ID_DATA_COMPRA = ID_TEMPO
        FROM DIM_TEMPO
        WHERE DATA = @DATA_COMPRA AND NIVEL = 'DIA'

        IF @ID_DATA_COMPRA IS NULL
        BEGIN
            INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
            VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE,@COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'DATA COMPRA INVÁLIDA')
        END


        SELECT @ID_DATA_PARTIDA = ID_TEMPO
        FROM DIM_TEMPO
        WHERE DATA = @DATA_PARTIDA AND NIVEL = 'DIA'

        IF @ID_DATA_PARTIDA IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', DATA PARTIDA INVÁLIDA'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE,@COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'DATA PARTIDA INVÁLIDA')
            END
        END


        SELECT @ID_DATA_CHEGADA = ID_TEMPO
        FROM DIM_TEMPO
        WHERE DATA = @DATA_CHEGADA AND NIVEL = 'DIA'

        IF @ID_DATA_CHEGADA IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', DATA CHEGADA INVÁLIDA'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE, @COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'DATA CHEGADA INVÁLIDA')
            END
        END


        SELECT @ID_CIDADE_ORIGEM = ID_CIDADE
        FROM DIM_CIDADE
        WHERE COD_CIDADE = @COD_CIDADE_ORIGEM

        IF @ID_CIDADE_ORIGEM IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', CIDADE DE ORIGEM INVÁLIDA'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE,@COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'CIDADE DE ORIGEM INVÁLIDA')            
            END
        END


        SELECT @ID_CIDADE_DESTINO = ID_CIDADE
        FROM DIM_CIDADE
        WHERE COD_CIDADE = @COD_CIDADE_DESTINO

        IF @ID_CIDADE_DESTINO IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', CIDADE DE DESTINO INVÁLIDA'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE, @COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'CIDADE DE DESTINO INVÁLIDA')              
            END
        END


        SELECT @ID_ESTADO_ORIGEM = ID_ESTADO
        FROM DIM_ESTADO 
        WHERE COD_ESTADO = @COD_ESTADO_ORIGEM

        IF @ID_ESTADO_ORIGEM IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', ESTADO ORIGEM INVÁLIDO'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE,@COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'ESTADO ORIGEM INVÁLIDO')              
            
            END
        END


        SELECT @ID_ESTADO_DESTINO = ID_ESTADO
        FROM DIM_ESTADO 
        WHERE COD_ESTADO = @COD_ESTADO_DESTINO

        IF @ID_ESTADO_DESTINO IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', ESTADO DESTINO INVÁLIDO'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE,@COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'ESTADO DESTINO INVÁLIDO')                          
            END
        END


        SELECT @ID_PAIS_ORIGEM = ID_PAIS
        FROM DIM_PAIS 
        WHERE COD_PAIS = @COD_PAIS_ORIGEM

        IF @ID_PAIS_ORIGEM IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', PAIS ORIGEM INVÁLIDO'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE,@COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'PAIS ORIGEM INVÁLIDO')                          
            END
        END


        SELECT @ID_PAIS_DESTINO = ID_PAIS
        FROM DIM_PAIS 
        WHERE COD_PAIS = @COD_PAIS_DESTINO

        IF @ID_PAIS_DESTINO IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', PAIS DESTINO INVÁLIDO'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE,@COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'PAIS DESTINO INVÁLIDO')                          
            END
        END


        SELECT @ID_FUNCIONARIO = ID_FUNCIONARIO
        FROM DIM_FUNCIONARIO
        WHERE COD_FUNCIONARIO = @COD_FUNCIONARIO

        IF @ID_FUNCIONARIO IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', FUNCIONARIO INVÁLIDO'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE,@COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'FUNCIONARIO INVÁLIDO')                         
            END
        END


        SELECT @ID_ORGAO_SCDP = ID_ORGAO_SCDP
        FROM DIM_ORGAO_SCDP
        WHERE COD_ORGAO_SCDP = @COD_ORGAO_SCDP

        IF @ID_ORGAO_SCDP IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', ORGAO SCDP INVÁLIDO'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE,@COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'ORGAO SCDP INVÁLIDO')                          
            END
        END


        SELECT @ID_MEIO_DE_TRANSPORTE = ID_MEIO_DE_TRANSPORTE
        FROM DIM_MEIO_DE_TRANSPORTE
        WHERE COD_MEIO_DE_TRANSPORTE = @COD_MEIO_DE_TRANSPORTE

        IF @ID_MEIO_DE_TRANSPORTE IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', MEIO DE TRANSPORTE INVÁLIDO'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE,@COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'MEIO DE TRANSPORTE INVÁLIDO')                          
            END
        END


        SELECT @ID_TIPO_DE_VIAGEM = ID_TIPO_DE_VIAGEM
        FROM DIM_TPO_DE_VIAGEM
        WHERE COD_TPO_DE_VIAGEM = @COD_TIPO_DE_VIAGEM

        IF @ID_TIPO_DE_VIAGEM IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', TIPO DE VIAGEM INVÁLIDO'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE,@COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'TIPO DE VIAGEM INVÁLIDO')                          
            END
        END


        SELECT @ID_MOTIVO_VIAGEM = ID_MOTIVO_VIAGEM
        FROM DIM_MOTIVO_VIAGEM
        WHERE COD_MOTIVO_VIAGEM = @COD_MOTIVO_VIAGEM
        
        IF @ID_MOTIVO_VIAGEM IS NULL
        BEGIN
            IF EXISTS (SELECT * FROM TB_VIO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
            BEGIN
                SELECT
                    @ID_VIOLACAO = ID_VIOLACAO
                FROM
                    TB_VIO_DIARIA
                WHERE
                    COD_DIARIA = @COD_DIARIA

                UPDATE
                    TB_VIO_DIARIA
                SET
                    VIOLACAO = VIOLACAO + ', MOTIVO VIAGEM INVÁLIDO'
                WHERE 
                    ID_VIOLACAO = @ID_VIOLACAO
            END
            ELSE
            BEGIN
                INSERT INTO TB_VIO_DIARIA (DATA_CARGA,DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,COD_DIARIA,COD_CIDADE_ORIGEM, COD_CIDADE_DESTINO,COD_ESTADO_ORIGEM, COD_ESTADO_DESTINO,COD_PAIS_ORIGEM,COD_PAIS_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM,QUANTIDADE_DIARIAS,VALOR,DT_ERRO,VIOLACAO)
                VALUES (@data_carga,@DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA,@COD_DIARIA,@COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO,@COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE,@COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM,@QUANTIDADE_DIARIAS,@VALOR, GETDATE(), 'MOTIVO VIAGEM INVÁLIDO')              
            
            END
        END


        IF EXISTS (SELECT * FROM FATO_DIARIA WHERE COD_DIARIA = @COD_DIARIA) AND @COD_DIARIA IS NOT NULL
        BEGIN
            UPDATE FATO_DIARIA
            SET
                QUANTIDADE_DIARIAS = @QUANTIDADE_DIARIAS,
                VALOR = @VALOR,
                ID_DATA_COMPRA = @ID_DATA_COMPRA,
                ID_DATA_PARTIDA = @ID_DATA_PARTIDA,
                ID_DATA_CHEGADA = @ID_DATA_CHEGADA,
                ID_CIDADE_ORIGEM = @ID_CIDADE_ORIGEM,
                ID_CIDADE_DESTINO = @ID_CIDADE_DESTINO,
                ID_ESTADO_ORIGEM = @ID_ESTADO_ORIGEM,
                ID_ESTADO_DESTINO = @ID_ESTADO_DESTINO,
                ID_PAIS_ORIGEM = @ID_PAIS_ORIGEM,
                ID_PAIS_DESTINO = @ID_PAIS_DESTINO,
                ID_FUNCIONARIO = @ID_FUNCIONARIO,
                ID_ORGAO_SCDP = @ID_ORGAO_SCDP,
                ID_MEIO_DE_TRANSPORTE = @ID_MEIO_DE_TRANSPORTE,
                ID_TPO_DE_VIAGEM = @ID_TIPO_DE_VIAGEM,
                ID_MOTIVO_VIAGEM = @ID_MOTIVO_VIAGEM
            WHERE
                COD_DIARIA = @COD_DIARIA
        END
        ELSE
        BEGIN
            INSERT INTO FATO_DIARIA (COD_DIARIA,QUANTIDADE_DIARIAS,VALOR,ID_DATA_COMPRA,ID_DATA_PARTIDA,ID_DATA_CHEGADA,ID_CIDADE_ORIGEM,ID_CIDADE_DESTINO,ID_ESTADO_ORIGEM,ID_ESTADO_DESTINO,ID_PAIS_ORIGEM,ID_PAIS_DESTINO,ID_FUNCIONARIO,ID_ORGAO_SCDP,ID_MEIO_DE_TRANSPORTE,ID_TPO_DE_VIAGEM,ID_MOTIVO_VIAGEM)
            VALUES (@COD_DIARIA,@QUANTIDADE_DIARIAS,@VALOR,@ID_DATA_COMPRA,@ID_DATA_PARTIDA,@ID_DATA_CHEGADA,@ID_CIDADE_ORIGEM,@ID_CIDADE_DESTINO,@ID_ESTADO_ORIGEM,@ID_ESTADO_DESTINO,@ID_PAIS_ORIGEM,@ID_PAIS_DESTINO,@ID_FUNCIONARIO,@ID_ORGAO_SCDP,@ID_MEIO_DE_TRANSPORTE,@ID_TIPO_DE_VIAGEM,@ID_MOTIVO_VIAGEM)
        END

        FETCH NEXT FROM CUR INTO @COD_DIARIA, @DATA_COMPRA, @DATA_PARTIDA, @DATA_CHEGADA, @QUANTIDADE_DIARIAS, @VALOR, @COD_CIDADE_ORIGEM, @COD_CIDADE_DESTINO, @COD_ESTADO_ORIGEM, @COD_ESTADO_DESTINO, @COD_PAIS_ORIGEM, @COD_PAIS_DESTINO, @COD_FUNCIONARIO, @COD_ORGAO_SCDP, @COD_MEIO_DE_TRANSPORTE, @COD_TIPO_DE_VIAGEM, @COD_MOTIVO_VIAGEM
    END

    CLOSE CUR
    DEALLOCATE CUR 
END

-- -------------------------------

EXEC sp_fato_Diaria '20240330'

SELECT * FROM FATO_DIARIA