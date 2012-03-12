MysqlDb = require 'mysql'
class Ftp
  
  constructor: (@options, @cli) ->
    @cli.debug "Creating ftp user"
    
    #data
    @conn = MysqlDb.createClient @options.config.mysqlConnection
    @uid = @options.config.apache.wwwrootUid
    @gid = @options.config.apache.wwwrootGid
    @db = @options.config.pureftpd.database
    @table = @options.config.pureftpd.table
    
    @conn.query "USE #{@db}"
    @conn.query "insert into #{@table} VALUES('#{@options.name}', md5('#{@options.password}'), #{@uid},#{@gid}, '/www/#{@options.name}/./')", (err, res, fields) =>
      if err
        @cli.error err + " when creating ftp user"
        return @conn.destroy()
      @cli.info "Created ftp user #{@options.name} with password #{@options.password} chrooted to /www/#{@options.name}/./"
      @conn.destroy()
  	
module.exports = Ftp