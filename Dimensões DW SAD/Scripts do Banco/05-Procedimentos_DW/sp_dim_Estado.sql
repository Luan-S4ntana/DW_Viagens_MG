CREATE OR ALTER PROCEDURE sp_dim_Estado(@data_carga DATETIME)
AS
BEGIN
    DECLARE @NOME VARCHAR(100)

    DECLARE CUR CURSOR FOR
    SELECT nome FROM TB_AUX_Estado WHERE DATA_CARGA=@data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @NOME

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DimEstado WHERE nome = @NOME)
        BEGIN
            INSERT INTO DimEstado(nome)
            VALUES (@NOME)
        END
        FETCH NEXT FROM CUR INTO @NOME
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END