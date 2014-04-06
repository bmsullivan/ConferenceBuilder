/**
 * User
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

  schema: true,

  attributes: {

    firstName: {
      type: 'string',
      required: true,
      maxLength: 50
    },

    lastName: {
      type: 'string',
      required: true,
      maxLength: 50
    },

    email: {
      type: 'email',
      required: true
    },

    hashedPassword: {
      type: 'string'
    }
  },

  validation_messages: {
    firstName: {
      required: 'Please enter a First Name'
    }
  }

};
