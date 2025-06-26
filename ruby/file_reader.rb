# file_reader.rb

# Ce script est censé lire un fichier situé dans un sous-dossier 'public'.
# Utilisation normale depuis le terminal : ruby file_reader.rb "mon_fichier.txt"

# La source de données non fiables est ici un argument de la ligne de commande (ARGV).
# CodeQL reconnaît ARGV comme une source de données contrôlée par l'utilisateur.
filename = ARGV[0]

# On s'assure qu'on a bien un nom de fichier
if filename
  # On construit le chemin du fichier
  base_dir = 'public'
  filepath = File.join(base_dir, filename)

  # VULNÉRABILITÉ : Le "filename" fourni par l'utilisateur n'est pas validé.
  # Un attaquant peut utiliser ".." pour remonter dans l'arborescence des fichiers.
  # Ce "File.read" est un puits de données (sink) que CodeQL surveille.
  begin
    puts "Lecture du fichier : #{filepath}"
    content = File.read(filepath)
    puts "--- CONTENU ---"
    puts content
    puts "--- FIN ---"
  rescue => e
    puts "Erreur : impossible de lire le fichier. #{e.message}"
  end
end
