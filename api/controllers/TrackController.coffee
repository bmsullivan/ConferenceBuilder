module.exports =

  index: (req, res, next) ->

    Track.find().done (err, tracks) ->

      if err
        return next(err)

      res.locals.tracks = tracks
      return res.view()

  create: (req, res, next) ->

    if req.method == 'GET'
      return res.view()

    else
      t =
        name: req.param('name')

      Track.create(t).done (err, track) ->

        if err
          if err.ValidationError

            res.locals.flash =
              error: err.ValidationError

            res.locals.user = t

            return res.view()

        res.redirect('/track')
