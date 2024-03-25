CREATE OR ALTER PROCEDURE sp_dim_MotivoViagem(@data_carga DATETIME)
AS
BEGIN
    DECLARE @NOME VARCHAR(100)

    DECLARE CUR CURSOR FOR
    SELECT nome FROM TB_AUX_MotivoViagem WHERE DATA_CARGA=@data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @NOME

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DimMotivoViagem WHERE nome = @NOME)
        BEGIN
            INSERT INTO DimMotivoViagem(nome)
            VALUES (@NOME)
        END
        FETCH NEXT FROM CUR INTO @NOME
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END