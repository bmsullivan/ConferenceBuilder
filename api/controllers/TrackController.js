// Generated by CoffeeScript 1.6.3
(function() {
  module.exports = {
    index: function(req, res, next) {
      return Track.find().done(function(err, tracks) {
        if (err) {
          return next(err);
        }
        res.locals.tracks = tracks;
        return res.view();
      });
    },
    create: function(req, res, next) {
      var t;
      if (req.method === 'GET') {
        return res.view();
      } else {
        t = {
          name: req.param('name')
        };
        return Track.create(t).done(function(err, track) {
          if (err) {
            if (err.ValidationError) {
              res.locals.flash = {
                error: err.ValidationError
              };
              res.locals.user = t;
              return res.view();
            }
          }
          return res.redirect('/track');
        });
      }
    }
  };

}).call(this);

/*
//@ sourceMappingURL=TrackController.map
*/
