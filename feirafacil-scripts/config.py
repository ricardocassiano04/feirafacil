from configparser import ConfigParser


def config(filename='.conexao.ini', section='postgresql'):
   teste = ConfigParser()
   teste.read(filename)
   banco = {}
   if teste.has_section(section):
      parametros = teste.items(section)
      for parametro in parametros:
         banco[parametro[0]] = parametro[1]
   else:
     raise Exception('Secao {0} nao encontrada no arquivo {1} '.format(section, filename))
   return banco
