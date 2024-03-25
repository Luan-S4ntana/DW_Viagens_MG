create or alter procedure sp_oltp_orgao_scdp(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_OrgaoSCDP
	WHERE DATA_CARGA = @data_carga;

	INSERT INTO TB_AUX_OrgaoSCDP
	SELECT @data_carga, OrgaoSCDP
	FROM Funcao;
end