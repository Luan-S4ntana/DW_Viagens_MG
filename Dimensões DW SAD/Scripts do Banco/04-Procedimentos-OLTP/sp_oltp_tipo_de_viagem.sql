create or alter procedure sp_oltp_tipo_de_viagem(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_TIPO_DE_VIAGEM
	WHERE DATA_CARGA = @data_carga;

    INSERT INTO TB_AUX_TIPO_DE_VIAGEM
	SELECT 
		@data_carga, 
		COD_TIPO_DE_VIAGEM,
    	NOME
	FROM 
		TB_TIPO_DE_VIAGEM;
end


-- ---------------------------------------

EXEC sp_oltp_tipo_de_viagem '20240330'

SELECT * FROM TB_AUX_TIPO_DE_VIAGEM