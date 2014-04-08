/**
 * Conference
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

  attributes: {
  	
    name: {
      type: 'string',
      maxLength: 100
    },

    tagline: {
      type: 'string',
      maxLength: 100
    }
  }

};
