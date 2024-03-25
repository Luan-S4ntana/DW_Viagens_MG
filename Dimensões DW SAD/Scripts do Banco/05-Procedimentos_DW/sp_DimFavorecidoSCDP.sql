CREATE OR ALTER PROCEDURE sp_DimFavorecidoSCDP(@data_carga DATETIME)
AS
BEGIN
    DECLARE @idFuncao INT
	DECLARE @NOME VARCHAR(200)

    DECLARE CUR CURSOR FOR
    SELECT  @idFuncao, @NOME FROM TB_AUX_FavorecidoSCDP WHERE DATA_CARGA = @data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @idFuncao, @NOME

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DimItemDeDespesa WHERE NOME = @NOME)
        BEGIN
            INSERT INTO DimFavorecidoSCDP (idFuncao,nome)
            VALUES (@idFuncao, @NOME)
        END
        FETCH NEXT FROM CUR INTO @idFuncao, @NOME
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END