passport = require('passport')

module.exports =
    
  login: (req, res) ->
    if req.method == 'GET'
      return res.view()

    passport.authenticate('local', (err, user, info) ->
      if err || !user
        return res.view()

      req.logIn user, (err) ->
        if err
          return res.view()

        res.redirect('/')
    )(req, res)

  logout: (req, res) ->
    req.logout()
    res.redirect('/')


  _config: {}
