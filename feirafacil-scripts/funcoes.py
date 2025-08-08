"""
Autor - Ricardo Cassiano


Pacote de scripts - FeiraFácil

Scripts para:

> gerar relatórios personalizados
> fazer pequenas alterações no banco de dados


EM DESENSOLVIMENTO


"""

import sys
import os
import psycopg2

import time
from config import config
import logging

nome_script = os.path.basename(sys.argv[0])

logging.basicConfig(filename="feirafacil_scripts.log", level=logging.INFO,
                    format="%(asctime)s %(message)s", filemode="w")

logging.info("Script {} executado".format(nome_script))

data = time.strftime("%Y%m%d_%Hh%M")

params = config()

conn = psycopg2.connect(**params)


data = time.strftime("%Y%m%d_%Hh%M")


def alterar_situacao_item():
    cur = conn.cursor()
    print("\nScript para alterar a situacao do item\n\n")

    item = int(input("Digite o código do item: "))

    opcao = input("Deseja ativar ou excluir o item? Digite: \n1 - ATIVAR \n0 - EXCLUIR ")

    if (opcao == '1'):
        marcar = '1'
    elif (opcao == '0'):
        marcar = '0'
    else:
        print("Opção  errada\n")
        print("Você deve digitar 0 ou 1\n")
        print("Execute o script novamente!")
        exit()


    sql1="""
        update public.item
        set  situacao_id = %s
        where id = %s       
            """    
        

    cur.execute(sql1, (opcao, item))
    conn.commit()
    conn.close()


    print("\nPronto!! \nSituação do item alterada!!")

def relatorio_cupons():
    cur = conn.cursor()
    data = time.strftime("%Y%m%d_%Hh%M")

    dataInicial = input("Digite a data INICIAL - no formato AAAAMMDD exemplo - 2025-07-01:  ")

    dataFinal = input("Digite a data FINAL - no formato AAAAMMDD exemplo - 2025-07-31:  ")


    query2 = "select * from vw_compras where datacompra between '"+dataInicial+"' and '"+dataFinal+"'"


    cur = conn.cursor()

    outputquery = "COPY ({0}) TO STDOUT WITH CSV HEADER".format(query2)

    arquivocsv = "relatorio_compras_"+data+".csv"

    with open(arquivocsv, 'w') as f:
        cur.copy_expert(outputquery, f)

    conn.close()
