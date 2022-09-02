# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Geração de Massas de Dados Dinâmicos
Resource    ../base.robot
*** Keywords ***


Criar Dados Produto Valido
    ${random_produto}           FakerLibrary.Word
    ${random_preco}             FakerLibrary.Building Number
    ${random_qtd}               FakerLibrary.Building Number
    ${payload}                  Create Dictionary    nome=${random_produto}    preco=${random_preco}    descricao=produto teste    quantidade=${random_qtd}    
    Log To Console              ${payload}
    Set Global Variable         ${payload} 

    
      
    
