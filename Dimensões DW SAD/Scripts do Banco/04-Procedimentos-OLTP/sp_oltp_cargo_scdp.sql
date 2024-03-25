create or alter procedure sp_oltp_cargo_scdp(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_DimCargoSCDP
	WHERE DATA_CARGA = @data_carga;

	INSERT INTO TB_AUX_DimCargoSCDP
	SELECT @data_carga, NomeSCDP
	FROM Funcao;
end