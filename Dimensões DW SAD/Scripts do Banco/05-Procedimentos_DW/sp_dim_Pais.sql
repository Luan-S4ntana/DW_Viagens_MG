
CREATE OR ALTER PROCEDURE sp_dim_Pais(@data_carga DATETIME)
AS
BEGIN
    DECLARE @COD_PAIS INT
    DECLARE @PAIS VARCHAR(100)

    DECLARE CUR CURSOR FOR
    SELECT 
        COD_PAIS, 
        PAIS
    FROM 
        TB_AUX_PAIS 
    WHERE 
        DATA_CARGA = @data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @COD_PAIS, @PAIS

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DIM_PAIS WHERE COD_PAIS = @COD_PAIS)
        BEGIN
            INSERT INTO DIM_PAIS(COD_PAIS, PAIS)
            VALUES (@COD_PAIS, @PAIS)
        END
        FETCH NEXT FROM CUR INTO @COD_PAIS, @PAIS
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END

-- ---------------------------------------

EXEC sp_dim_Pais '20240330'

SELECT * FROM DIM_PAIS