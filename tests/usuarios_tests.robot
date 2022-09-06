# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
  
Documentation        Arquivo de testes para endpoint /usuarios
Resource    ../suporte/base.robot

Suite Setup    Criar Sessao    

#Sessão para a criação dos cenários

*** Test Cases ***

#Requisições Simples
Cenario 01: GET Todos os Usuarios 200
    [Tags]    BUSCAR TODOS USUARIOS 200
    GET Endpoint /usuarios
    Trazer Quantidade Usuarios
    Validar Status Code "200"
    Validar Razao "OK"

Cenário 02: GET Buscar Usuario por ID 200
    [Tags]    BUSCAR USUARIO POR ID 200
    Criar Usuario Dinamico Admin 
    GET Endpoint /usuarios ID
    Validar Status Code "200"

Cenário 03: GET Buscar Usuario por ID 400
    [Tags]    BUSCAR USUARIO POR ID 400
    GET Endpoint /usuarios ID 400
    Validar Message "Usuário não encontrado"
    Validar Status Code "400"
    Validar Razao "Bad Request"

Cenário 04: POST Cadastrar Usuario Massa Estatica 400
    [Tags]    CADASTRAR USUARIO ME 400
    Dados Usuario Estatico Email Cadastrado
    POST Endpoint /usuarios 
    Validar Status Code "400"

Cenário 05: POST Cadastrar Usuario Massa Estatica Inexistente
    [Tags]     USUARIO ME CADASTRO INEXISTENTE 400
    Dados Usuario Estatico Inexistente
    POST Endpoint /usuarios
    Validar Status Code "400"

Cenário 06: POST Cadastrar Usuario Massa Estatica Sem Senha
    [Tags]    USUARIO ME CADASTRO SEM SENHA 400
    Dados Usuario Estatico Sem Senha
    POST Endpoint /usuarios
    Validar Status Code "400"

# não tem rota e não tem  json-se validar mensagem não passa
Cenário 07: POST Cadastrar Usuario Massa Estatica Sem Admin
    [Tags]    USUARIO ME CADASTRO SEM ADMIN 400
    Dados Usuario Estatico Sem Admin
    POST Endpoint /usuarios
    Validar Status Code "400"

Cenario 08: POST Cadastrar Usuario Dinamico 201
    [Tags]    USUARIO CADASTRO DINAMICO 201
    Criar Usuario Dinamico Admin 
    POST Endpoint /usuarios
    Validar Status Code "201"
    DELETE Endpoint /usuarios
    Validar Status Code "200"
    Validar Razao "OK"
  
Cenário 09: PUT Alterar Usuario 200
    [Tags]    USUARIO ALTERADO 200
    Criar Usuario Dinamico Admin
    POST Endpoint /usuarios
    Validar Message "Cadastro realizado com sucesso"
    PUT Endpoint /usuarios 
    Validar Message "Registro alterado com sucesso"
    Validar Status Code "200"
    DELETE Endpoint /usuarios
    Validar Status Code "200"
    Validar Razao "OK"

#traz status code 405 e não 400
Cenário 10: PUT Cadastrar Usuario Massa Estatica 400
    [Tags]    CADASTRAR USUARIO ME 400
    Dados Usuario Estatico Email Cadastrado
    PUT Endpoint /usuarios 
    Validar Status Code "400"

Cenário 11: DELETE Usuario ID 200
    [Tags]    USUARIO DELETE 200
    Criar Usuario Dinamico Admin
    POST Endpoint /usuarios
    Validar Message "Cadastro realizado com sucesso" 
    DELETE Endpoint /usuarios
    Validar Status Code "200"
    Validar Razao "OK"

Cenário 10: DELETE Usuario ID 400
    [Tags]    USUARIO DELETE 400
    DELETE Endpoint /usuarios 400
    Validar Status Code "400"
    Validar Razao "Bad Request"
    Validar Message "Não é permitido excluir usuário com carrinho cadastrado"
