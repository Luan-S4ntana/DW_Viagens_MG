
CREATE OR ALTER PROCEDURE sp_dim_OrgaoSCDP(@data_carga DATETIME)
AS
BEGIN
	DECLARE @cdOrgaoSCDP INT
    DECLARE @NOME VARCHAR(200)

    DECLARE CUR CURSOR FOR
    SELECT cdOrgaoSCDP ,nome FROM TB_AUX_OrgaoSCDP WHERE DATA_CARGA = @data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @cdOrgaoSCDP, @NOME

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DimOrgaoSCDP WHERE NOME = @NOME)
        BEGIN
            INSERT INTO DimOrgaoSCDP (cdOrgaoSCDP,nome)
            VALUES (@cdOrgaoSCDP, @NOME)
        END
        FETCH NEXT FROM CUR INTO @cdFonte, @NOME
    END

    CLOSE CUR;
    DEALLOCATE CUR;

END