/**
 * UserController
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
    
  new: function(req, res) {
    res.view();
  },

  create: function(req, res, next) {
    var hasher = require('password-hash');
    var validator = require('../services/sailsValidator');

    var userObj = {
      firstName: req.param('firstName'),
      lastName: req.param('lastName'),
      email: req.param('email'),
      hashedPassword: hasher.generate(req.param('password'))
    };

    User.create(userObj).done(function (err, user){

      if(err){
        if (err.ValidationError) {

          req.session.flash = {
            err: validator(User, err.ValidationError)
          };

          return res.redirect('/user/new');
        }
      }

      res.redirect('/user');
    });
  },


  /**
   * Overrides for the settings in `config/controllers.js`
   * (specific to UserController)
   */
  _config: {}

  
};
