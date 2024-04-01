import pandas as pd

from db import DataBase


def main():
    fato_path = 'csv/ft_diarias.csv'
    fato = pd.read_csv(fato_path,sep=';',header=0)

    fato = clean_fact_tables(fato)

    fato = insert_states_names(fato)
    fato = insert_city_names(fato)

    cidades_table = create_citys_dataframe(fato)
    
    fato = fato.drop(['nome_estado_origem','nome_estado_destino','nome_cidade_origem','nome_cidade_destino'],axis=1)

    pessoas_table = create_pearson_dataframe(fato)

    voos_table = create_voo_table(fato)

    db = DataBase()

    #db.insert(insert_city_on_db,cidades_table)
    #db.insert(insert_person_on_db,pessoas_table)
    #db.insert(insert_voo_on_db,voos_table)

    passagem_table = get_voo_id(fato,db)
    print
    #db.insert(insert_passagens_on_db,passagem_table)



def extrair_nome_sobrenome(nome_completo):
    partes = nome_completo.split()
    return partes[0], partes[-1] if len(partes) > 1 else partes[0]


def create_pearson_dataframe(fato):
    pessoas_path = 'csv/dm_favorecido.csv'
    pessoas = pd.read_csv(pessoas_path,sep=';',header=0)

    #pega o nome da pessoa
    fato = pd.merge(fato, pessoas, left_on='id_favorecido', right_on='id_favorecido', how='left')

    #pego o 1º e o ultimo nome da pessoa
    fato[['nome', 'sobrenome']] = fato['nome_anonimizado'].apply(lambda x: pd.Series(extrair_nome_sobrenome(x)))

    #remove os caracteres especiais do cpf
    fato['nr_cpf_anonimizado'] = fato['nr_cpf_anonimizado'].str.replace('.', '', regex=False).str.replace('-', '', regex=False)

    return fato[['id_favorecido', 'nr_cpf_anonimizado', 'nome', 'sobrenome']].drop_duplicates().reset_index(drop=True)


def create_citys_dataframe(fato)-> pd.DataFrame:
    origem = fato[['id_cidade_origem', 'nome_estado_origem', 'nome_cidade_origem']].rename(
    columns={'id_cidade_origem': 'Id da cidade', 
             'nome_estado_origem': 'nome do estado', 
             'nome_cidade_origem': 'nome da cidade'}
    )

    destino = fato[['id_cidade_destino', 'nome_estado_destino', 'nome_cidade_destino']].rename(
        columns={'id_cidade_destino': 'Id da cidade', 
                'nome_estado_destino': 'nome do estado', 
                'nome_cidade_destino': 'nome da cidade'}
    )

    cidades = pd.concat([origem, destino])

    return cidades.drop_duplicates().reset_index(drop=True)


def clean_fact_tables(fato):
    fato = fato.query('id_pais_origem == 1')
    fato = fato.query('id_pais_destino == 1')
    fato = fato.query('id_meio_transporte == 1')
    fato = fato.query('vr_passagem > 0.0')

    return fato.drop(['id_tempo','id_cargo','id_funcao_scdp','id_orgao','id_pais_origem','id_pais_destino','id_documento_viagem','id_tipo_viagem','id_tipo_viajante','id_meio_transporte','id_motivo','ordem_trecho','ano_particao','qt_diaria','vr_diaria'],axis=1)


def insert_states_names(fato):
    estados_path = 'csv/dm_estado.csv'
    estados = pd.read_csv(estados_path,sep=';',header=0)

    #pega o nome do estado de origem
    fato = pd.merge(fato, estados, left_on='id_estado_origem', right_on='id_estado', how='left')
    fato.rename(columns={
        'nome_estado':'nome_estado_origem'
    },inplace=True)

    #Pega o nome do estado de destino
    fato = pd.merge(fato, estados, left_on='id_estado_destino', right_on='id_estado', how='left')
    fato.rename(columns={
        'nome_estado':'nome_estado_destino'
    },inplace=True)

    return fato.drop(['id_estado_x','id_estado_y','id_estado_origem','id_estado_destino'],axis=1)



