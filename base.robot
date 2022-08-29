
# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Arquivo simples para requisições HTTP em APIs REST
Library    RequestsLibrary

#Sessão para setagem de variáveis para utilização
*** Variables ***

#Sessão para a criação dos cenários
*** Test Cases ***
Cenario: GET Todos os Usuarios 200
    [Documentation]        -Cria a sesssão
    ...                    -Busca todos os usuários
    ...                    -Valida o status 200
    ...                    -Printa o conteúdo na resposta
    
    [Tags]    USERGET200
   

    Criar Sessao
    GET Endpoint /usuarios
    Validar Status Code "200"
    Printar Conteudo Response  

Cenario: GET Usuario Especifico 200
    [Documentation]        -Cria a sesssão
    ...                    -Busca o usuário com ID informado
    ...                    -Valida o usuário com o ID informado
    ...                    -Valida o status 200
    ...                    -Printa o conteúdo na resposta
    
    [Tags]       USERGETID200
   

    Criar Sessao
    GET Endpoint /usuarios/id "njNlATN3XSltWyUb"
    Validar o Usuario com id "njNlATN3XSltWyUb"
    Validar Status Code "200"
    Printar Conteudo Response 

Cenario POST Cadastrar Usuarios Administrador 201
    [Documentation]        -Cria a sessão
    ...                    -Cadastra um novo usuário administrador
    ...                    -Valida o status code
    ...                    -Printa o conteúdo na resposta    
   
    [Tags]        USERPOSTAD
    Criar Sessao
    POST Endpoint /usuarios Administrador
    Validar Status Code "201"
    Printar Conteudo Response

Cenario POST Cadastrar Usuarios Não Administrador 201
    [Documentation]        -Cria a sessão
    ...                    -Cadastra um novo usuário não administrador
    ...                    -Valida o status code
    ...                    -Printa o conteúdo na resposta    
   
    [Tags]        USERPOSTNAD
    Criar Sessao
    POST Endpoint /usuarios nao Administrador
    Validar Status Code "201"
    Printar Conteudo Response

Cenario: PUT Editar Usuario 200 
    [Documentation]        -Cria a sessão
    ...                    -edita o usuário
    ...                    -Valida status code
    ...                    -Printa o conteúdo na resposta
    [Tags]        USERPUT   
    Criar Sessao
    PUT Endpoint /usuarios
    Validar Status Code "200"
    Printar Conteudo Response

Cenario: DELETE Excluir Usuario 200
    [Documentation]        -Cria a sessão
    ...                    -exclui o usuário com id informado
    ...                    -Valida status code
    ...                    -Printa o conteúdo na resposta
    [Tags]        USERDELETE

    Criar Sessao
    DELETE Endpoint /usuarios
    Validar Status Code "200"
    Printar Conteudo Response
*** Keywords ***
GET Endpoint /usuarios 
    ${response}                GET On Session      serverest    /usuarios
    Log To Console                                 Response:${response}
    Set Global Variable        ${response} 

GET Endpoint /usuarios/${_id}
    ${response}                GET On Session      serverest    /usuarios/${_id}
    Log To Console                                 Response: ${response.content}
    Set Global Variable        ${response}
POST Endpoint /usuarios Administrador 
    &{payload}                 Create Dictionary        nome=U23        email=u23@gmail.com        password=U22        administrador=true
    ${response}                POST On Session          serverest       /usuarios        data=&{payload}
    Set Global Variable        ${response}
    
POST Endpoint /usuarios nao Administrador 
    &{payload}                 Create Dictionary        nome=U25        email=u25@gmail.com        password=U22        administrador=false
    ${response}                POST On Session          serverest       /usuarios        data=&{payload}
    Set Global Variable        ${response}
       
PUT Endpoint /usuarios
    &{payload}                 Create Dictionary        nome=U25        email=u30@gmail.com        password=U22        administrador=true
    ${response}                PUT On Session           serverest       /usuarios/iNFbsUAXU3EFhsWc        data=&{payload}
    Set Global Variable        ${response}
DELETE Endpoint /usuarios
    ${response}                DELETE On Session           serverest       /usuarios/iNFbsUAXU3EFhsWc        
    Set Global Variable        ${response}    
Criar Sessao
    Create Session        serverest         http://localhost:3000    

Validar Status Code "${statuscode}"
    Should Be True    ${response.status_code} == ${statuscode}
Validar o Usuario com ${_id}
    Should Be True  ID: ${response.json()["_id"]} == ${_id}    

Printar Conteudo Response
    Log To Console    Nome: ${response.content}

     
