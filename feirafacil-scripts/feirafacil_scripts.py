'''

Autor - Ricardo Cassiano


Pacote de scripts - FeiraFácil

Scripts para:

> gerar relatórios personalizados
> fazer pequenas alterações no banco de dados

EM DESENVOLVIMENTO

'''

from funcoes import *


opcoes_menu = {
    1: 'Produto - Alterar flag pesável',
    2: 'Relatório - Planilha de Cupons',   
    3: 'Exit'
}

def exibir_menu():
    print('\n\n*************************************************\n')
    print('*****  Pacote de scripts - FeiraFácil  ******')
    print('\n*************************************************\n\n')
    for chave in opcoes_menu.keys():
        print (chave, '--', opcoes_menu[chave] )

def opcao1_alterar_flag_pesavel_produto():
     print("Escolhida a opção 1: ", opcoes_menu[1])
     alterar_flag_pesavel_produto()

def opcao2_planilha_cupons():
     print("Escolhida a opção 2: ", opcoes_menu[2])
     planilha_cupons()



if __name__=='__main__':
    while(True):
        exibir_menu()       
        option = ''
        try:
            option = int(input('\nDigite o número da opção desejada: '))
        except:
            print('Valor inválido. Digite um número entre 1 e',len(opcoes_menu))
        
        if option == 1:
           opcao1_alterar_flag_pesavel_produto()
        elif option == 2:
            opcao2_planilha_cupons()      
        elif option == 3:
            print('Saindo do programa. Até mais!!')
            exit()
        else:
            print('\nOpção inválida. Digite um número entre 1 e',len(opcoes_menu))