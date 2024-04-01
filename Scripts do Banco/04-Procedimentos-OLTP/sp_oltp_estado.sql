create or alter procedure sp_oltp_estado(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_ESTADO
	WHERE DATA_CARGA = @data_carga;

    INSERT INTO TB_AUX_ESTADO
	SELECT 
		@data_carga, 
		COD_ESTADO,
		ESTADO,
		SIGLA
	FROM 
		TB_ESTADO;
end

-- ---------------------------------------

EXEC sp_oltp_estado '20240330'

SELECT * FROM TB_AUX_ESTADO