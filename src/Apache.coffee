fs = require('fs');
FFI = require("node-ffi")
libc = new FFI.Library null, {"system": ["int32", ["string"]]}
run = libc.system
class Apache
  
  constructor: (@options, @cli) ->
    @cli.debug "Checking if folder exists"
    @wwwroot = @options.config.apache.wwwroot
    @uid = @options.config.apache.wwwrootUid
    @gid = @options.config.apache.wwwrootGid
    @tmplFile = @options.config.apache.template
    #i did'nt know about the Path.existSync before after this was written :)
    try
      @cli.error "#{@wwwroot}/#{@options.name} exists, skipping" if fs.readdirSync @wwwroot  + "/" + options.name    
    catch error
      @cli.debug "Creating folder #{@wwwroot}/#{@options.name}, #{@wwwroot}/#{@options.name}/httpdocs, #{@wwwroot}/#{@options.name}/logs"
      fs.mkdirSync @wwwroot  + "/" + options.name
      fs.mkdirSync @wwwroot  + "/" + options.name + "/httpdocs"
      fs.mkdirSync @wwwroot  + "/" + options.name + "/logs"
      @cli.debug "Setting permissions #{@uid}:#{@gid}"
      fs.chownSync @wwwroot  + "/" + options.name, @uid, @gid
      fs.chownSync @wwwroot  + "/" + options.name + "/httpdocs", @uid, @gid
      fs.chownSync @wwwroot  + "/" + options.name + "/logs", @uid, @gid
    @cli.debug "Looking for existing configuration"
    try
      @cli.error "Configuration already exists for this site, skipping" if fs.readFileSync "/etc/apache2/sites-available/" + @options.name
    catch error
      @cli.debug "Creating apache config"
      tmpl = fs.readFileSync @tmplFile, "utf8"
      tmpl = tmpl.replace new RegExp("%NAME%", 'g'), @options.name
      fs.writeFileSync "/etc/apache2/sites-available/" + @options.name, tmpl, 'utf8'
      @cli.debug "Configuration saved"
    
    @cli.debug "Enabling configuration"
    try
      @cli.error "Configuration already enabled, skipping" if fs.readFileSync "/etc/apache2/sites-enabled/" + @options.name
    catch error
      fs.symlinkSync "/etc/apache2/sites-available/" + @options.name, "/etc/apache2/sites-enabled/" + @options.name
      @cli.debug "Configuration enabled"
    
    @cli.info "Web configuration complete - restarting apache graceful"
    run("apache2ctl graceful")
    @cli.info "Apache restarted - all done"
  log: (msg) ->
  	@cli.info "Apache #{msg}"
  	
module.exports = Apache