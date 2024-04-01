import pandas as pd
from sqlalchemy import create_engine

class DataBase():

    def __init__(self) -> None:
        db_username = 'SA'
        db_password = 'Password123'
        db_host = 'localhost'
        db_port = '1433'
        db_name = 'DW_VIAGENS_MG'

        self.engine = create_engine(f"mssql+pyodbc://{db_username}:{db_password}@{db_host}/{db_name}?driver=ODBC+Driver+17+for+SQL+Server")
    

    def insert (self,insert_function,df: pd.DataFrame):   
        connection = self.engine.raw_connection()
        cursor = connection.cursor()

        try:
            data = df.to_dict(orient='records')
            insert_function(cursor,data)

        except Exception as e:
            print(f"Erro ao inserir dados: {e}")
            connection.rollback()

        else:
            connection.commit()

        finally:  
            cursor.close()     
            connection.close()


    def select (self,select_function) -> pd.DataFrame:   
        connection = self.engine.raw_connection()
        cursor = connection.cursor()

        try:
            data = select_function(cursor)
        except Exception as e:
            print(f"Erro ao selecionar os dados: {e}")
            connection.rollback()

        else:
            connection.commit()

        finally: 
            cursor.close()      
            connection.close()
            return data
   
   
    def update(self,update_function,data):
        connection = self.engine.raw_connection()
        cursor = connection.cursor()

        try:
            update_function(cursor,data)
            
        except Exception as e:
            print(f"Erro ao atulizar os dados: {e}")
            connection.rollback()

        else:
            connection.commit()

        finally:
            cursor.close()
            connection.close()


    def delete(self,delete_function,data):
        connection = self.engine.raw_connection()
        cursor = connection.cursor()

        try:
            delete_function(cursor,data)

        except Exception as e:
            print(f"Erro ao deletar dados: {e}")
            connection.rollback()

        else:
            connection.commit()

        finally:
            cursor.close()
            connection.close()