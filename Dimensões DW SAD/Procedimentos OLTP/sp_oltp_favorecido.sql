create or alter procedure sp_oltp_favorecido(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_FavorecidoSCDP
	WHERE DATA_CARGA = @data_carga;

	INSERT INTO TB_AUX_FavorecidoSCDP
	SELECT @data_carga, IdFuncao, Nome
	FROM Funcionario;
end