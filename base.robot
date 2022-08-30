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
Cenario: GET Todos os Usuarios 200
    [Tags]    USERGET
    Criar Sessao
    GET Endpoint /usuarios
    Validar Status Code "200"

Cenario POST Cadastrar Usuarios Administrador 201
    [Tags]        POSTUSER_AD
    Criar Sessao
    Criar Usuario Adm e Armazenar ID
    Validar Ter Criado Usuario
    DELETE Endpoint /usuarios
    Validar Status Code "200"
    

Cenario POST Cadastrar Usuarios Não Administrador 201
    [Tags]        POSTUSER_NAD
    Criar Sessao
    Criar Usuario Nao Adm e Armazenar ID
    Validar Ter Criado Usuario
    DELETE Endpoint /usuarios
    Validar Status Code "200"

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

Cenario: POST Cadastrar Produto
    [Tags]    POSTCREATPROD
    Criar Sessao
    Fazer Login e Armazenar Token
    POST Endpoint /produtos
    Validar Status Code "201"

#Alterar os dados do produto no arquivo produto_ keywords
Cenario: DELETE Excluir Produto 200
    [Tags]    DELPROD
    Criar Sessao
    Criar Usuario Adm e Armazenar ID
    Criar Produto e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"

#******************CARRINHO**************************
Cenario: GET Carrinhos 200
    [Tags]    GETCAR
    Criar Sessao
    GET Endpoint /carrinhos
    Validar Status Code "200"
Cenario: POST Endpoint Carrinho 200
    [Tags]    POSTCAR
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Carrinho e Armazenar ID
    DELETE Endpoint/carrinhos/concluir-compra

Cenario: Cadastrar Carrinho 200
    [Tags]    CARCREAT
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Carrinho e Armazenar ID
    

*** Keywords ***  
Criar Sessao
    Create Session        serverest         http://localhost:3000    

Validar Status Code "${statuscode}"
    Should Be True    ${response.status_code} == ${statuscode}
Validar o Usuario com ${_id}
    Should Be True  ID: ${response.json()["_id"]} == ${_id}    


    

