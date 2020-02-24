import sys
from twisted.internet import reactor
from twisted.web.client import Agent
from twisted.web.http_headers import Headers

def printHeaders( response ):
    print 'HTTP version: ', response.version
    print 'Status Code: ', response.code
    print 'Status Phrase: ', response.phrase
    print 'Response headers: '

    for header, value in response.headers.getAllRawHeaders():
        print '\t', header, value

def printError( failure ):
    print >>sys.stderr, failure

def stop():
    reactor.stop()


if len(sys.argv) != 2:
    print >>sys.stderr, "Usage: python download_url_headers.py URL"
    exit(1)

agent = Agent(reactor)
headers = Headers( { 'User-Agent': ['Twisted WebBot'], 'Content-Type': ['text/x-greeting'] } )
d = agent.request( 'HEAD', sys.argv[1], headers=headers )
d.addCallbacks( printHeaders, printError )
d.addBoth( stop )
reactor.run()

# HTTP version:  ('HTTP', 1, 1)
# Status Code:  200
# Status Phrase:  OK
# Response headers:
# Date ['Sun, 26 May 2013 16:47:59 GMT']
# X-Powered-By ['PHP/5.3.10-1ubuntu3.5']
# Content-Type ['text/html']
# Server ['Cherokee']

# HTTP version:  ('HTTP', 1, 1)
# Status Code:  200
# Status Phrase:  OK
# Response headers:
# Date ['Sun, 26 May 2013 16:48:54 GMT']
# Content-Length ['2151']
# Content-Type ['text/html; charset=utf-8']
# Server ['TwistedWeb/13.0.0']


