CREATE OR ALTER PROCEDURE sp_dim_Meio_De_Transporte(@data_carga DATETIME)
AS
BEGIN
    DECLARE @COD_MEIO_DE_TRANSPORTE INT 
    DECLARE @NOME VARCHAR(100)

    DECLARE CUR CURSOR FOR
    SELECT 
        COD_MEIO_DE_TRANSPORTE,
        NOME
    FROM 
        TB_AUX_MEIO_DE_TRANSPORTE
    WHERE 
        DATA_CARGA = @data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @COD_MEIO_DE_TRANSPORTE, @NOME

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DIM_MEIO_DE_TRANSPORTE WHERE COD_MEIO_DE_TRANSPORTE = @COD_MEIO_DE_TRANSPORTE)
        BEGIN
            INSERT INTO DIM_MEIO_DE_TRANSPORTE(COD_MEIO_DE_TRANSPORTE,NOME)
            VALUES (@COD_MEIO_DE_TRANSPORTE, @NOME)
        END
        FETCH NEXT FROM CUR INTO @COD_MEIO_DE_TRANSPORTE, @NOME
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END

-- ---------------------------------------

EXEC sp_dim_Meio_De_Transporte '20240330'

SELECT * FROM DIM_MEIO_DE_TRANSPORTE