# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p1 = Project.create(name: 'Discover')
endpoint_p1 = Endpoint.create(name: 'TSYS', endpoint_url: 'https://tsys.mapi.discovercard.com/cardsvcs/acs/acct/v1/account', project: p1)
Request.create(name: 'User 1', header:"{'Authorization':'DCRDBasic NjAxMTAwODI3MDA0MTc4MDogOmNjY2Nj','X-Client-Platform':'iPhone'}", endpoint: endpoint_p1)
Request.create(name: 'User 2', header:"{'Authorization':'DCRDBasic NjAxMTAwODI3MDA0MTc4MDogOmNjY2Nj','X-Client-Platform':'iPhone'}", endpoint: endpoint_p1)
Request.create(name: 'User 3', header:"{'Authorization':'DCRDBasic NjAxMTAwODI3MDA0MTc4MDogOmNjY2Nj','X-Client-Platform':'iPhone'}", endpoint: endpoint_p1)
Request.create(name: 'User 4', header:"{'Authorization':'DCRDBasic NjAxMTAwODI3MDA0MTc4MDogOmNjY2Nj','X-Client-Platform':'iPhone'}", endpoint: endpoint_p1)
p2 = Project.create(name: 'Mock Services')
endpoint_p2 = Endpoint.create(name: 'Login', endpoint_url: 'https://mocksolstice.herokuapp.com/discovercard/pb/play/cardsvcs/acs/acct/v1/account', project: p2)
Request.create(name: 'User 1', header:"", body:"", endpoint: endpoint_p2)
endpoint2_p2 = Endpoint.create(name: 'Transactions', endpoint_url: 'https://mocksolstice.herokuapp.com/discovercard/pb/play/cardsvcs/acs/stmt/v2/transaction', project: p2)
Request.create(name: 'User 1', header:"", body:"", endpoint: endpoint2_p2)