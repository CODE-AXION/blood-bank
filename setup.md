# REQUIRED TO RUN THIS PROJECT

PHP VERSION : 8.1
Install Composer (to install php packages)
Node: 22 version


## Steps to run project:

## Import database
first import the .SQL file in phpmyadmin ... you can use xampp to install php8.1 and mysql/phpmyadmin

after importing all the database and records will be created

## Install Packages by running below commands one by one
`cp .env.example .env`
`composer install`
`npm install`
`npm run dev`

## Run project:
`php artisan serve --host=localhost --port=8000`


## Additional Details
http://localhost:8000/login <--- login for staff/patient/donor
http://localhost:8000/admin/login <--- login for super admin 
http://localhost:8000 <--- home page

## Credentials for admin role:
Role: admin
email: admin77@gmail.com
password: asdfasdf
