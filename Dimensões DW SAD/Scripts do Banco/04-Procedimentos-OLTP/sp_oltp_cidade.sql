create or alter procedure sp_oltp_cidade(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_Cidade
	WHERE DATA_CARGA = @data_carga;

    INSERT INTO TB_AUX_Cidade
	SELECT @data_carga, Cidade
	FROM Local;
end