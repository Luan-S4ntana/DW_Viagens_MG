CREATE OR ALTER PROCEDURE sp_DimFuncao(@data_carga DATETIME)
AS
BEGIN
    DECLARE @NOME VARCHAR(100)
	DECLARE @idFuncao INT 
    DECLARE @anoExercicio INT 
    DECLARE @cdFuncao INT 
	DECLARE @nomeSCDP varchar(11)
    DECLARE CUR CURSOR FOR
    SELECT anoExercicio, cdFuncao, nome, nomeSCDP  FROM TB_AUX_Funcao WHERE DATA_CARGA = @data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @anoExercicio,@cdFuncao, @nome, @nomeSCDP

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DimFuncao WHERE nome = @NOME)
        BEGIN
            INSERT INTO DimFuncao (anoExercicio,cdFuncao, nome, nomeSCDP)
            VALUES (@anoExercicio,@cdFuncao, @nome, @nomeSCDP)
        END
        FETCH NEXT FROM CUR INTO @anoExercicio,@cdFuncao, @nome, @nomeSCDP 
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END