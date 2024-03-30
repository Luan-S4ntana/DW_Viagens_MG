create or alter procedure sp_oltp_funcionario(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_FUNCIONARIO
	WHERE DATA_CARGA = @data_carga;

	INSERT INTO TB_AUX_FUNCIONARIO
	SELECT 
		@data_carga, 
		COD_FUNCIONARIO,
		NOME + ' ' + SOBRENOME as NOME,
		CPF,
		COD_FUNCAO,
		COD_TIPO_FUNCIONARIO,
		COD_CARGO
	FROM 
		TB_FUNCIONARIO;
end

-- ---------------------------------------

EXEC sp_oltp_funcionario '20240330'

SELECT * FROM TB_AUX_FUNCIONARIO