import pandas as pd
import numpy as np

FILE_PATH = '../../arquivos_csv/'

def tabela_cargo():
    csv = pd.read_csv(FILE_PATH+'cargo.csv',delimiter=';')

    csv.rename(columns={
        'id_cargo': 'COD_CARGO',
        'nome': 'NOME'
    },inplace=True)

    return csv


def tipo_funcionario():
    csv = pd.read_csv(FILE_PATH+'tipo_viajante.csv',delimiter=';')

    csv.rename(columns={
        'id_tipo_viajante': 'COD_TIPO_FUNCIONARIO',
        'nome': 'NOME'
    },inplace=True)

    return csv   


def extrair_nome_sobrenome(nome_completo):
    partes = nome_completo.split()
    return partes[0], partes[-1] if len(partes) > 1 else partes[0]


def funcionario():
    csv_funcionario = pd.read_csv(FILE_PATH+'funcionario.csv',delimiter=';')
    csv_funcionario[['NOME', 'SOBRENOME']] = csv_funcionario['nome_anonimizado'].apply(lambda x: pd.Series(extrair_nome_sobrenome(x)))
    csv_funcionario = csv_funcionario.drop(['masp','nome_anonimizado'],axis=1)
    csv_funcionario['nr_cpf_anonimizado'] = csv_funcionario['nr_cpf_anonimizado'].str.replace('.', '', regex=False).str.replace('-', '', regex=False)

    csv_fato = pd.read_csv(FILE_PATH+'passagem.csv',delimiter=';')
    csv_fato = csv_fato.drop(['id_tempo','id_funcao_scdp','id_orgao','id_pais_origem','id_estado_origem','id_cidade_origem','id_pais_destino','id_estado_destino','id_cidade_destino','id_documento_viagem','id_tipo_viagem','id_meio_transporte','id_motivo','ordem_trecho','ano_particao','dt_inicio_trecho','dt_fim_trecho','qt_diaria','vr_diaria','vr_passagem'],axis=1)

    fato = pd.merge(csv_fato, csv_funcionario, left_on='id_favorecido', right_on='id_favorecido', how='left')

    fato.rename(columns={
        'id_favorecido': 'COD_FUNCIONARIO',
        'nr_cpf_anonimizado': 'CPF',
        'id_tipo_viajante': 'COD_TIPO_FUNCIONARIO',
        'id_cargo': 'COD_CARGO'
    }, inplace=True)

    fato['COD_FUNCIONARIO'] = fato['COD_FUNCIONARIO'].drop_duplicates().dropna()
    fato = fato.dropna().reset_index(drop=True)

    return fato


def pais():
    csv = pd.read_csv(FILE_PATH+'pais.csv',delimiter=';')

    csv.rename(columns={
        'id_pais': 'COD_PAIS',
        'nome': 'PAIS'
    },inplace=True)

    return csv  


def estado():
    csv_fato = pd.read_csv(FILE_PATH+'passagem.csv',delimiter=';')

    estados_de_origem = pd.DataFrame({
        'id_estado': csv_fato['id_estado_origem'],
        'id_pais': csv_fato['id_pais_origem']
    })

    estados_de_destino = pd.DataFrame({
        'id_estado': csv_fato['id_estado_destino'],
        'id_pais': csv_fato['id_pais_destino']
    })

    estados_fato = pd.concat([estados_de_origem,estados_de_destino],ignore_index=True).dropna().drop_duplicates()
    estados_fato['id_estado'] = estados_fato['id_estado'].dropna()
    estados_fato = estados_fato.reset_index(drop=True)

    csv_estado = pd.read_csv(FILE_PATH + 'estado.csv',delimiter=',')
    
    estados = pd.merge(estados_fato,csv_estado, left_on='id_estado', right_on='id_estado', how='left')
    
    duplicados = estados['id_estado'].duplicated(keep=False)

   
    max_id = estados['id_estado'].max()
    novos_ids = (max_id + 1) + np.arange(estados[duplicados].shape[0])

    estados.loc[duplicados, 'id_estado'] = novos_ids

    estados.rename(columns={
        'id_estado': 'COD_ESTADO', 
        'id_pais': 'COD_PAIS',              
        'nome': 'ESTADO', 
        'sigla': 'SIGLA',
    },inplace=True)
    return estados


