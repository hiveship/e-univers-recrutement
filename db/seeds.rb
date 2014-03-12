# Création du compte admin initial
User.create! login: 'admin', mail: 'admin@admin', status: 'admin', pass: 'admin', state: 'activate'

# Création d'un utilisateur de chaque type pour démo
User.create! login: 'manager', mail: 'manager@manager', status: 'manager', pass: 'manager', state: 'activate'
User.create! login: 'recruteur', mail: 'recruteur@recruteur', status: 'recruteur', pass: 'recruteur', state: 'activate'