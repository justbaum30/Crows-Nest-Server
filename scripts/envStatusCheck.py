import urllib, urllib2
import subprocess, getopt, sys
import base64
import json
from urlparse import urlparse, parse_qs
from time import gmtime, strftime, sleep
 
'''
python userCheck.py -e 'https://tsys.mapi.discovercard.com/cardsvcs/acs/acct/v1/account' -u 6011008270041780 -p ccccc -t 0

python userCheck.py -e 'https://mocksolstice.herokuapp.com/discovercard/pb/play/cardsvcs/acs/acct/v1/account' -u 6011008270041780 -p ccccc -t 0

'''

def main(argv):
	endpoint = ''
	user = ''
	password = ''
	fileName = ''
	timer = 0

	#input data
	try:
		opts, args = getopt.getopt(argv,"e:u:p:f:t:",["endpoint=","user=","password=","file=","timer="])
	except getopt.GetoptError:
		print 'You have no idea how to use this, do not even try'
		sys.exit(2)
	for opt, arg in opts:
		if opt in ("-e", "--endpoint"):
			endpoint = arg
		if opt in ("-t", "--timer"):
			timer = arg
		if opt in ("-u", "--user"):
			user = arg
		elif opt in ("-p", "--password"):
			password = arg
	#run the script in a loop
	checkLoop(endpoint, user, password, timer)


def checkLoop(endpoint, user, password, timer):
	while(True):
		response = makeRequest(endpoint, user, password)
		print strftime("%Y-%m-%d %H:%M:%S"),
		if checkResponseStatus(response):
			print 'Server Up'
		else:
			print 'Server Down'
		sleep(float(timer))


def makeRequest(endpoint, user, password):
	authHeader = 'DCRDBasic ' + base64.b64encode(user + ': :' + password)
	headers = {'Authorization' : authHeader, 'X-Client-Platform' : 'iPhone'}
	request = urllib2.Request(endpoint, None, headers)

	try:
		response = urllib2.urlopen(request)
		return parseJSON(response, user)
	except urllib2.HTTPError, error:
		return parseJSON(error, user)


def parseJSON(response, user):
	responseBody = response.read()
	#add the http code and user to the response object
	jsonResponse = {
		"httpCode":response.getcode(),
		"user":user
	}
	if responseBody:
		try:
			jsonResponse.update(json.loads(responseBody))
		except ValueError:
			#No JSON response (Ex. servers down, html response)
			return jsonResponse
	return jsonResponse
	

def checkResponseStatus(r):
	if r['httpCode'] == 200:
		return True
	else:
		return False


#main
if __name__ == "__main__":
	main(sys.argv[1:])
