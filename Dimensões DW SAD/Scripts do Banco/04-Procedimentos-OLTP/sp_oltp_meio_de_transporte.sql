create or alter procedure sp_oltp_meio_de_transporte(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_MeioTransporte
	WHERE DATA_CARGA = @data_carga;

	INSERT INTO TB_AUX_MeioTransporte
	SELECT @data_carga, MeioDeTransporte
	FROM Passagem;
end