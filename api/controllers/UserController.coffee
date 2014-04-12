module.exports =
    
  create: (req, res, next) ->
    if req.method == 'GET'
      return res.view()


    hasher = require('password-hash')

    userObj =
      firstName: req.param('firstName')
      lastName: req.param('lastName')
      email: req.param('email')
      hashedPassword: hasher.generate(req.param('password'))

    if req.param('password') != req.param('confirmPassword')
      res.locals.flash =
        error:
          password: [
            {message: 'Password and Confirm Password do not match'}
          ]

      res.locals.user = userObj

      return res.view()

    User.create(userObj).done (err, user) ->

      if err
        if err.ValidationError

          res.locals.flash =
              error: err.ValidationError

          res.locals.user = userObj

          return res.view()

      req.logIn user, (err) ->
        if err
          return res.view()

        return res.redirect('/')

  index: (req, res, next) ->
    User.find().done (err, users) ->
      if err
        return next(err)

      res.locals.users = users
      return res.view()

  update: (req, res, next) ->
    if req.method == 'GET'
      User.findOneById(req.param('id')).done (err, user) ->
        if err
          return next(err)

        res.locals.user = user
        return res.view()
    else

      if req.user.isAdmin
        userObj =
          firstName: req.param('firstName')
          lastName: req.param('lastName')
          email: req.param('email')
          isAdmin: req.param('isAdmin') == 'on'
      else
        userObj =
          firstName: req.param('firstName')
          lastName: req.param('lastName')
          email: req.param('email')

      User.update req.param('id'), userObj, (err) ->
        if err
          return res.redirect('/user/update/' + req.param('id'))

        res.redirect('/user')

  find: (req, res, next) ->

    if !req.user.isAdmin && req.param('id') != req.user.id.toString()
      return res.forbidden('You are not permitted to perform this action.')

    User.findOneById req.param('id'), (err, user) ->
      if err
        return next(err)

      res.locals.user = user
      return res.view()
