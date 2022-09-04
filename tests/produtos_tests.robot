# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation      Arquivo de Testes Endpoint /produtos
Resource    ../suporte/base.robot

Suite Setup    Criar Sessao    

#Sessão para a criação dos cenários
*** Test Cases ***
Cenario 01: GET Listar Todos os Produtos 200
    [Tags]    GETALLPROD    
    GET Endpoint /produtos
    Validar Quantidade Produtos
    Validar Status Code "200"
    Validar Razao "OK"
Cenário 02: GET Produto ID
    [Tags]        GETIDPROID
    GET Endpoint /produtos por ID
    Validar Status Code "200"
Cenário 03: GET Produto Sem ID 400
    [Tags]    GETPRO_SEM_ID
    GET Endpoint /produtos sem ID 400
    Validar Status Code "400"
Cenario 04: POST Cadastrar Produto 201
    [Tags]        POSTCADPROD1
    Fazer Login e Armazenar Token
    POST Endpoint /produtos 201
    Validar Status Code "201"
Cenario 05: POST Cadastrar Produto 400
    [Tags]        POSTPRD400
    Fazer Login e Armazenar Token
    POST Endpoint /produtos 400
    Validar Status Code "400"
Cenário 06: POST Cadastrar Produto 401
    [Tags]    POSTPROD401
    POST Endpoint /produtos 401
    Validar Razao "Unauthorized"
    Validar Status Code "401"

Cenario 07: PUT Alterar Produto 200
    [Tags]        PUTPRO1
    Fazer Login e armazenar Token
    PUT Endpoint /produtos
    Validar Status Code "200"
    Validar Ter Alterado o Produto
    
Cenario 08: DELETE Excluir Produto 200
    [Tags]        DELLPROD1
    Fazer Login e Armazenar Token
    Criar Produto e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"
Apagar produto
    [Tags]    APAGARPROD
    Apagar Produto