
CREATE OR ALTER PROCEDURE sp_dim_DimCargoSCDP(@data_carga DATETIME)
AS
BEGIN
    DECLARE @NOME VARCHAR(100)

    DECLARE CUR CURSOR FOR
    SELECT nome FROM TB_AUX_DimCargoSCDP WHERE DATA_CARGA=@data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @NOME

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DimCargoSCDP WHERE nome = @NOME)
        BEGIN
            INSERT INTO DimCargoSCDP(nome)
            VALUES (@NOME)
        END
        FETCH NEXT FROM CUR INTO @NOME
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END