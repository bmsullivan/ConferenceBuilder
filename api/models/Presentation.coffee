module.exports =

  attributes:

    title:
      type: 'string'
      maxLength: 200
      required: true

    abstract:
      type: 'string'
      required: true

    level:
      type: 'string'
      required: true

    trackId:
      type: 'string'
      required: true

    userId:
      type: 'string'
      required: true
