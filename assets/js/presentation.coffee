socket.on 'connect', () ->
  socket.on 'message', (message) ->
    if message.verb == 'create' && message.model == 'presentation'
      $('table tbody').append('<tr><td>' + message.data.id + '</td><td>' + message.data.title + '</td><td>' + message.data.level + '</td><td>' + message.data.trackName + '</td><td>' + message.data.userName + '</td><td>' + '<a class="btn btn-primary" href="/presentation/' + message.data.id + '">Show</a></td></tr>')
    if message.verb == 'update' && message.model == 'presentation'
      $('table tbody tr td:contains(' + message.data.id + ')').parent().replaceWith('<tr><td>' + message.data.id + '</td><td>' + message.data.title + '</td><td>' + message.data.level + '</td><td>' + message.data.trackName + '</td><td>' + message.data.userName + '</td><td>' + '<a class="btn btn-primary" href="/presentation/' + message.data.id + '">Show</a></td></tr>')
  socket.get('/presentation/subscribe')
