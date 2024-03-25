create or alter procedure sp_oltp_estado(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_Estado
	WHERE DATA_CARGA = @data_carga;

    INSERT INTO TB_AUX_Estado
	SELECT @data_carga, Estado
	FROM Local;
end
