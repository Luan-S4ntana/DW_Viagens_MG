create or alter procedure sp_oltp_cargo(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_CARGO
	WHERE DATA_CARGA = @data_carga;

    INSERT INTO TB_AUX_CARGO
	SELECT 
		@data_carga, 
		COD_CARGO,
        NOME
	FROM 
		TB_CARGO;
end

-- ---------------------------------------

EXEC sp_oltp_cargo '20240330'

SELECT * FROM TB_AUX_CARGO