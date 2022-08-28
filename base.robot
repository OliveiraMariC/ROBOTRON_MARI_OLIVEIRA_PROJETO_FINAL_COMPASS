
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

*** Keywords ***
GET Endpoint /usuarios 
    ${response}       GET On Session       serverest    /usuarios
    Log To Console                         Response:${response}
    Set Global Variable                             ${response} 

Criar Sessao
    Create Session        serverest         http://localhost:3000    

Validar Status Code "${statuscode}"
    Should Be True    ${response.status_code} == ${statuscode}
Printar Conteudo Response
    Log To Console    Nome: ${response.json()["usuarios"][0]}
