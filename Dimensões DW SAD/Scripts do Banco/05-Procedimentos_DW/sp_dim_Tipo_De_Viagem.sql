CREATE OR ALTER PROCEDURE sp_dim_Tipo_De_Viagem(@data_carga DATETIME)
AS
BEGIN
    DECLARE @COD_TIPO_DE_VIAGEM INT
    DECLARE @NOME VARCHAR(255)

    DECLARE CUR CURSOR FOR
    SELECT 
        COD_TIPO_DE_VIAGEM,
        NOME 
    FROM 
        TB_AUX_TIPO_DE_VIAGEM 
    WHERE 
        DATA_CARGA = @data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @COD_TPO_DE_VIAGEM, @NOME

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DIM_TIPO_DE_VIAGEM WHERE COD_TIPO_DE_VIAGEM = @COD_TIPO_DE_VIAGEM)
        BEGIN
            INSERT INTO DIM_TIPO_DE_VIAGEM(COD_TIPO_DE_VIAGEM, NOME)
            VALUES (@COD_TIPO_DE_VIAGEM, @NOME)
        END
        FETCH NEXT FROM CUR INTO @COD_TIPO_DE_VIAGEM, @NOME
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END

-- ---------------------------------------

EXEC sp_dim_Tipo_De_Viagem '20240330'

SELECT * FROM DIM_TIPO_DE_VIAGEM