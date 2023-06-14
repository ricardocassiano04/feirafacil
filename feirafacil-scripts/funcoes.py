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


def alterar_flag_pesavel_produto():
    cur = conn.cursor()
    print("\nScript para alterar a flag pesavel do produto\n\n")

    item = int(input("Digite o código do produto: "))

    flag = input("É para alterar para marcar ou desmarcar a flag pesavel? Digite: \n1 - marcar \n0 - desmarcar ")

    if (flag == '1'):
        marcar = 't'
    elif (flag == '0'):
        marcar = 'f'
    else:
        print("Opção  errada\n")
        print("Você deve digitar 0 ou 1\n")
        print("Execute o script novamente!")
        exit()


    sql1="""
        update public.produto
        set  pesavel = %s
        where id = %s       
            """    
        

    cur.execute(sql1, (flag, item))
    conn.commit()
    conn.close()


    print("\nPronto!! \nFlag alterada!!")

def planilha_cupons():
    cur = conn.cursor()
    data = time.strftime("%Y%m%d_%Hh%M")

    dataInicial = input("Digite a data INICIAL - no formato AAAAMMDD exemplo - 2023-03-01:  ")

    dataFinal = input("Digite a data FINAL - no formato AAAAMMDD exemplo - 2023-03-31:  ")


    query2 = "select * from vw_cupons where dataemissao between '"+dataInicial+"' and '"+dataFinal+"'"


    cur = conn.cursor()

    outputquery = "COPY ({0}) TO STDOUT WITH CSV HEADER".format(query2)

    arquivocsv = "cupons_"+data+".csv"

    with open(arquivocsv, 'w') as f:
        cur.copy_expert(outputquery, f)

    conn.close()