def insert_city_names(fato):
    cidades_path = 'csv/dm_cidade.csv'
    cidades = pd.read_csv(cidades_path,sep=';',header=0)

    #pega o nome da cidade de origem
    fato = pd.merge(fato, cidades, left_on='id_cidade_origem', right_on='id_cidade', how='left')
    fato.rename(columns={
        'nome_cidade':'nome_cidade_origem'
    },inplace=True)

    #Pega o nome da cidade de destino
    fato = pd.merge(fato, cidades, left_on='id_cidade_destino', right_on='id_cidade', how='left')
    fato.rename(columns={
        'nome_cidade':'nome_cidade_destino'
    },inplace=True)
    return fato.drop(['id_cidade_x','id_cidade_y'],axis=1)


def insert_city_on_db(cursor,data: pd.DataFrame):
    cursor.executemany("""
            INSERT INTO Local 
            (id,cidade,UF) 
            VALUES 
            (%(Id da cidade)s, %(nome da cidade)s, %(nome do estado)s)
        """, data)
        

def insert_person_on_db(cursor,data: pd.DataFrame):
    cursor.executemany("""
            INSERT INTO Passageiro 
            (id,nome,sobrenome,cpf) 
            VALUES 
            (%(id_favorecido)s, %(nome)s, %(sobrenome)s, %(nr_cpf_anonimizado)s)
        """, data)
    

def create_voo_table(fato):
    df_novo = fato.drop(['vr_passagem','id_favorecido'], axis=1)
    df_novo = df_novo.drop_duplicates()
    return df_novo


def insert_voo_on_db(cursor,data: pd.DataFrame):
    cursor.executemany("""
            INSERT INTO Voo 
            (localOrigemId,localDestinoId,dataPartida,dataChegada) 
            VALUES 
            (%(id_cidade_origem)s, %(id_cidade_destino)s, %(dt_inicio_trecho)s, %(dt_fim_trecho)s)
        """, data)


def select_voo_table(cursor):
    cursor.execute("""
        SELECT 
            id,localOrigemId,localDestinoId,dataPartida,dataChegada 
        FROM
             Voo 
        """) 
    return pd.DataFrame(cursor.fetchall(),columns=['id', 'id_cidade_origem', 'id_cidade_destino', 'dt_inicio_trecho', 'dt_fim_trecho'])
 

def insert_passagens_on_db(cursor,data: pd.DataFrame):
    cursor.executemany("""
            INSERT INTO 
                Passagem (Voo_id,Passageiro_id,preço,dataCompra) 
            VALUES 
                (%(id)s, %(id_favorecido)s, %(vr_passagem)s, %(dataCompra)s)
        """, data)

def get_voo_id(fato,db):
    voo_table = db.select(select_voo_table)

    fato['dt_inicio_trecho'] = pd.to_datetime(fato['dt_inicio_trecho'])
    fato['dt_fim_trecho'] = pd.to_datetime(fato['dt_fim_trecho'])
    voo_table['dt_inicio_trecho'] = pd.to_datetime(voo_table['dt_inicio_trecho'])
    voo_table['dt_fim_trecho'] = pd.to_datetime(voo_table['dt_fim_trecho'])

    fato = pd.merge(fato, voo_table, 
        on=['id_cidade_origem', 'id_cidade_destino', 'dt_inicio_trecho', 'dt_fim_trecho'],
        how='left')
    
    fato['dt_inicio_trecho'] = fato['dt_inicio_trecho'] - pd.to_timedelta(5, unit='d')

    fato = fato.drop(['id_cidade_origem','id_cidade_destino','dt_fim_trecho'],axis=1)
    fato.rename(columns={
      'dt_inicio_trecho':'dataCompra'  
    },inplace=True)
    return fato
    

if __name__ == '__main__':
    main()
