Path   = require 'path'
Cli    = require('cli').enable('status', 'version')
Apache = require './Apache'
Mysql = require './Mysql'
Ftp = require './Ftp'
Fs = require 'fs'

# Command Line Setup
module.exports = entry_point = () ->
  Cli.enable 'version'
  Cli.setUsage 'hosting -n <domainname> [-a] [-m] [-f] [-p password]'
  Cli.setApp 'hosting', '0.1.0'
  Cli.parse
    'name': ['n', 'Domain name e.g fredagspatter.dk', 'string']
    'mysql': ['m', 'Create database and user', 'boolean']
    'apache': ['a', 'Create webserver config', 'boolean']
    'ftp': ['f', 'Create FTPUser', 'boolean']
    'password': ['p', 'Specified password instead of generated', 'string']
    'config': ['c', 'Configuration file path', 'path', __dirname + '/../conf.json']

  Cli.main (args, options) ->
    Cli.debug "going into entry_point::main"
    Cli.fatal "Please provide a domain name (-n)" if not options.name
    Cli.fatal "This app must be run with root privileges!" if process.getuid()
    if Path.existsSync options.config
      try
        options.config = JSON.parse(Fs.readFileSync(options.config, 'utf-8'))
      catch error
        Cli.fatal "Error parsing config file: #{error}"
    else
      Cli.fatal "Can't find a config file"
    
    options.password = generatePassword() if not options.password
    Cli.info "Password is #{options.password}"
    new Apache options, Cli if options.apache
    new Mysql options, Cli if options.mysql
    new Ftp options, Cli if options.ftp

generatePassword = ->
  b = ""
  for num in [16..1]
    b += "abcdefhjmnpqrstuvwxyz23456789ABCDEFGHJKLMNPQRSTUVWYXZ".charAt(Math.floor(Math.random()*53));
  return b