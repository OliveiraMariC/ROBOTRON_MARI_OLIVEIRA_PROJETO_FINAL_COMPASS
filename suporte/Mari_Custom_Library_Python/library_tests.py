import requests as req
import hashlib
import json
import FakerLibrary
def Buscar_Qantidade_Usuarios_Cadastrados():
    r = req.get("http://localhost:3000/usuarios ")
    para_json = r.json()
    return para_json["nome"]

def Buscar_Quantidade_Produtos_Cadastrados():
    r = req.get("http://localhost:3000/produtos/")
    response_js = r.json()  
    return response_js["quantidade"]
    

def gerar_hash_dict(conteudo):

    string_var = json.dumps(conteudo)
    hash_conteudo = hashlib.sha256(str.encode(string_var)).hexdigest()
    print("Conteúdo: {}".format(conteudo))
    print("Hash gerado: {}".format(hash_conteudo))

    return hash_conteudo

# Referência:
# Curso Automação de Testes com Robot Framework - Avançado da Mayara "May" Fernandes
# https://www.udemy.com/course/automacao-de-testes-com-robot-framework-avancado




