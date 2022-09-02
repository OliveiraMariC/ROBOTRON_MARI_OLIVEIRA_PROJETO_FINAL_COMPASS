import requests as req
from faker import Faker
def Post_Endpoint_Usuarios_Testes_Vezes(vezes):
    lista = []
    for v in range(0, vezes):
        r = req.get("http://localhost:3000/usuarios ")
        para_json = r.json()
        lista.append(para_json)
        return lista

def Buscar_Quantidade_Usuarios_Cadastrado():
    r = req.get("http://localhost:3000/usuarios/")
    response_js = r.json()  
    return response_js["quantidade"]

def Cadastrar_Usuario_Dinamicos_Admin(admin):
    fake = Faker()
    nome = fake.name()
    email = fake.email()
    senha = "senha123"
    payload = {"nome": nome, "email": email, "password": senha, "administrador":admin}
    return payload

def Buscar_Quantidade_Produtos_Cadastrados():
    r = req.get("http://localhost:3000/produtos/")
    response_js = r.json()  
    return response_js["quantidade"]



