create or alter procedure sp_oltp_tipo_funcionario(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_TPO_FUNCIONARIO
	WHERE DATA_CARGA = @data_carga;

    INSERT INTO TB_AUX_TPO_FUNCIONARIO
	SELECT 
		@data_carga, 
		COD_TPO_DE_VIAGEM,
        NOME
	FROM 
		TB_TPO_FUNCIONARIO;
end

-- ---------------------------------------

EXEC sp_oltp_tipo_funcionario '20240330'

SELECT * FROM TB_AUX_TPO_FUNCIONARIO