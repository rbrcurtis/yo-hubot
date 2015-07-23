fs = require 'fs'

log = console.log
module.exports = (robot) ->

  robot.router.post '/upload', (req, res) ->
    log 'upload', req.files

    fs.mkdir "#{process.cwd()}/uploads", =>
      for herp, file of req.files
        log 'files', 'upload', file.path, file.name
        try
          fs.renameSync file.path, "#{process.cwd()}/uploads/#{file.name}"
          log 'moved file', file.name
        catch e
          log 'error', e
          return res.send 500

      res.send 'OK'
          

  robot.router.get '/files', (req, res) ->
    log 'get files', req
    fs.readdir "#{process.cwd()}/uploads", (err, files) ->
      log 'files', 'readDir', err, files
      if err then return res.send 500
      res.send files


  robot.router.get '/files/:file', (req, res) ->
    log 'get files', req
    fs.createReadStream("#{process.cwd()}/uploads/#{req.params.file}").pipe res
