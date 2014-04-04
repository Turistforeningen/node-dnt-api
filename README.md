DNT API![Build Status](https://drone.io/github.com/Turistforeningen/node-dnt-api/status.png)
===========

Node.JS library for communicating with Turistforeningen's API.

## Requires

Require Node.JS version `>= 0.10`.

## Install

```
npm install dnt-api --save
```

## Usage

```javascript
var DNT = require('dnt-api');
```

### New API Client

```javascript
var dnt = new DNT('My Application/1.0', 'myApiKey');
```

### getMemberFor(`object` query, `function` cb)

The `getMemberFor()` method is used to get details for a given member from the
membership register.

#### query parameter

The `query` parameter can at the moment have eith one, or both, of the following
properties:

1. `sherpa_id` - which is the local user id for Sherpa 3.
2. `medlemsnummer` which is the membership number for a given membership.

#### cb parameter

The callback function to this requests takes tree parameters:

1. `Error` err - this is an error if the HTTP request itself failed.
2. `number` statusCode - HTTP status code returned from the API.
3. `object` memberData - data returned from the API.

#### Example

```javascript
dnt.getMemberFor({ sherpa_id: 1234 }, function(err, statusCode, memberData) {
  if (err) { throw err }
  if (statusCode === 200) {
    console.log('Member is ' + memberData.fornavn);
  } else {
    console.error('Request failed! HTTP status code returned is ' + statusCode);
    console.error(memberData.errors);
  }
});
```

### getAssociationsFor(`object` query, `function` cb)

The `getAssociationsFor()` method is used to get associations (NO foreninger)
for a given member from the membership register.

#### query parameter

The `query` parameter can at the moment have eith one, or both, of the following
properties:

1. `bruker_sherpa_id` - which is the local user id for Sherpa 3.
2. `bruker_medlemsnummer` which is the membership number for a given membership.

#### cb parameter

The callback function to this requests takes tree parameters:

1. `Error` err - this is an error if the HTTP request itself failed.
2. `number` statusCode - HTTP status code returned from the API.
3. `Array` associations - data returned from the API.

#### Example

```javascript
dnt.getAssociationsFor({ bruker_sherpa_id: 1234 }, function(err, statusCode, associations) {
  if (err) { throw err }
  if (statusCode === 200) {
    for (var i = 0; i < associations.length; i++) {
      console.log('Member is associated with ' + associations[i].navn);
    }
  } else {
    console.error('Request failed! HTTP status code returned is ' + statusCode);
    console.error(associations.errors);
  }
});
```

## The MIT License (MIT)

Copyright (c) 2014 Turistforeningen

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
