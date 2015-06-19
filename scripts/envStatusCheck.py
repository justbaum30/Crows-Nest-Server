import urllib, urllib2
import subprocess, getopt, sys
import base64
import json
from urlparse import urlparse, parse_qs
from time import gmtime, strftime, sleep
 
'''

'''

def main(argv):

	backend_url = str(sys.argv[1])

	#Data from all projects
	projects_request = urllib2.Request("http://"+backend_url+"/projects.json")
	projects_response = urllib2.urlopen(projects_request).read()
	projects_json = json.loads(projects_response) #Array of projects

	while(True):
		checkProjectEndpoints(backend_url, projects_json)
		sleep(10)

	'''
		[
		  {
		    "id": 1,
		    "name": "Test Project",
		    "endpoints": [
		      {
		        "id": 1,
		        "name": "TSYS",
		        "endpoint_url": "https://tsys.mapi.discovercard.com/cardsvcs/acs/acct/v1/account",
		        "project_id": 1,
		        "requests": [
		          {
		            "id": 1,
		            "name": "Test Request",
		            "header": "{'Authorization':'DCRDBasic NjAxMTAwODI3MDA0MTc4MDogOmNjY2Nj','X-Client-Platform':'iPhone'}",
		            "body": "Things",
		            "endpoint_id": 1,
		            "status": true
		          }
		        ]
		      }
		    ]
		  }
		]
	'''

def checkProjectEndpoints(backend_url, projects_json):
	#Loop Projects
	for project in projects_json:
		print "\n\n#################### " + project['name'] + " ####################\n"
		#Loop endpoints
		for endpoint in project['endpoints']:
			print "\n  -    " + endpoint['name'] + "\n"
			#Loop Requests
			for request in endpoint['requests']:
				server_status = endpointStatus(endpoint,request)
				updateServerStatus(backend_url, request['id'], server_status)
				print strftime("%Y-%m-%d %H:%M:%S") + "  " + request['name'] + " --------- " + ("Server UP" if server_status else "Server DOWN")


def endpointStatus(endpoint, request):
	requestHeader_string = request['header'].replace("'", "\"")
	try:
		#Try to parse the header
		header = json.loads(requestHeader_string)
		request = urllib2.Request(endpoint['endpoint_url'], headers=header)
	except:
		#No header
		request = urllib2.Request(endpoint['endpoint_url'])

	#Make the server status call
	#The server will be UP if the status code is 200
	try:
		response = urllib2.urlopen(request)
		return response.getcode() == 200
	except urllib2.HTTPError, error:
		return False

def updateServerStatus(backend_url, request_id, status):
	payload = json.dumps({ "status" : status })
	headers = {"Content-Type": "application/json"}
	#status
	request = urllib2.Request("http://"+backend_url+"/requests/"+str(request_id), data=payload, headers=headers)
	request.get_method = lambda: 'PUT'
	try:
		response = urllib2.urlopen(request).read()
		print response
	except Exception, e:
		pass
	
	
#main
if __name__ == "__main__":
	main(sys.argv[1:])
