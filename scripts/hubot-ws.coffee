log = console.log
{exec} = require 'child_process'

module.exports = (robot) ->

  require('express-ws')(robot.router)

  # robot.router.get '/ws', (req, res) -> 
  #   log 'GET /ws'
  #   res.end()

  robot.router.ws '/ws', (ws, req) ->
    log 'ws'
    ws.on 'message', (msg) -> 
      try
        msg = JSON.parse msg
      catch e
      
      log 'ws message', msg
      ws.send JSON.stringify msg
    setTimeout -> 
      log 'closing'
      ws.close()
    , 5000

  robot.router.listen 8000

  child = exec 'open -gWn -a "Safari" http://localhost:8000/ws.html'
  log 'pid', child.pid
  setTimeout -> 
    log 'kill'
    child.kill() # doesnt work
  , 8000