def cidade():
    csv_fato = pd.read_csv(FILE_PATH+'passagem.csv',delimiter=';')
    estados = estado()
    cidades_de_origem = pd.DataFrame({
        'id_cidade' : csv_fato['id_cidade_origem'],
        'COD_ESTADO': csv_fato['id_estado_origem'],
        'COD_PAIS': csv_fato['id_pais_origem']
    })

    cidades_de_destino = pd.DataFrame({
        'id_cidade' : csv_fato['id_cidade_destino'],
        'COD_ESTADO': csv_fato['id_estado_destino'],
        'COD_PAIS': csv_fato['id_pais_destino']
    })

    cidades_fato = pd.concat([cidades_de_origem,cidades_de_destino],ignore_index=True).dropna().drop_duplicates()
    cidades_fato = cidades_fato.reset_index(drop=True)

    mapeamento_pais_estado = estados[['COD_PAIS', 'COD_ESTADO']].drop_duplicates().set_index('COD_PAIS')

    for index, row in cidades_fato.iterrows():
        if row['COD_ESTADO'] == 1:
            id_pais_atual = row['COD_PAIS']
            novo_id_estado = mapeamento_pais_estado.loc[id_pais_atual, 'COD_ESTADO']
            cidades_fato.at[index, 'COD_ESTADO'] = novo_id_estado

    csv_cidade = pd.read_csv(FILE_PATH + 'cidade.csv', delimiter=';')

    cidades = pd.merge(csv_cidade,cidades_fato,left_on='id_cidade', right_on='id_cidade', how='left')
    cidades = cidades.dropna()
    cidades = cidades.drop(['COD_PAIS'],axis=1)

    cidades.rename(columns={
        'id_cidade': 'COD_CIDADE',
        'nome': 'CIDADE',
        'id_estado': 'COD_ESTADO'
    }, inplace=True)

    return cidades


def orgao_scdp():
    csv_scdp = pd.read_csv(FILE_PATH + 'orgao_scdp.csv',delimiter=';')
    csv_scdp = csv_scdp.drop(['id_orgao'],axis=1)

    csv_scdp.rename(columns={
        'cd_orgao':'COD_ORGAO_SCDP',
        'nome': 'NOME',
    },inplace=True)

    csv_scdp['COD_ORGAO_SCDP'] = csv_scdp['COD_ORGAO_SCDP'].drop_duplicates()
    csv_scdp = csv_scdp.dropna().reset_index(drop=True)
    
    return csv_scdp


def meio_de_transporte():
    csv_transporte = pd.read_csv(FILE_PATH + 'meio_transporte.csv',delimiter=';')

    csv_transporte.rename(columns={
        'id_meio_transporte': 'COD_MEIO_DE_TRANSPORTE',
        'nome': 'NOME'
    },inplace=True)

    return csv_transporte


def motivo_viagem():
    csv_motivo = pd.read_csv(FILE_PATH + 'motivo_viagem.csv',delimiter=';')

    csv_motivo.rename(columns={
        'id_motivo': 'COD_MOTIVO_VIAGEM',
        'nome': 'NOME'
    },inplace=True)

    return csv_motivo


def tipo_viagem():
    csv_tipo = pd.read_csv(FILE_PATH + 'tipo_viagem.csv',delimiter=';')

    csv_tipo.rename(columns={
        'id_tipo_viagem': 'COD_TIPO_DE_VIAGEM',
        'nome': 'NOME'
    },inplace=True)

    return csv_tipo


def diaria():
    csv_diaria = pd.read_csv(FILE_PATH+'passagem.csv',delimiter=';')
    csv_diaria = csv_diaria.drop(['id_tempo','id_cargo','id_funcao_scdp','id_pais_origem','id_estado_origem','id_pais_destino','id_estado_destino','id_documento_viagem','ordem_trecho','ano_particao','vr_passagem'],axis=1)
    
    csv_orgao = pd.read_csv(FILE_PATH + 'orgao_scdp.csv',delimiter=';')
    csv_orgao = csv_orgao.drop(['nome'],axis=1)

    csv_orgao.rename(columns={
        'cd_orgao':'COD_ORGAO_SCDP'
    },inplace=True)
    
    diaria_operacional = pd.merge(csv_diaria, csv_orgao, left_on='id_orgao', right_on='id_orgao', how='left')
    diaria_operacional = diaria_operacional.drop(['id_orgao','id_tipo_viajante'],axis=1)

    diaria_operacional['dt_inicio_trecho'] = pd.to_datetime(diaria_operacional['dt_inicio_trecho'])
    diaria_operacional['dt_fim_trecho'] = pd.to_datetime(diaria_operacional['dt_fim_trecho'])

    diaria_operacional['DATA_COMPRA'] = diaria_operacional['dt_inicio_trecho'] - pd.to_timedelta(5, unit='d')

    diaria_operacional.rename(columns={
        'id_favorecido': 'COD_FUNCIONARIO', 
        'id_cidade_origem': 'COD_CIDADE_ORIGEM', 
        'id_cidade_destino': 'COD_CIDADE_DESTINO',
        'id_tipo_viagem': 'COD_TIPO_DE_VIAGEM', 
        'id_meio_transporte': 'COD_MEIO_DE_TRANSPORTE', 
        'id_motivo':'COD_MOTIVO_VIAGEM',
        'dt_inicio_trecho': 'DATA_PARTIDA', 
        'dt_fim_trecho': 'DATA_CHEGADA', 
        'qt_diaria': 'QUANTIDADE_DIARIAS', 
        'vr_diaria': 'VALOR'
    },inplace=True)
    return diaria_operacional