create or alter procedure sp_oltp_meio_de_transporte(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_MEIO_DE_TRANSPORTE
	WHERE DATA_CARGA = @data_carga;

	INSERT INTO TB_AUX_MEIO_DE_TRANSPORTE
	SELECT 
		@data_carga, 
		COD_MEIO_DE_TRANSPORTE,
		NOME
	FROM 
		TB_MEIO_DE_TRANSPORTE;
end

-- ---------------------------------------

EXEC sp_oltp_meio_de_transporte '20240330'

SELECT * FROM TB_AUX_MEIO_DE_TRANSPORTE