# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***

Documentation      Arquivo de Testes Endpoint /produtos
Resource    ../Keywords/produtos_keywords.robot
Suite Setup    Criar Sessao
#Sessão para a criação dos cenários
*** Test Cases ***
Cenario: GET Todos os Produtos 200
    [Tags]    GETPROD

    GET Endpoint /produtos
    Validar Status Code "200"

#erro 405(não define qual tipo de erro bug )
Cenario: POST Cadastrar Produto
    [Tags]    POSTCREATPROD
   
    Fazer Login e Armazenar Token
    POST Endpoint /produtos
    DELETE Endpoint /produtos
    Validar Status Code "201"
    
Cenario: DELETE Excluir Produto 200
    [Tags]    DELPROD
  
    Fazer Login e Armazenar Token
    Criar Produto e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"
#Produtos Dinâmicos
Cenario: POST Cadastrar Produto de Massa Dinamica 201
    [Tags]    POSTPRODMD
   
    Fazer Login e Armazenar Token
    Cadastrar Produto Dinamico Valido 
    Validar Status Code "201"