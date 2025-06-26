# app_vulnerable.rb
require 'sinatra'

# Endpoint qui prend un nom de répertoire en paramètre
# et est censé lister son contenu.
# EXEMPLE D'URL D'UTILISATION NORMALE : http://localhost:4567/list_files?dir=./
get '/list_files' do
  # Récupère le paramètre 'dir' de l'URL
  directory = params['dir']

  # VULNÉRABILITÉ : Le paramètre est utilisé directement dans une commande système.
  # Un attaquant peut injecter des commandes ici.
  # Par exemple, en appelant /list_files?dir=.;whoami
  begin
    # La commande 'ls' est exécutée avec l'entrée de l'utilisateur.
    result = `ls -l #{directory}`
    content_type :text
    result
  rescue => e
    "Une erreur est survenue : #{e.message}"
  end
end
