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
Cenario 02: POST Cadastrar Produto 201
    [Tags]        POSTCADPROD1
    Fazer Login e Armazenar Token
    POST Endpoint /produtos
    Validar Status Code "201"
Cenario 03: DELETE Excluir Produto 200
    [Tags]        DELLPROD1
    Fazer Login e Armazenar Token
    Criar Produto e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"
