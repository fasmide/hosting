MysqlDb = require 'mysql'
class Mysql
  
  constructor: (@options, @cli) ->
    @cli.debug "Creating database"
    @conn = MysqlDb.createClient @options.config.mysqlConnection
    @databaseName = @options.name.replace(new RegExp("\\.", 'g'), "_")
    @conn.query "create database #{@databaseName}", (err, res, fields) =>
      if err
        @cli.error err + " skipping user"
        return @conn.destroy()
      @cli.info "Created database #{@databaseName}"
      @createUser()
  createUser: () ->
    @conn.query "GRANT ALL ON #{@databaseName}.* TO #{@databaseName}@'localhost' IDENTIFIED BY '#{@options.password}';", (err, res, fields) =>
      if err
        @cli.error err
        return @conn.destroy()
      @cli.info "Created db user #{@databaseName} with password #{@options.password} for database #{@databaseName}"
      return @conn.destroy()

module.exports = Mysql