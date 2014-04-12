module.exports =
  create: (req, res, next) ->
    if req.method == 'GET'
      return res.view()

    else
      pres =
        title: req.param('title')
        abstract: req.param('abstract')
        level: req.param('level')
        userId: req.user.id

      Presentation.create(pres).done (err, presentation) ->
        if err
          return next(err)

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
      return res.view()
