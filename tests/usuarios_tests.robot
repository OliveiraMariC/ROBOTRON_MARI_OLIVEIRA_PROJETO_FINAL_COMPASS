# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
  
Documentation        Arquivo de testes para endpoint /usuarios
Resource    ../suporte/base.robot

Suite Setup    Criar Sessao    

#Sessão para a criação dos cenários

*** Test Cases ***

#Requisições Simples
Cenario 01: GET Todos os Usuarios 200
    [Tags]    GETALL
    GET Endpoint /usuarios
    Trazer Quantidade Usuarios
    Validar Status Code "200"
    Validar Razao "OK"

Cenario 02: POST Cadastrar Usuarios 201
    [Tags]    POST1        
    Trazer Quantidade Usuarios
    Validar Ter Criado o Usuario
    Validar Status Code "201"
    Validar Razao "Created"
    Trazer Quantidade Usuarios

Cenario 03: PUT Editar Usuario 200
    [Tags]    PUT1
    PUT Endpoint /usuarios
    Validar Status Code "200"
    Trazer Quantidade Usuarios

Cenario 04: DELETE Excluir Usuario 200
    [Tags]    DELUSER
    Cadastrar Usuario e Aramazenar ID
    DELETE Endpoint /usuarios
    Validar Status Code "200"
Cenario 05: POST Usuario Estatico 201
    [Tags]    POSTUSER_STATIC 
    Cadastrar Static Usuario Valido e Aramazenar ID
    Validar Ter Criado o Usuario   
    Validar Status Code "201"
Cenario 06: POST Usuario Estatico 400
    [Tags]    POSTUSER_STATIC 
    Cadastrar Static Usuario Valido e Aramazenar ID
    Validar Status Code "400"
Apagar: DELETE Endpoint /usuarios para apagar  
    [Tags]    APAGAR
    Apagar Usuario