# sslrails
dummy Rails app built to test SSL packets in local environment

#  creating a Root SSL certificate:
generate a private key:
```
openssl genrsa -des3 -out server.orig.key 2048
```

remove password from the key:
```
openssl rsa -in server.orig.key -out server.key
```

generate csr (Certificate signing request):
```
openssl req -new -key server.key -out server.csr
```

generate a self-signed SSL certificate:
```
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```

Add following line to your `/etc/hosts` file:
```
127.0.0.1 localhost.ssl
```

# Update Ubuntu
install `ca-certificates`:
```
sudo apt-get install ca-certificates
```

place your certificate to `ca-certificates` dir:
```
sudo cp server.crt /usr/share/ca-certificates
```

rebuild certificate dir:
```
# scroll to your certificate, mark it for inclusion and select ok.
sudo dpkg-reconfigure ca-certificates 
```



# Update Rails

replace `puma` in Gemfile with:
```
gem 'puma', git: 'https://github.com/eric-norcross/puma.git', branch: 'chrome_70_ssl_curve_compatiblity'
```

Start rails server:
```
rails s -b 'ssl://127.0.0.1:3000?key=/home/shivam/.ssh/server.key&cert=/home/shivam/.ssh/server.crt'
```




