request = require 'request'
qs = require 'querystring'

API_URL = 'https://www.dnt.no/api'

DNT = (client, key, opts) ->
  throw new Error('Client name is not defined') if not client
  throw new Error('API key is not defined') if not key

  @client   = client
  @key      = key
  @version  = if opts?.version then ".v#{opts.version}+json" else ''

  @

DNT.prototype.getMemberFor = (query, cb) ->
  return cb new Error('Empty query') if not Object.keys(query).length is 0
  @exec 'medlem', query, cb

DNT.prototype.getAssociationsFor = (query, cb) ->
  return cb new Error('Empty query') if not Object.keys(query).length is 0
  @exec 'forening', query, cb

DNT.prototype.exec = (endpoint, params, cb) ->
  params.autentisering = @key

  request
    uri: "#{API_URL}/#{endpoint}?#{qs.stringify(params)}"
    json: true
    headers:
      "Accept": "application/vnd.turistforeningen#{@version}"
      "User-Agent": @client
  , (err, res, body) ->
    cb err, res?.statusCode, body

module.exports = DNT

