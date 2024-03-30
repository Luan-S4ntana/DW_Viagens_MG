create or alter procedure sp_oltp_funcao(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_FUNCAO
	WHERE DATA_CARGA = @data_carga;

	INSERT INTO TB_AUX_FUNCAO
	SELECT 
		@data_carga, 
		COD_FUNCAO,
		ANO_EXERCICIO,
		NOME
	FROM 
		TB_FUNCAO;
end

-- ---------------------------------------

EXEC sp_oltp_funcao '20240330'

SELECT * FROM TB_AUX_FUNCAO