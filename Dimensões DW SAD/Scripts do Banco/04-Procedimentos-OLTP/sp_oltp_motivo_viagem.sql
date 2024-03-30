create or alter procedure sp_oltp_motivo_viagem(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_MOTIVO_VIAGEM
	WHERE DATA_CARGA = @data_carga;

	INSERT INTO TB_AUX_MOTIVO_VIAGEM
	SELECT
		@data_carga, 
		COD_MOTIVO_VIAGEM,
    	NOME
	FROM 
		TB_MOTIVO_VIAGEM;
end

-- ---------------------------------------

EXEC sp_oltp_motivo_viagem '20240330'

SELECT * FROM TB_AUX_MOTIVO_VIAGEM