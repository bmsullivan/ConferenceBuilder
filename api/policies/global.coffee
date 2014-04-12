module.exports = (req, res, next) ->

  Conference.find().limit(1).done (err, conference) ->
    if(err)
      return next(err)

    res.locals.globalConference = if conference && conference instanceof Array && conference.length > 0 then conference[0] else name: 'Name Placeholder', tagline: 'Tagline Placeholder'
    return next()
