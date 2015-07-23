
window.socket = new WebSocket 'ws://localhost:8000/ws'
socket.onopen = ->
  handle = setInterval (->socket.send Date.now()), 1000
  socket.onmessage = (event) ->
    document.write "msg: #{event.data}<br/>"
  socket.onclose = ->
    document.write "closed"
    clearInterval handle
