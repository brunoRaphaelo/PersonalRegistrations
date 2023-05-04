# PersonRegistrations

> API para o cadastro de pessoas

## **Tecnologias**

* [Ruby 3.1.3](https://www.ruby-lang.org/)
* [Rails 7.0.4](https://guides.rubyonrails.org/index.html)
* [PostgreSQl 9.4+](https://www.postgresql.org/)

___

## **Postman do projeto** ##
Login: raphaelbruno922@gmail.com

Password: d2JQWN-Q5ShRupM

Workspace -> PersonalRegistrations - Requests

___

## **Avisos** ##

#### 1. Deverá ser criado um usuário no Postgres para utilizar o banco local
    Executar "sudo -u postgres psql" no terminal para acessar o banco Postgres
    Executar "create user person_registrations with password 'person_registrations';"
    Executar "alter user person_registrations with superuser;"
    Executar "quit" para sair do Postgres
    Executar "rails db:create" para criar os bancos de teste e desenvolvimento
#### 2. Para popular o banco que foi criado, deverá rodar *rails db:seed*

____

## **Estrutura**

### *Pessoas*

Entidade `Person` que será responsável por registrar as pessoas.

### *Endereços*

Entidade `Address` que será responsável por registrar os endereços das pessoas.