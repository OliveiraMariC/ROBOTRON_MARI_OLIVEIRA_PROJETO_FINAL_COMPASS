# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Ações do Endpoint Usuários
Resource    ../suporte/base.robot

*** Keywords ***

################--SIMPLES--#####################
GET Endpoint /usuarios
    ${response}    GET On Session    serverest        /usuarios
    Log To Console        ${response}
    Set Global Variable    ${response} 
PUT Endpoint /usuarios
    &{payload}        Create Dictionary        nome=User104        email=user14@gmail.com        password=user103        administrador=true
    ${response}    PUT On Session    serverest       /usuarios/OEywGN8P96KYRTon        data=&{payload}
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response} 
    Validar Ter Alterado Usuario
POST Cadastrar Usuario
    &{payload}        Create Dictionary        nome=User160       email=user160@gmail.com        password=user103        administrador=true
    ${response}    POST On Session    serverest       /usuarios        json=&{payload}
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}

DELETE Endpoint /usuarios        
    ${response}    DELETE On Session    serverest       /usuarios/${id_user}            expected_status=any    
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}
    Trazer Quantidade Usuarios
###############--ENCADEAMENTO--####################
Cadastrar Usuario e Aramazenar ID
    Trazer Quantidade Usuarios
    &{payload}        Create Dictionary        nome=User118       email=user118@gmail.com        password=user103        administrador=true
    ${response}    POST On Session    serverest       /usuarios        json=&{payload}
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}
    Validar Ter Criado o Usuario
    ${id_user}        Set Variable        ${response.json()["_id"]} 
    Log To Console        ID Usuario:${id_user}
    Set Global Variable        ${id_user}    
Cadastrar Static Usuario Valido e Aramazenar ID
    Buscar Dados Static User Valido
    Should Be Equal        ${response.json()["message"]}        Cadastro realizado com sucesso
    Should Not Be Empty        ${response.json()["_id"]} 
Validar Ter Criado o Usuario
    Should Be Equal        ${response.json()["message"]}        Cadastro realizado com sucesso
    Should Not Be Empty        ${response.json()["_id"]}                  
Validar Ter Alterado Usuario
    Should Be Equal        ${response.json()["message"]}        Alterado com sucesso
    Should Not Be Empty        ${response.json()["_id"]}                  

Buscar Dados Static User Valido
    ${json}    Importar JSON Estatico    json_usuarios_ex.json 
    ${payload}    Set Variable    ${json["user_valido"]}
    Set Global Variable    ${payload}
    ${response}    POST On Session    serverest       /usuarios        json=&{payload}
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}
Buscar Dados Static User Invalido
    ${json}    Importar JSON Estatico    json_usuarios_ex.json 
    ${payload}    Set Variable    ${json["user_invalido"]}
    Set Global Variable    ${payload}
    ${response}    POST On Session    serverest       /usuarios        json=&{payload}
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}
Trazer Quantidade Usuarios
    ${quantidade}    Buscar Quantidade Usuarios Cadastrado 
    Log To Console        ${quantidade}       
    
##############----Apagar Depois-------#########    
Apagar Usuario        
    ${response}    DELETE On Session    serverest       /usuarios/b2tYnEqc8oCPaqkJ           expected_status=any    
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response} 