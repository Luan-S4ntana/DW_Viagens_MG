create or alter procedure sp_oltp_funcao(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_Funcao
	WHERE DATA_CARGA = @data_carga;

	INSERT INTO TB_AUX_Funcao
	SELECT @data_carga, AnoExercicio, ID, Nome
	FROM Funcao;
end