import pandas as pd
from process import tabela_cargo, tipo_funcionario,funcionario,pais,estado,cidade,orgao_scdp, meio_de_transporte, motivo_viagem, tipo_viagem, diaria

def insert_cargo(cursor,data):
    cursor.executemany("""
        INSERT INTO TB_CARGO (COD_CARGO,NOME)
        VALUES (?,?)
    """,[(cargo['COD_CARGO'], cargo['NOME']) for cargo in data])
    return


def insert_tipo_funcionario(cursor,data):
    cursor.executemany("""
        INSERT INTO TB_TIPO_FUNCIONARIO (COD_TIPO_FUNCIONARIO,NOME)
        VALUES (?,?)
    """,[(tipo_fun['COD_TIPO_FUNCIONARIO'], tipo_fun['NOME']) for tipo_fun in data])
    return


def insert_funcionario(cursor,data):
    cursor.executemany("""
        INSERT INTO TB_FUNCIONARIO (COD_FUNCIONARIO,NOME,SOBRENOME,CPF,COD_TIPO_FUNCIONARIO,COD_CARGO)
        VALUES (?,?,?,?,?,?)
    """,[(funcionario['COD_FUNCIONARIO'], funcionario['NOME'], funcionario['SOBRENOME'], funcionario['CPF'], funcionario['COD_TIPO_FUNCIONARIO'],funcionario['COD_CARGO']) for funcionario in data])
    return


def insert_pais(cursor,data):
    cursor.executemany("""
        INSERT INTO TB_PAIS (COD_PAIS, PAIS)
        VALUES (?, ?)
    """,[(pais['COD_PAIS'], pais['PAIS']) for pais in data])
    return


def insert_estado(cursor,data):
    cursor.executemany("""
        INSERT INTO TB_ESTADO (COD_ESTADO,COD_PAIS,ESTADO,SIGLA)
        VALUES (?,?,?,?)
    """,[(estado['COD_ESTADO'], estado['COD_PAIS'], estado['ESTADO'], estado['SIGLA']) for estado in data])
    return


def insert_cidade(cursor,data):
    cursor.executemany("""
        INSERT INTO TB_CIDADE (COD_CIDADE,CIDADE,COD_ESTADO)
        VALUES (?,?,?)
    """,[(cidade['COD_CIDADE'], cidade['CIDADE'], cidade['COD_ESTADO']) for cidade in data])
    return


def insert_orgao_scdp(cursor,data):
    cursor.executemany("""
        INSERT INTO TB_ORGAO_SCDP (COD_ORGAO_SCDP,NOME)
        VALUES (?,?)
    """,[(orgao['COD_ORGAO_SCDP'], orgao['NOME']) for orgao in data])
    return


def insert_meio_de_transporte(cursor,data):
    cursor.executemany("""
        INSERT INTO TB_MEIO_DE_TRANSPORTE (COD_MEIO_DE_TRANSPORTE,NOME)
        VALUES (?,?)
    """,[(meio['COD_MEIO_DE_TRANSPORTE'], meio['NOME']) for meio in data]) 
    return


def insert_motivo_viagem(cursor,data):
    cursor.executemany("""
        INSERT INTO TB_MOTIVO_VIAGEM (COD_MOTIVO_VIAGEM,NOME)
        VALUES (?,?)
    """,[(motivo['COD_MOTIVO_VIAGEM'], motivo['NOME']) for motivo in data])
    return


def insert_tipo_viagem(cursor,data):
    cursor.executemany("""
        INSERT INTO TB_TIPO_DE_VIAGEM (COD_TIPO_DE_VIAGEM,NOME)
        VALUES (?,?)
    """,[(tipo['COD_TIPO_DE_VIAGEM'], tipo['NOME']) for tipo in data])
    return


def insert_diaria(cursor,data):
    cursor.executemany("""
        INSERT INTO TB_DIARIA (DATA_COMPRA,DATA_PARTIDA,DATA_CHEGADA,QUANTIDADE_DIARIAS,VALOR,COD_CIDADE_ORIGEM,COD_CIDADE_DESTINO,COD_FUNCIONARIO,COD_ORGAO_SCDP,COD_MEIO_DE_TRANSPORTE,COD_TIPO_DE_VIAGEM,COD_MOTIVO_VIAGEM)
        VALUES (?,?,?,?,?,?,?,?,?,?,?,?)
    """,[(diaria['DATA_COMPRA'], diaria['DATA_PARTIDA'],diaria['DATA_CHEGADA'], diaria['QUANTIDADE_DIARIAS'],diaria['VALOR'], diaria['COD_CIDADE_ORIGEM'],diaria['COD_CIDADE_DESTINO'], diaria['COD_FUNCIONARIO'],diaria['COD_ORGAO_SCDP'], diaria['COD_MEIO_DE_TRANSPORTE'],diaria['COD_TIPO_DE_VIAGEM'], diaria['COD_MOTIVO_VIAGEM']) for diaria in data])
    return