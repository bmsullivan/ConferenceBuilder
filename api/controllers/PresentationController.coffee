q = require('q')

module.exports =
  create: (req, res, next) ->
    if req.method == 'GET'
      Track.find().done (err, tracks) ->
        if err
          return next(err)
        res.locals.tracks = tracks
        return res.view()

    else
      pres =
        title: req.param('title')
        trackId: req.param('trackId')
        abstract: req.param('abstract')
        level: req.param('level')
        userId: req.user.id

      Presentation.create(pres).done (err, presentation) ->
        if err
          if err.ValidationError

            res.locals.flash =
              error: err.ValidationError

            res.locals.presentation = pres

            return res.view()

        res.locals.presentation = presentation
        return res.view()

  find: (req, res, next) ->
    Presentation.findOneById req.param('id'), (err, presentation) ->
      if err
        return next(err)

      res.locals.presentation = presentation
      return res.view()

  index: (req, res, next) ->
    Presentation.find().done (err, presentations) ->
      if err
        return next(err)

      res.locals.presentations = presentations

      promises = []
      for pres in presentations
        do (pres) ->
          promises.push Track.findOneById(pres.trackId)
          .then((track) -> pres.trackName = track.name)
          .then(() -> User.findOneById(pres.userId))
          .then((user) -> pres.userName = user.firstName + ' ' + user.lastName)

      q.all(promises).then () -> return res.view()
