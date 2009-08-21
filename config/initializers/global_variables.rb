# Change globals to match the proper value for your site

DELETE_CONFIRM = "Você tem certeza que quer apagar?\nIsso não poderá ser desfeito."
SEARCH_LIMIT = 25
SITE_NAME = 'Agente Credishop'
SITE = RAILS_ENV == 'production' ? 'novoagente.credishop.com.br' : 'localhost:3000'


MAILER_TO_ADDRESS = 'desenvolvimento@credishop.com.br'
MAILER_FROM_ADDRESS = 'Equipe de Desenvolvimento <desenvolvimento@credishop.com.br>'
REGISTRATION_RECIPIENTS = %W() #send an email to this list everytime someone signs up


YOUTUBE_BASE_URL = "http://gdata.youtube.com/feeds/api/videos/"

