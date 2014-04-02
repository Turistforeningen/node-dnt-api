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

### New API Client

```javascript
var DNT = require('dnt-api');

var dnt = new DNT('My Application/1.0', 'myApiKey');
```

### getMemberFor(`object` query, `function` cb)

The `getMemberFor()` method is used to get details for a given member from the
membership register. The `query` parameter can at the moment have eith one of
two properties:

1. `sherpa_id` - which is the local user id for Sherpa 3.
2. `medlemsnummer` which is the membership number for a given membership.

```javascript
dnt.getMemberFor({ sherpa_id: 1234 }, function(err, statusCode, memberData) {
  if (err) { throw err }
  if (statusCode === 200) {
    console.log('Member is ' + memberData.fornavn);
  } else {
    console.error('Request failed! HTTP status code returned is ' + statusCode);
    console.error(memberData);
  }
});
```

The `statusCode` is `200` if the request succeded without errors. For other
staus codes the requests had some kind of error. You need to check the
`memberData.errors` property in order to find out why the error failed.

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
