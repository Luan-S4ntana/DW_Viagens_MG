create or alter procedure sp_oltp_cidade(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_CIDADE
	WHERE DATA_CARGA = @data_carga;

    INSERT INTO TB_AUX_CIDADE
	SELECT 
		@data_carga, 
		COD_CIDADE,
		CIDADE
	FROM 
		TB_CIDADE;
end

-- ---------------------------------------

EXEC sp_oltp_cidade '20240330'

SELECT * FROM TB_AUX_CIDADE