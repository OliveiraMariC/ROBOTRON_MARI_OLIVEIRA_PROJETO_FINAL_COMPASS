# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***

Documentation       Arquivo de Testes Endpoint /carrinho
Resource    ../suporte/base.robot
Suite Setup    Criar Sessao    

#Sessão para a criação dos cenários
*** Test Cases ***
Cenario 01: GET Listar Todos os Carrinhos 200
    [Tags]    CARRINHO LISTAR TODOS 200
    GET Endpoint /carrinhos
    Validar Status Code "200"
    
    
Cenario 02: POST Criar Carrinho 201
    [Tags]   CARRINHO CADASTRAR  ME 201   
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Validar Ter Criado o Carrinho
    DELETE Endpoint /carrinhos/concluir-compra
    

Cenario 03: POST Criar Carrinho 400
    [Tags]   CARRINHO CADASTRAR ME 400
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Criar Carrinho Estatico Valido
    Validar Message "Não é permitido ter mais de 1 carrinho"
    Validar Status Code "400"
    DELETE Endpoint /carrinhos/concluir-compra
    

Cenario 04: POST Criar Carrinho Token Inválido 401
     [Tags]    CARRINHO CADASTRAR ME 401
    Selecionar Token Invalido
    Criar Carrinho Estatico Valido
    Validar Status Code "401"

Cenario 05: GET Buscar Carrinho 200
    [Tags]    CARRINHO BUSCAR ID 200
    Fazer Login e Armazenar Token
    GET Endpoint /carrinhos ID
    Validar Status Code "200"


Cenario 06: GET Buscar Carrinho Não Encontrado 400
    [Tags]    BUSCAR CARRINHO 400
    Fazer Login e Armazenar Token
    GET Endpoint Carrinho Não Encontrado
    Validar Message "Carrinho não encontrado"
    Validar Status Code "400"

Cenario 07: DELETE Carrinho Concluir Compra 200
    [Tags]    DELETE CONCLUIR COMPRA 200  
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    DELETE Endpoint /carrinhos/concluir-compra
    Validar Status Code "200"

Cenario 08: DELETE Carrinho Concluir Compra 401
    [Tags]    DELETE CONCLUIR COMPRA 401 
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Selecionar Token Invalido
    DELETE Endpoint /carrinhos/concluir-compra
    Validar Message "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"
    Validar Status Code "401"
    
    

Cenario 09: DELETE Carrinho Cancelar Compra 200
    [Tags]    CANCEL_C
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    DELETE Endpoint /carrinhos/cancelar-compra
    Validar Status Code "200"

Cenario 10: DELETE Carrinho Cancelar Compra Token Inválido 401
    [Tags]    END_CAR_401
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Selecionar Token Invalido
    DELETE Endpoint /carrinhos/cancelar-compra
    Validar Status Code "401"
    Fazer Login e Armazenar Token
    DELETE Endpoint /carrinhos/cancelar-compra
