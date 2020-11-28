# ruptiva_challenge
Código feito como teste de back-end para a empresa Ruptiva.

Ferramentas utilizadas:
- Ruby On Rails
- PostgreSQL
- Git

Gems extras utilizadas
- Faker, para gerar dados falsos durante os testes.
- shoulda_matchers, para fazer com que testes simples do Rails fiquem mais compreensíveis.
- factory_bot_rails, para auxiliar na criação de objetos durante os testes.
- jbuilder, para estilizar as respostas em json.

A versão do Ruby utilizada foi a 2.7.1 e do Rails 6.0.3.

Para clonar o projeto execute o seguinte comando no terminal:
git clone https://github.com/lcsmachado/ruptiva_challenge.git

Para acessar a pasta do projeto executo o comando: cd ruptiva_challenge

Agora é necessário instalar as gems, execute o comando: bundle install

Para criar o banco de dados, execute o comando: rails db:create

Para criar as tabelas do banco de dados, execute o comando: rails db:migrate

Para popular o banco de dados, execute o comando: rails db:seed

Com este comando será criado o usuário abaixo:

{
  "first_name": "Maikel",
  "last_name": "Bald",
  "email": "maikel@ruptiva.com",
  "password": "ilikeruptiva",
  "role": "admin"
}

O último passo é inicializar o servidor da aplicação, executando o comando: rails s

Neste momento o servidor está pronto para receber suas requisições, por padrão ele está sendo executado no endereço: http://localhost:3000

Para acessar a documentação da API, acesse: https://documenter.getpostman.com/view/3753025/TVmJgdoJ