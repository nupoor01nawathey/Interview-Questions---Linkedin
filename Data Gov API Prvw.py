# App registry is required to enable API with Purview
# Once completed it will provide client creds 
# If uploading/downloading files to/from adls make sure to have access enabled for Prvw app (it could be global read access, check with admin)

get_bearer_token
	url = fhttps://login.microsoftonline.com/your_tenant_id'/oauth2/token
	payload= f'grant_type=client_credentials&client_id=your_client_id&client_secret=your_client_secret&resource=73c2949e-da2d-457a-9607-fcc665198967'
	headers = {
		'Content-Type': 'application/x-www-form-urlencoded'
	}
	response = requests.request("POST", url, headers=headers, data=payload)
	access_token = json.loads(response.text)['access_token']



get_glossaries
	headers = {"Authorization" : f"Bearer get_bearer_token"}
	url = your_atlas_url + "/datamap/api/atlas/v2/glossary"
	response = requests.request("GET", url, headers=headers)



get_collection_level_assets
	url = https://your_atlas_url/account/collections?api-version=2019-11-01-preview
	headers = {"Authorization" : f"Bearer get_bearer_token", 'Content-type': 'application/json'}
	response = requests.request("GET", url, headers=headers)
	child_collection, parent_collection = {}, {}
	payload1 = []
	for collection in response.json()["value"]:
		if 'parentCollection' in collection:
			child_collection_id = collection['name']
			child_collection_name = collection['friendlyName']
			parent_collection_id = collection['parentCollection']['referenceName']
			child_collection[child_collection_id] = [child_collection_name, parent_collection_id]
			parent_collection.setdefault(parent_collection_id, []).append(child_collection_id)
	for parent_collection_id in parent_collection:    
		if parent_collection_id in child_collection and child_collection[parent_collection_id][0] == 'your_collection_name':
			for collection_id in parent_collection[parent_collection_id] :
				payload1.append({"collectionId": collection_id })
	
	url = your_atlas_url + "/datamap/api/search/query?api-version=2023-09-01"
	headers = {"Authorization" : f"Bearer get_bearer_token", 'Content-type': 'application/json'}
	payload = { "limit": 1000, "filter": { "and" : [{ "assetType": "Azure SQL Database" }, { "or" : payload1 } ]} } # Multiple asset types can be combined using OR instead of and here
	response = requests.request("POST", url, headers=headers, data=json.dumps(payload)) 



get_your_attributes
	headers = {"Authorization" : f"Bearer get_bearer_token"}
	attributes = {}
	for asset_guid in get_collection_level_assets.items(): # Collection may have 1000 assets but glossary available only for 10, filter such assets before extracting attributes here
		url = your_atlas_url + "/datamap/api/atlas/v2/entity/guid/" + asset_guid
		response = requests.request("GET", url, headers=headers)
		api_attributes =  response.json()
		

update_glossry_terms_attribute_level:
	url = your_atlas_url + "/datamap/api/atlas/v2/entity?api-version=2023-09-01"
	headers = {"Authorization": f"Bearer get_bearer_token", 'Content-type': 'application/json'}

	for key in combined_source_level_predefined_mapping: # this is nothing but the glossary excel but combined for all sources, 
    # this combining activity should be done programetically by keeping excel(s) in adls and using download API client provided from MSFT
		
	# Attach glossary terms to attributes
	payload = { "entity": {"typeName": "azure_sql_column","attributes": {"qualifiedName": from_get_your_attributes_qualified_api_url,"name": from_get_your_attributes_attribute_name,"data_type": from_get_your_attributes_attribute_datatype},"guid":from_get_your_attributes_attribute_guid, "relationshipAttributes": {"meanings": {"guid": your_glossary_guid, "typeName": "AtlasGlossaryTerm","displayText": your_glossary_term_name, "relationshipType": "AtlasGlossarySemanticAssignment","relationshipGuid": "-1","relationshipStatus": "ACTIVE","relationshipAttributes": {"typeName": "AtlasGlossarySemanticAssignment"}} }}}

	# Detach glossary terms from attributes
	payload = { "entity": {"typeName": "azure_sql_column","attributes": {"qualifiedName": qualifiedName,"name": name,"data_type": attribute_type},"guid":attribute_guid, "relationshipAttributes": {"meanings": []}} }
	
	requests.request("POST", url, headers=headers, data=json.dumps(payload))
	
