# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
  
Documentation        Arquivo de testes para endpoint /usuarios
Resource    ../supports/base.robot

Suite Setup    Criar Sessao    

#Sessão para a criação dos cenários

*** Test Cases ***

#Requisições Simples
Cenario: GET Todos os Usuarios 200
    [Tags]    GETUSER
    GET Endpoint /usuarios
    Validar Status Code "200"
    Quantidade Usuarios Cadastrados
Cenario: POST Endpoint /usuarios sem Email
    [Tags]    POSTUSERSE
    POST Endpoint /usuarios sem Email
    Validar Status Code "400"
Cenario: PUT Editar Usuario 200 
    [Tags]        PUTUSER   
    PUT Endpoint /usuarios
    Validar Status Code "200"

Cenario: DELETE Excluir Usuario 200
    [Tags]    DELUSER
    DELETE Endpoint /usuarios
    Validar Status Code "200"
    GET Endpoint /usuarios
    Validar Status Code "200"

#Encadeamentos
Cenario POST Cadastrar Usuarios Não Administrador 201
    [Tags]        POSTUSER_NAD
    Criar Usuario Nao Adm e Armazenar ID
    Validar Ter Criado Usuario
    DELETE Endpoint /usuarios
    Validar Status Code "200"

Cenario POST Cadastrar Usuarios Administrador 201
    [Tags]        POSTUSER_AD
    Criar Usuario Adm e Armazenar ID
    Validar Ter Criado Usuario
    Quantidade Usuarios Cadastrados
    DELETE Endpoint /usuarios
    Validar Status Code "200"
    Quantidade Usuarios Cadastrados
#Usuários Massa Estática
Cenario: POST Cadastrar Usuario de Massa Estatica 201
    [Tags]    POSTUSERME
    Cadastrar Usuario Estatico Valido
    Validar Status Code "201"

#Usuário Massa Dinâmica

