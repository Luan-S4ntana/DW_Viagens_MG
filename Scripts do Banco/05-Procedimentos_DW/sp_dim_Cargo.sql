CREATE OR ALTER PROCEDURE sp_dim_Cargo(@data_carga DATETIME)
AS
BEGIN
    DECLARE @COD_CARGO INT
    DECLARE @NOME VARCHAR(45)

    DECLARE CUR CURSOR FOR
    SELECT 
        COD_CARGO,
        NOME
    FROM 
        TB_AUX_CARGO 
    WHERE 
        DATA_CARGA = @data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @COD_CARGO, @NOME

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DIM_CARGO WHERE COD_CARGO = @COD_CARGO)
        BEGIN
            INSERT INTO DIM_CARGO(COD_CARGO, NOME)
            VALUES (@COD_CARGO, @NOME)
        END
        FETCH NEXT FROM CUR INTO @COD_CARGO, @NOME
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END

-- ---------------------------------------

EXEC sp_dim_Cargo '20240330'

SELECT * FROM DIM_CARGO