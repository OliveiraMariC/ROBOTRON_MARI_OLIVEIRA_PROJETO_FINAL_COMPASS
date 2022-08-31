# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Ações do Endpoint Usuários
Resource            ../suports/base.robot 

*** Keywords ***
GET Endpoint /usuarios 
    ${response}                 GET On Session      serverest    /usuarios
    Log To Console                                  Response:${response}
    Set Global Variable         ${response}
POST Endpoint /usuarios 
   
    ${response}                 POST On Session          serverest       /usuarios        json=&{payload}                          
    Log To Console    Response: ${response}    
    Set Global Variable         ${response}
POST Endpoint /usuarios Administrador 
    &{payload}                  Create Dictionary        nome=U41        email=u41@gmail.com        password=U33        administrador=true
    ${response}                 POST On Session          serverest       /usuarios                          data=&{payload}
    Log To Console    Response: ${response}    
    Set Global Variable         ${response}
    
POST Endpoint /usuarios nao Administrador 
    &{payload}                  Create Dictionary        nome=U40        email=u40@gmail.com        password=U22        administrador=false
    ${response}                 POST On Session          serverest       /usuarios    expected_status=any                          data=&{payload}
    Log To Console    Response: ${response}
    Set Global Variable         ${response}
    
POST Endpoint /usuarios sem Email
    &{payload}        Create Dictionary        nome=U40        email=        password=U22        administrador=false
    ${response}            POST On Session          serverest       /usuarios                             data=&{payload}
    Log To Console    Response: ${response}
    Set Global Variable         ${response}     
PUT Endpoint /usuarios
    &{payload}                  Create Dictionary        nome=U2        email=u30@gmail.com        password=U22        administrador=true
    ${response}                 PUT On Session           serverest       /usuarios/iNFbsUAXU3EFhsWc        data=&{payload}
    Log To Console    Response: ${response}
    Set Global Variable         ${response}
DELETE Endpoint /usuarios
    ${response}                DELETE On Session           serverest       /usuarios/rCRifRCL7y5vHCba
    Log To Console    Response:${response}      
    Set Global Variable        ${response}    

Criar Usuario Adm e Armazenar ID 
    POST Endpoint /usuarios Administrador
    Validar Ter Criado Usuario
    ${id_usuario}            Set Variable        ${response.json()["_id"]} 
    Log To Console                   ID Usuario: ${id_usuario}    
    Set Global Variable                          ${id_usuario} 

Criar Usuario Nao Adm e Armazenar ID
    POST Endpoint /usuarios nao Administrador
    Validar Ter Criado Usuario
    ${id_usuario}    Set Variable                ${response.json()["_id"]} 
    Log To Console                   ID Usuario: ${id_usuario}
    Set Global Variable                          ${id_usuario} 
Criar Usuario e Armazenar ID 
    POST Endpoint /usuarios 
    Validar Ter Criado Usuario
    ${id_usuario}            Set Variable        ${response.json()["_id"]} 
    Log To Console                   ID Usuario: ${id_usuario}
    Set Global Variable                          ${id_usuario} 

Cadastrar Usuario Estatico Valido
    ${json}        Importar JSON Estatico        json_usuarios_ex.json
    ${payload}        Set Variable        ${json["user_valido"]} 
    Set Global Variable    ${payload}
    POST Endpoint /usuarios 
    Log To Console    ${payload}
Cadastrar Usuario Dinamico Valido
    ${payload}         Criar Dados Dinamicos Usuario Valido
    Set Global Variable         ${payload}
    POST Endpoint /usuarios 

        
Validar Ter Criado Usuario 
    Should Be Equal                              ${response.json()["message"]}    Cadastro realizado com sucesso
    