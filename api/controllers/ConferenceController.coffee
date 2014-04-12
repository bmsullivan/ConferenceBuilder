module.exports =
    
  update: (req, res, next) ->
    if req.method == 'GET'
      Conference.find().limit(1).done (err, conf) ->
        if err
          return next(err)

        res.locals.conference = if conf && conf instanceof Array then conf[0] else  name: '', tagline: ''
        return res.view()

    else
      confObj =
        name: req.param('name'),
        tagline: req.param('tagline')

      if req.param('id') == '0'
        Conference.create(confObj).done (err, conf) ->
          if err
            return next(err)
          res.locals.conference = conf
          return res.view()
      else
        Conference.update req.param('id'), confObj, (err, confs) ->
          if err
            return next(err)

          res.locals.conference = confs[0];
          return res.redirect('/conference/update')

  _config: {}
