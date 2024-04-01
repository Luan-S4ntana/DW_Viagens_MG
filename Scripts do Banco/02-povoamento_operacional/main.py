from querys import insert_cargo, insert_tipo_funcionario, insert_funcionario, insert_pais, insert_estado, insert_cidade, insert_orgao_scdp, insert_meio_de_transporte, insert_motivo_viagem, insert_tipo_viagem, insert_diaria
from process import tabela_cargo, tipo_funcionario,funcionario,pais,estado,cidade,orgao_scdp, meio_de_transporte, motivo_viagem, tipo_viagem, diaria
from db import DataBase
 

def main():
    db = DataBase()

    #db.insert(insert_pais,pais())
    #db.insert(insert_estado,estado())
    #db.insert(insert_cidade,cidade())

    #db.insert(insert_cargo,tabela_cargo())
    #db.insert(insert_tipo_funcionario,tipo_funcionario())
    #db.insert(insert_funcionario,funcionario())

    #db.insert(insert_orgao_scdp,orgao_scdp())

    #db.insert(insert_meio_de_transporte,meio_de_transporte())

    #db.insert(insert_motivo_viagem,motivo_viagem())

    #db.insert(insert_tipo_viagem,tipo_viagem())

    db.insert(insert_diaria,diaria())

if __name__ == '__main__':
    main()


