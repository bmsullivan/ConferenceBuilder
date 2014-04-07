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
    
  create: function(req, res, next) {
    if(req.method === 'GET'){
      return res.view();
    }

    var hasher = require('password-hash');

    var userObj = {
      firstName: req.param('firstName'),
      lastName: req.param('lastName'),
      email: req.param('email'),
      hashedPassword: hasher.generate(req.param('password'))
    };

    if(req.param('password') !== req.param('confirmPassword')) {
      res.locals.flash = {
        error: {
          password: [
            {message: 'Password and Confirm Password do not match'}
          ]
        }
      };
      res.locals.user = userObj;

      return res.view();
    }

    User.create(userObj).done(function (err, user){

      if(err){
        if (err.ValidationError) {

          res.locals.flash = {
              error: err.ValidationError
          };
          res.locals.user = userObj;


          return res.view();
        }
      }

      res.redirect('/user');
    });
  },

  index: function(req, res, next){
    User.find().done(function(err, users){
      if(err) { return next(err); }

      res.locals.users = users;
      return res.view();
    });
  },

  update: function(req, res, next) {
    if(req.method === 'GET'){
      User.findOneById(req.param('id')).done(function(err, user){
        if(err){ return next(err); }
        res.locals.user = user;
        return res.view();
      });
    }
    else {

      if (req.user.isAdmin) {
        var userObj = {
          firstName: req.param('firstName'),
          lastName: req.param('lastName'),
          email: req.param('email'),
          isAdmin: req.param('isAdmin') == 'on'
        };
      }
      else {
        var userObj = {
          firstName: req.param('firstName'),
          lastName: req.param('lastName'),
          email: req.param('email')
        };
      }

      User.update(req.param('id'), userObj, function (err) {
        if (err) {
          return res.redirect('/user/update/' + req.param('id'));
        }

        res.redirect('/user');
      });
    }
  },

  /**
   * Overrides for the settings in `config/controllers.js`
   * (specific to UserController)
   */
  _config: {}

  
};
