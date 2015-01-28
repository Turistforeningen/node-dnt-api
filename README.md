DNT API ![Build Status](https://drone.io/github.com/Turistforeningen/node-dnt-api/status.png)
===========

Node.JS library for communicating with Turistforeningen's API.

**Table of Contents**

* [Requirements](#requirements)
* [Installing](#installing)
* [Usage](#usage)
  * [Class: DNT](#class-dnt)
    * [dnt.getMemberFor()](#dntgetmemberforobject-query-function-cb)
    * [dnt.getAssociationsFor()](#dntgetassociationsforobject-query-function-cb)

## Requirements

Require Node.JS version `>= 0.10`.

## Installing

```
npm install dnt-api --save
```

## Usage

```javascript
var DNT = require('dnt-api');
```

### Class: DNT

```javascript
var dnt = new DNT('My Application/1.0', 'myApiKey');
```

### dnt.getMemberFor(`object` query, `function` cb)

The `getMemberFor()` method is used to get details for a given member from the
membership register.

#### query parameter

The `query` parameter can at the moment have either one, or both, of the following
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

### dnt.getAssociationsFor(`object` query, `function` cb)

The `getAssociationsFor()` method is used to get associations (NO foreninger)
for a given member from the membership register.

#### query parameter

The `query` parameter can at the moment have either one, or both, of the following
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

## [MIT Licensed](https://github.com/Turistforeningen/node-dnt-api/blob/master/LICENSE)
