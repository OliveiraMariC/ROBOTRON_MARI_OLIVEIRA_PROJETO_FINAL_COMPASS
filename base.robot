# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***

Documentation       Arquivo simples para requisições HTTP em APIs REST
Resource    ./usuarios_keywords.robot
Resource    ./login_keywords.robot
Resource    ./produtos_keywords.robot
Resource    ./carrinho_keywords.robot
#Sessão para setagem de variáveis para utilização
*** Variables ***
${response}
${token_auth}
#Sessão para a criação dos cenários
*** Test Cases ***

#*********************USUÁRIOS***********************

#Requisições Simples
Cenario: GET Todos os Usuarios 200
    [Tags]    GETUSER
    Criar Sessao
    GET Endpoint /usuarios
    Validar Status Code "200"
    
Cenario: POST Endpoint /usuarios sem Email
    [Tags]    POSTUSERSE
    Criar Sessao
    POST Endpoint /usuarios sem Email
    Validar Status Code "400"
Cenario: PUT Editar Usuario 200 
    [Tags]        PUTUSER   
    Criar Sessao
    PUT Endpoint /usuarios
    Validar Status Code "200"

Cenario: DELETE Excluir Usuario 200
    [Tags]    DELUSER
    Criar Sessao
    DELETE Endpoint /usuarios
    Validar Status Code "200"
    GET Endpoint /usuarios
    Validar Status Code "200"

#Encadeamentos
Cenario POST Cadastrar Usuarios Não Administrador 201
    [Tags]        POSTUSER_NAD
    Criar Sessao
    Criar Usuario Nao Adm e Armazenar ID
    Validar Ter Criado Usuario
    DELETE Endpoint /usuarios
    Validar Status Code "200"

Cenario POST Cadastrar Usuarios Administrador 201
    [Tags]        POSTUSER_AD
    Criar Sessao
    Criar Usuario Adm e Armazenar ID
    Validar Ter Criado Usuario
    DELETE Endpoint /usuarios
    Validar Status Code "200"

#Usuários Massa Estática
Cenario: POST Criar Usuario de Massa Estatica 201
    [Tags]    POSTUSERME
    Criar Sessao
    Criar Usuario Estatico Valido
    Validar Status Code "201"

#********************LOGIN***************************
Cenario: POST Realizar Login 200
    [Tags]        POSTLOGIN
    Criar Sessao
    POST Endpoint /login
    Validar Status Code "200"

#********************PRODUTOS************************
Cenario: GET Todos os Produtos 200
    [Tags]    GETPROD
    Criar Sessao
    GET Endpoint /produtos
    Validar Status Code "200"

#erro 405(não define qual tipo de erro bug )
Cenario: POST Cadastrar Produto
    [Tags]    POSTCREATPROD
    Criar Sessao
    Fazer Login e Armazenar Token
    POST Endpoint /produtos
    DELETE Endpoint /produtos
    Validar Status Code "201"
    
Cenario: DELETE Excluir Produto 200
    [Tags]    DELPROD
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Produto e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"

#******************CARRINHO**************************
Cenario: GET Carrinhos 200
    [Tags]    GETCAR
    Criar Sessao
    GET Endpoint /carrinhos
    Validar Status Code "200"

Cenario Criar Carrinho 201
    Criar Sessao
    Fazer Login e Armazenar Token


*** Keywords ***  
Criar Sessao
    Create Session        serverest         http://localhost:3000    

Validar o Usuario com ${_id}
    Should Be True  ID: ${response.json()["_id"]} == ${_id}    


    

