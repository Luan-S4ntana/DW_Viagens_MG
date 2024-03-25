create or alter procedure sp_oltp_pais(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_Pais
	WHERE DATA_CARGA = @data_carga;

    INSERT INTO TB_AUX_Pais
	SELECT @data_carga, Pais
	FROM Local;
end
