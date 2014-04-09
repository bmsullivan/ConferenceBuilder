/**
 * ConferenceController
 *
 * @module      :: Controller
 * @description	:: A set of functions called `actions`.
 *
 *                 Actions contain code telling Sails how to respond to a certain type of request.
 *                 (i.e. do stuff, then send some JSON, show an HTML page, or redirect to another URL)
 *
 *                 You can configure the blueprint URLs which trigger these actions (`config/controllers.js`)
 *                 and/or override them with custom routes (`config/routes.js`)
 *
 *                 NOTE: The code you write here supports both HTTP and Socket.io automatically.
 *
 * @docs        :: http://sailsjs.org/#!documentation/controllers
 */

module.exports = {
    
  update: function(req, res, next) {
    if(req.method === 'GET') {
      Conference.find().limit(1).done(function(err, conf){
        if(err) { return next(err); }

        res.locals.conference = conf && conf instanceof Array ? conf[0] : { name: '', tagline: '' };
        return res.view();
      });
    }
    else {
      var confObj = {
        name: req.param('name'),
        tagline: req.param('tagline')
      };

      if(req.param('id') == '0') {
        Conference.create(confObj).done(function(err, conf) {
          if(err) { return next(err); }
          res.locals.conference = conf;
          return res.view();
        });
      } else {
        Conference.update(req.param('id'), confObj, function (err, confs) {
          if (err) {
            return next(err);
          }
          res.locals.conference = confs[0];
          return res.redirect('/conference/update');
        });
      }
    }
  },


  /**
   * Overrides for the settings in `config/controllers.js`
   * (specific to ConferenceController)
   */
  _config: {}

  
};
