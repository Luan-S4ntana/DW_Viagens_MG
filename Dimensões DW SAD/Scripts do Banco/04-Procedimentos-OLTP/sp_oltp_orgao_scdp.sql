create or alter procedure sp_oltp_orgao_scdp(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_ORGAO_SCDP
	WHERE DATA_CARGA = @data_carga;

	INSERT INTO TB_AUX_ORGAO_SCDP
	SELECT
		@data_carga, 
		COD_ORGAO_SCDP,
		NOME
	FROM 
		TB_ORGAO_SCDP;
end

-- ---------------------------------------

EXEC sp_oltp_orgao_scdp '20240330'

SELECT * FROM TB_AUX_ORGAO_SCDP