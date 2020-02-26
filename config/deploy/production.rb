server '54.227.161.126', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/takuya/.ssh/id_rsa'