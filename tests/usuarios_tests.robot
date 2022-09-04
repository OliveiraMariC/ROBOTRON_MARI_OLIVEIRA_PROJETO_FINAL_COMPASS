# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
  
Documentation        Arquivo de testes para endpoint /usuarios
Resource    ../suporte/base.robot

Suite Setup    Criar Sessao    

#Sessão para a criação dos cenários

*** Test Cases ***

#Requisições Simples
Cenario 01: GET Todos os Usuarios 200
    [Tags]    GET_ALL
    GET Endpoint /usuarios
    Trazer Quantidade Usuarios
    Validar Status Code "200"
    Validar Razao "OK"
Cenário 02: GET Buscar Usuario por ID 400
    [Tags]    GET_USER_SEM_ID
    GET Endpoint /usuarios ID
    Validar Status Code "400"
Cenário 03: POST Cadastrar Usuario Massa Estatica 201
    [Tags]    POST_USER_201
    Dados Usuario Estatico Valido
    POST Endpoint /usuarios 
    Validar Status Code "201"

Cenário 04: POST Cadastrar Usuario Massa Estatica 400
    [Tags]    POST_USER_400
    Dados Usuario Estatico Email Cadastrado
    POST Endpoint /usuarios 
    Validar Status Code "400"

Cenário 05: POST Cadastrar Usuario Massa Estatica Inexistente
    [Tags]    POST_USER_INEXISTENTE
    Dados Usuario Estatico Inexistente
    POST Endpoint /usuarios
    Validar Status Code "400"

Cenário 06: POST Cadastrar Usuario Massa Estatica Sem Senha
    [Tags]    POST_USER_SEM_SENHA
    Dados Usuario Estatico Sem Senha
    POST Endpoint /usuarios
    Validar Status Code "400"
Cenário 07: POST Cadastrar Usuario Massa Estatica Sem Admin
    [Tags]    POST_USER__SEM_ADMIN
    Dados Usuario Estatico Sem Admin
    POST Endpoint /usuarios
    Validar Status Code "400"
Cenário 08: Ciar Usuario Dinamico 201
    [Tags]    deluser
    Criar Usuario Dinamico Admin
    POST Endpoint /usuarios
    Validar Ter Criado o Usuario
    Validar Status Code "201"
    DELETE Endpoint /usuarios
Cenario 03:Criar Usuario Dinamico 201
    [Tags]    POSTUSERDINAMICO
    Criar Usuario Dinamico Admin 
    POST Endpoint /usuarios
    Validar Status Code "201"
    Validar Ter Criado o Usuario
    DELETE Endpoint /usuarios   



apagar: delete endipoint usuarios
    delete endpoint usuarios