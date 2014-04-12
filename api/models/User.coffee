module.exports =

  schema: true

  attributes:

    firstName:
      type: 'string'
      required: true
      maxLength: 50


    lastName:
      type: 'string'
      required: true
      maxLength: 50


    email:
      type: 'email'
      required: true


    hashedPassword:
      type: 'string'


    isAdmin:
      type: 'boolean'
