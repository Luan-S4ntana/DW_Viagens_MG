create or alter procedure sp_oltp_tipo_funcionario(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_TIPO_FUNCIONARIO
	WHERE DATA_CARGA = @data_carga;

    INSERT INTO TB_AUX_TIPO_FUNCIONARIO
	SELECT 
		@data_carga, 
		COD_TIPO_FUNCIONARIO,
        NOME
	FROM 
		TB_TIPO_FUNCIONARIO;
end

-- ---------------------------------------

EXEC sp_oltp_tipo_funcionario '20240330'

SELECT * FROM TB_AUX_TIPO_FUNCIONARIO