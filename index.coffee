async = require 'async'

agent = require 'superagent'

module.exports = (data, sid, domain, ips, cb) ->
    iterator = (ip, callback) ->
        agent
        .put('http://' + ip)
        .type('json')
        .set('X-Update-Session', sid)
        .send(data)
        .end (res) ->
            if res.ok
                callback()
            else
                callback res.txt
    async.each ips, iterator, cb