import requests as req

def Get_Endpoint_Usuarios_Testes_Vezes(vezes):
    lista = []
    for v in range(0, vezes):
        r = req.get("http://localhost:3000/usuarios ")
        para_json = r.json()
        lista.append(para_json)
        return lista