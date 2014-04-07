var passport = require('passport'), LocalStrategy = require('passport-local').Strategy, hasher = require('password-hash');

passport.serializeUser(function(user, done){
  done(null, user.id);
});

passport.deserializeUser(function(id, done){
  User.findOneById(id).done(function(err, user){
    done(err, user);
  });
});

passport.use(new LocalStrategy({
  usernameField: 'email',
  passwordField: 'password'
}, function(email, password, done){
  User.findOne({email: email}).done(function(err, user){
    if(err){ return done(err); }

    if(!user) { return done(null, false, {message: 'Username and password combination is invalid'}); }

    if(!hasher.verify(password, user.hashedPassword)) { return done(null, false, {message: 'Username and password combination is invalid'}); }

    return done(null, user);
  })
}));
