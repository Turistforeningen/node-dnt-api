DNT = require '../src/dnt-api.coffee'
assert = require 'assert'

dnt = null
client = 'NodeJS Test Client/1.0.0'

beforeEach -> dnt = new DNT client, process.env.DNT_CONNECT_KEY

describe 'new DNT()', ->
  it 'should throw error for missing client name param', ->
    assert.throws(
      -> new DNT()
    , /Client name is not defined/)

  it 'should throw error for missing API key param', ->
    assert.throws(
      -> new DNT('myKey')
    , /API key is not defined/)

  it 'should make new API object instance', ->
    assert dnt instanceof DNT
    assert.equal dnt.client, client
    assert.equal dnt.key, process.env.DNT_CONNECT_KEY
    assert.equal dnt.version, ''

  it 'should be able to set API version', ->
    dnt = new DNT client, process.env.DNT_CONNECT_KEY, version: '99'

    assert dnt instanceof DNT
    assert.equal dnt.client, client
    assert.equal dnt.key, process.env.DNT_CONNECT_KEY
    assert.equal dnt.version, '.v99+json'

describe '#getMemberFor()', ->
  it 'should return error message for invalid API key', (done) ->
    @timeout 10000
    dnt = new DNT(client, 'IjA1ChOTDZjWxRwU/DBZTw==')

    dnt.getMemberFor sherpa_id: 10142, (err, status, body) ->
      assert.ifError err
      assert.equal status, 403
      assert.deepEqual body,
        errors: [
          message: "Invalid authentication"
          code: 1
        ]
      done()

  it 'should get member for sherpa id', (done) ->
    @timeout 10000

    dnt.getMemberFor sherpa_id: 10142, (err, status, body) ->
      assert.ifError err
      assert.equal status, 200
      assert.equal body.fornavn, 'Hans Kristian'
      done()

  it 'should get member for membership number', (done) ->
    @timeout 10000

    dnt.getMemberFor medlemsnummer: 1692762, (err, status, body) ->
      assert.ifError err
      assert.equal status, 200
      assert.equal body.fornavn, 'Hans Kristian'
      done()

  it 'should handle missing member gracefully', (done) ->
    @timeout 10000

    dnt.getMemberFor medlemsnummer: 1337, (err, status, body) ->
      assert.ifError err
      assert.equal status, 404
      assert.deepEqual body,
        errors: [
          message: "A member matching that sherpa_id, memberid, or both if both were provided, does not exist."
          code: 4
        ]
      done()

  it 'should handle invalid API version gracefully', (done) ->
    @timeout 10000
    dnt = new DNT client, process.env.DNT_CONNECT_KEY, version: '99'

    dnt.getMemberFor medlemsnummer: 1692762, (err, status, body) ->
      assert.ifError err
      assert.equal status, 400
      assert.deepEqual body,
        errors: [
          message: "You need to accept one of the following API versions in your media type: v0, v1"
          code: 2
        ]
      done()

