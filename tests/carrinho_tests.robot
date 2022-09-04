# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***

Documentation       Arquivo de Testes Endpoint /carrinho
Resource    ../suporte/base.robot
Suite Setup    Criar Sessao    

#Sessão para a criação dos cenários
*** Test Cases ***
Cenario 01: GET Listar Todos os Carrinhos 200
    [Tags]     GETALLCARS
    GET Endpoint /carrinhos
    Validar Status Code "200"
    
    
Cenario 02: POST Criar Carrinho 201
    [Tags]    POSTCAR201    
    Fazer Login e Armazenar Token
    DELETE Endpoint /carrinhos/concluir-compra
    Criar Carrinho Estatico Valido
    Validar Status Code "201"
    Validar Ter Criado o Carrinho
    DELETE Endpoint /carrinhos/concluir-compra

Cenario 03: POST Criar Carrinho 400
    [Tags]    POSTCAR400
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Criar Carrinho Estatico Valido
    Validar Status Code "400"
    DELETE Endpoint /carrinhos/concluir-compra

Cenario 04: POST Criar Carrinho Token Inválido 401
     [Tags]    POSTCAR401
    Selecionar Token Invalido
    Criar Carrinho Estatico Valido
    Validar Status Code "401"

Cenario 05: GET Buscar Carrinho 200
    [Tags]    GETCAR200
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    DELETE Endpoint /carrinhos/concluir-compra
    #Criar Carrinho Estatico Valido
    #GET Endpoint /carrinhos/id
    #DELETE Endpoint /carrinhos/concluir-compra

Cenario 06: GET Buscar Carrinho Não Encontrado 400
    [Tags]    GETCAR400
    Fazer Login e Armazenar Token
    GET Endpoint Carrinho Não Encontrado

Cenario 07: DELETE Carrinho Concluir Compra 200
    [Tags]    CONCLUIRCAR200   
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    DELETE Endpoint /carrinhos/concluir-compra
    Validar Status Code "200"

Cenario 08: DELETE Carrinho Concluir Compra Token Inválido 401
    [Tags]    CONCLUIRCAR401
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Selecionar Token Invalido
    DELETE Endpoint /carrinhos/concluir-compra
    Validar Status Code "401"
    Fazer Login e Armazenar Token
    DELETE Endpoint /carrinhos/concluir-compra

Cenario 09: DELETE Carrinho Cancelar Compra 200
    [Tags]    CANCELARCAR200
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    DELETE Endpoint /carrinhos/cancelar-compra
    Validar Status Code "200"

Cenario 10: DELETE Carrinho Cancelar Compra Token Inválido 401
    [Tags]    CANCELARCAR401
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Selecionar Token Invalido
    DELETE Endpoint /carrinhos/cancelar-compra
    Validar Status Code "401"
    Fazer Login e Armazenar Token
    DELETE Endpoint /carrinhos/cancelar-compra