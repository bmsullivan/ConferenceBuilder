q = require('q')

module.exports =
  create: (req, res, next) ->
    if req.method == 'GET'
      res.locals.levels = [
        name: 'Beginner'
      ,
        name: 'Intermediate'
      ,
        name: 'Advanced'
      ]
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

        Presentation.publishCreate(presentation.toObject())
        return res.redirect('/presentation')

  find: (req, res, next) ->
    Presentation.findOneById req.param('id'), (err, presentation) ->
      if err
        return next(err)

      res.locals.presentation = presentation
      return res.view()

  index: (req, res, next) ->
    param = {}
    if !req.user.isAdmin
      param.userId = req.user.id

    Presentation.find(param).done (err, presentations) ->
      if err
        return next(err)

      res.locals.presentations = presentations

      promises = []
      for pres in presentations
        do (pres) ->
          promises.push(Track.findOneById(pres.trackId)
          .then((track) -> pres.trackName = track.name)
          .then(() -> User.findOneById(pres.userId))
          .then((user) -> pres.userName = user.firstName + ' ' + user.lastName))

      q.all(promises).then () -> return res.view()

  update: (req, res, next) ->
    if req.method == 'GET'
      Presentation.findOneById(req.param('id')).done (err, pres) ->
        if err
          return next(err)
        if !req.user.isAdmin && req.user.id != pres.userId
          return res.forbidden('You are not permitted to perform this action')
        res.locals.presentation = pres
        Track.find().done (trackErr, tracks) ->
          if trackErr
            return next(trackErr)
          res.locals.tracks = tracks
          res.locals.levels = [
            name: 'Beginner'
          ,
            name: 'Intermediate'
          ,
            name: 'Advanced'
          ]
          return res.view()
    else
      pres =
        title: req.param('title')
        trackId: req.param('trackId')
        abstract: req.param('abstract')
        level: req.param('level')

      Presentation.findOneById(req.param('id')).done (err, existing) ->
        if err
          return next(err)
        if !req.user.isAdmin && req.user.id != existing.userId
          return res.forbidden('You are not permitted to perform this action')
        else
          Presentation.update(req.param('id'), pres).done (err, presentations) ->
            if err
              if err.ValidationError

                res.locals.flash =
                  error: err.ValidationError

                res.locals.presentation = pres

                return res.view()

            return res.redirect('/presentation/' + presentations[0].id)

  subscribe: (req, res) ->
    Presentation.subscribe(req.socket)
    res.send(200)