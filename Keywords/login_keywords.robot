# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Ações do Endpoint Login
Resource        ../suporte/base.robot  

*** Keywords ***
POST Endpoint /login static
    ${json}    Importar JSON Estatico    json_login_ex.json 
    ${payload}    Set Variable    ${json["user_valido"]}
    Set Global Variable    ${payload}
    ${response}    POST On Session    serverest       /login        json=&{payload}
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}

POST Endpoint /login static sem admin
    ${json}    Importar JSON Estatico    json_login_ex.json 
    ${payload}    Set Variable    ${json["user_valido_sem_adm"]}
    Set Global Variable    ${payload}
    ${response}    POST On Session    serverest       /login        json=&{payload}
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}
Validar Ter Logado
    Should Be Equal        ${response.json()["message"]}        Login realizado com sucesso
    Should Not Be Empty        ${response.json()["authorization"]}        
Fazer Login e armazenar Token
    POST Endpoint /login static
    Validar Ter Logado
    ${token_auth}        Set Variable        ${response.json()["authorization"]} 
    Log To Console        Token Salvo:${token_auth}
    Set Global Variable    ${token_auth}     
Fazer Login Invalido
    POST Endpoint /login static sem admin 
    POST Endpoint /login static
    Validar Ter Logado
    ${token_auth}        Set Variable        ${response.json()["authorization"]} 
    Log To Console        Token Salvo:${token_auth}
    Set Global Variable    ${token_auth} 