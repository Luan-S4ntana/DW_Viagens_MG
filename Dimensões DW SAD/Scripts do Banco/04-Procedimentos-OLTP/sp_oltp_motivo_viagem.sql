create or alter procedure sp_oltp_motivo_viagem(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_MotivoViagem
	WHERE DATA_CARGA = @data_carga;

	INSERT INTO TB_AUX_MotivoViagem
	SELECT @data_carga, MotivoDaViagem
	FROM Passagem;
end