create or alter procedure sp_oltp_diaria(@data_carga datetime)
as
begin
    DELETE FROM TB_AUX_DIARIA
	WHERE DATA_CARGA = @data_carga;

    INSERT INTO TB_AUX_DIARIA
	SELECT 
		@data_carga, 
		COD_PASSAGEM,
		DATA_COMPRA,
		DATA_PARTIDA,
		DATA_CHEGADA,
		QUANTIDADE_DIARIAS,
		VALOR,
		COD_LOCAL_ORIGEM,
		COD_LOCAL_DESTINO,
		COD_FUNCIONARIO,
		COD_ORGAO_SCDP,
		COD_MEIO_DE_TRANSPORTE,
		COD_TPO_DE_VIAGEM,
		COD_MOTIVO_VIAGEM
	FROM 
		TB_PASSAGEM;
end


-- ---------------------------------------

EXEC sp_oltp_diaria '20240330'

SELECT * FROM TB_AUX_DIARIA