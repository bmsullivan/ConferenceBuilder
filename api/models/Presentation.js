/**
 * Presentation
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

  attributes: {

    title: {
      type: 'string',
      maxLength: 200
    },

    abstract: {
      type: 'string'
    },

    level: {
      type: 'string'
    }

  }

};
