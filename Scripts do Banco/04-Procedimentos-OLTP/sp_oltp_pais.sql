create or alter procedure sp_oltp_pais(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_PAIS
	WHERE DATA_CARGA = @data_carga;

    INSERT INTO TB_AUX_Pais
	SELECT 
		@data_carga, 
		COD_PAIS,
		PAIS
	FROM 
		TB_PAIS;
end

-- ---------------------------------------

EXEC sp_oltp_pais '20240330'

SELECT * FROM TB_AUX_PAIS