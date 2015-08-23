unless window?
  Backbone = require 'backbone'
  SockData = require './models/sockdata'
  ApiHero = {WebSock:{}}
  module.exports = Client
class ApiHero.WebSock.Client
  __streamHandlers:{}
  constructor:(@__addr, @__options={})->
    _.extend @, Backbone.Events
    @model = ApiHero.WebSock.SockData 
    @connect() unless @__options.auto_connect? and @__options.auto_connect is false
  connect:->
    @__conn = new connection @__options
    @
  addStream:(name,clazz)->
    return s if (s = @__streamHandlers[name])?
    @__streamHandlers[name] = clazz
    @
  removeStream:(name)->
    return null unless @__streamHandlers[name]?
    delete @__streamHandlers[name]
    @
  getClientId:->
    return null unless @socket?.io?.engine?
    @socket.io.engine.id