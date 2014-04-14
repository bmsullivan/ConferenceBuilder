// Generated by CoffeeScript 1.7.1
(function() {
  module.exports = function(req, res, next) {
    return Conference.find().limit(1).done(function(err, conference) {
      if (err) {
        return next(err);
      }
      res.locals.globalConference = conference && conference instanceof Array && conference.length > 0 ? conference[0] : {
        name: 'Name Placeholder',
        tagline: 'Tagline Placeholder'
      };
      return next();
    });
  };

}).call(this);

//# sourceMappingURL=global.map
