import looker_sdk
import argparse
import os
import re
import requests
import json
import os.path
from os import path
import github
 

arguments = argparse.ArgumentParser()
arguments.add_argument('--trial-client-id',type=str)
arguments.add_argument('--trial-client-secret',type=str)
arguments.add_argument('--googledemo-client-id',type=str)
arguments.add_argument('--googledemo-client-secret',type=str)
arguments.add_argument('--partnerdemo-client-id',type=str)
arguments.add_argument('--partnerdemo-client-secret',type=str)
arguments.add_argument('--project-name',type=str)
arguments.add_argument('--repo-name',type=str)
arguments.add_argument('--github-token',type=str)

args = arguments.parse_args()
g = github.Github(args.github_token)
project_name = args.project_name

<<<<<<< HEAD

failed_hosts = [] 

os.environ['LOOKERSDK_BASE_URL']='https://googledemo.looker.com'+str(':19999')
os.environ['LOOKERSDK_CLIENT_ID']='YVdpfr6hRkc5pfF6PDBD'
os.environ['LOOKERSDK_CLIENT_SECRET']='cCPZZCmDJp8RPt9FrK4dkvkZ'
project_name = 'sfdc_demo'

host_urls = ['https://googledemo.looker.com','https://partnerdemo.corp.looker.com','https://trial.looker.com']
hosts_short = [h.split('//')[1].split('.')[0] for h in host_urls]

for host_url, host_name in zip(host_urls,hosts_short):
    #sync dashboards for other instances
        os.environ['LOOKERSDK_BASE_URL']=host_url+str(':19999')
        if 'trial' in host_url:
            os.environ['LOOKERSDK_CLIENT_ID']=args.trial_client_id
            os.environ['LOOKERSDK_CLIENT_SECRET']=args.trial_client_secret
        elif 'googledemo' in host_url: 
            os.environ['LOOKERSDK_CLIENT_ID']=args.googledemo_client_id
            os.environ['LOOKERSDK_CLIENT_SECRET']=args.googledemo_client_secret
        else: 
            os.environ['LOOKERSDK_CLIENT_ID']=args.partnerdemo_client_id
            os.environ['LOOKERSDK_CLIENT_SECRET']=args.partnerdemo_client_secret
        
        sdk = looker_sdk.init31()

        #get the dashboard metadata from googledemo
        if 'googledemo' in host_url:
            #initialize spaces dict, which tells if we need to import into that host
            spaces = {}
            for h in hosts_short:
                spaces[h]=-1
            dashboards = json.loads(sdk.run_look('44',result_format='json'))
            dashboards_dict = {}
            for dash in dashboards:
                if dash['core_demos.lookml_project_name'] == project_name:
                    dashboards_dict[dash['demo_dashboards.development_dashboard_id']] = dash
                    for h in hosts_short:
                        if dash['demo_dashboards.' + h] is not None:
                            spaces[h] += 1
            dashboard_ids = dashboards_dict.keys()

            #get boardsmetadata
            dashboards_ = json.loads(sdk.run_look('47',result_format='json'))
            dashboards_board_dict = {}
            for dash in dashboards_:
                if dash['core_demos.lookml_project_name'] == project_name:
                    for h in hosts_short:
                        if dash['demo_use_cases.{}_board'.format(h)] is not None:  
                            if dash['demo_dashboards.development_dashboard_id'] in dashboards_board_dict.keys():
                                if 'trial' in dashboards_board_dict[dash['demo_dashboards.development_dashboard_id']].keys():
                                    dashboards_board_dict[dash['demo_dashboards.development_dashboard_id']][h].append(dash) 
                                else:
                                    dashboards_board_dict[dash['demo_dashboards.development_dashboard_id']][h] = [dash]
                            else:
                                dashboards_board_dict[dash['demo_dashboards.development_dashboard_id']]=dict()
                                dashboards_board_dict[dash['demo_dashboards.development_dashboard_id']][h] = [dash]
            
            #print(dashboards_board_dict)

        failed = -1
        #check if we should import into this host
        if spaces[host_name]>-1:
            print('Bringing project over to ', host_url)

            #hit deploy webhook
            response = requests.post(url = '{}/webhooks/projects/{}/deploy'.format(host_url,project_name))
            
            #if project doesnt exist create a new project and then sync the github repo
            if response.status_code == 404:
                print('Project Does Not Exist, creating project')
                sdk.update_session(looker_sdk.models.WriteApiSession(workspace_id="dev"))
                try: 
                    proj = sdk.project(project_name)
                    try:
                        key = sdk.git_deploy_key(proj.id)
                    except:
                        key = sdk.create_git_deploy_key(proj.id)
                except:
                    proj = sdk.create_project(looker_sdk.models.WriteProject(name=project_name))
                    key = sdk.create_git_deploy_key(proj.id)
                demo_repo = g.get_organization('looker').get_repo(args.repo_name)
                try:
                    demo_repo.create_key(title='Looker Deploy Key',key=key)
                except:
                    pass
                sdk.update_project(proj.id, looker_sdk.models.WriteProject(git_remote_url=demo_repo.ssh_url))

                git_tests = sdk.all_git_connection_tests(proj.id)
                for i, test in enumerate(git_tests):
                    result = sdk.run_git_connection_test(project_id=proj.id, test_id=test.id)
                    if result.status != 'pass':
                        failed += 1
                if failed >-1:
                    print('Cant create project / connect to git for', host_url)
                    failed_hosts.append(host_url)
                else:
                    sdk.create_git_branch(proj.id, looker_sdk.models.WriteGitBranch(name="initiate_remote",ref="origin/master"))
                    sdk.deploy_to_production(proj.id)
                    response = requests.post(url = '{}/webhooks/projects/{}/deploy'.format(host_url,project_name))
                
            # dash_files = [p for p in sdk.all_project_files(project_name) if p.type == 'dashboard']
            if failed < 0:
                for dash_id in dashboard_ids:
                    title = dashboards_dict[dash_id]['demo_dashboards.dashboard_name']

                    #lookml dashboards ID are generated from the model + title 
                    lookml_dash_id = dashboards_dict[dash_id]['demo_dashboards.lookml_dashboard_id']
                    space_id = dashboards_dict[dash_id]['demo_dashboards.'+ host_name]
    
                    #check to see if the dashboard exists in the space
                    exists = 0
                    slug = dashboards_dict[dash_id]['demo_dashboards.dashboard_slug']
                    for u_dash in sdk.space_dashboards(str(space_id)):
                        if u_dash.slug == slug:
                            exists = 1
                            new_dash = u_dash
                        
                    if exists:
                        print('Dashboard %s already exists, syncing it with LookML' %title)
                    else:
                        print('Dashboard %s does not yet exist, creating it in space %s' %(title, str(space_id)))
                    if exists == 1:
                        sdk.sync_lookml_dashboard(lookml_dash_id,looker_sdk.models.WriteDashboard())
                    #otherwise import using the dashboard id, to the given space
                    else:
                        #import the dashboard to the space
                        try: 
                            new_dash = sdk.import_lookml_dashboard(lookml_dash_id,str(space_id),{})
                        except:
                            print('LookML dashboard doesnt exist, check includes: ', lookml_dash_id)
                    
                    #set the slug 
                    sdk.update_dashboard(str(new_dash.id), looker_sdk.models.WriteDashboard(slug=slug))
                    
                    #check boards and pin to places list
                    #wont create the board if it doesnt exist but will create the use case if it doesnt exist
                    #wont unpin dashboard from other places
                    if host_name in dashboards_board_dict[dash_id].keys():
                        for i in range(len(dashboards_board_dict[dash_id][host_name])):
                            board_id = dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.{}_board'.format(host_name)].split('/')[-1]
                            #try:
                            board = sdk.homepage(str(board_id))
                            board_sections=board.homepage_sections
                            found_section = False
                            found_dash = False
                            for section in board_sections:
                                #check if its the right section
                                if section.title == dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_name']:
                                    found_section = True
                                    #update the description if its wrong
                                    #print(section.description, dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_description'])
                                    if section.description != dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_description']:
                                        print('Updating the description for ', section.title)
                                        sdk.update_homepage_section(section.id, looker_sdk.models.WriteHomepageSection(homepage_section_id=section.id,description=dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_description']))
                                    #check if board is already pinned
                                    for board_dash in section.homepage_items:
                                        if str(board_dash.dashboard_id) == str(new_dash.id):
                                            found_dash = True
                                            break
                                    #otherwise pin it
                                    if not found_dash:
                                        print('dashboard {} not on use case {}, pinning it'.format(new_dash.id, dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_name']))
                                        sdk.create_homepage_item(looker_sdk.models.WriteHomepageItem(homepage_section_id=section.id,dashboard_id=new_dash.id))
                                    break
                            if not found_section:
                                print('use case {} not found, creating it and pinning dashboard {}'.format(dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_name'], new_dash.id))
                                section = sdk.create_homepage_section(looker_sdk.models.WriteHomepageSection(homepage_id=board.id,title=dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_name'],
                                    description=dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_description']))
                                sdk.create_homepage_item(looker_sdk.models.WriteHomepageItem(homepage_section_id=section.id, dashboard_id=new_dash.id))
                            # except looker_sdk.error.SDKError:
                            #     print('Board {} doesnt exist'.format(board_id))
                        
        
=======
failed_hosts = [] 

host_urls = ['https://googledemo.looker.com','https://partnerdemo.corp.looker.com','https://trial.looker.com']
hosts_short = [h.split('//')[1].split('.')[0] for h in host_urls]

for host_url, host_name in zip(host_urls,hosts_short):
    #sync dashboards for other instances
        os.environ['LOOKERSDK_BASE_URL']=host_url+str(':19999')
        if 'trial' in host_url:
            os.environ['LOOKERSDK_CLIENT_ID']=args.trial_client_id
            os.environ['LOOKERSDK_CLIENT_SECRET']=args.trial_client_secret
        elif 'googledemo' in host_url: 
            os.environ['LOOKERSDK_CLIENT_ID']=args.googledemo_client_id
            os.environ['LOOKERSDK_CLIENT_SECRET']=args.googledemo_client_secret
        else: 
            os.environ['LOOKERSDK_CLIENT_ID']=args.partnerdemo_client_id
            os.environ['LOOKERSDK_CLIENT_SECRET']=args.partnerdemo_client_secret
        
        sdk = looker_sdk.init31()

        #get the dashboard metadata from googledemo
        if 'googledemo' in host_url:
            #initialize spaces dict, which tells if we need to import into that host
            spaces = {}
            for h in hosts_short:
                spaces[h]=-1
            dashboards = json.loads(sdk.run_look('44',result_format='json'))
            dashboards_dict = {}
            for dash in dashboards:
                if dash['core_demos.lookml_project_name'] == project_name:
                    dashboards_dict[dash['demo_dashboards.development_dashboard_id']] = dash
                    for h in hosts_short:
                        if dash['demo_dashboards.' + h] is not None:
                            spaces[h] += 1
            dashboard_ids = dashboards_dict.keys()

            #get boardsmetadata
            dashboards_ = json.loads(sdk.run_look('47',result_format='json'))
            dashboards_board_dict = {}
            for dash in dashboards_:
                if dash['core_demos.lookml_project_name'] == project_name:
                    for h in hosts_short:
                        if dash['demo_use_cases.{}_board'.format(h)] is not None:  
                            if dash['demo_dashboards.development_dashboard_id'] in dashboards_board_dict.keys():
                                if 'trial' in dashboards_board_dict[dash['demo_dashboards.development_dashboard_id']].keys():
                                    dashboards_board_dict[dash['demo_dashboards.development_dashboard_id']][h].append(dash) 
                                else:
                                    dashboards_board_dict[dash['demo_dashboards.development_dashboard_id']][h] = [dash]
                            else:
                                dashboards_board_dict[dash['demo_dashboards.development_dashboard_id']]=dict()
                                dashboards_board_dict[dash['demo_dashboards.development_dashboard_id']][h] = [dash]
            
            #print(dashboards_board_dict)

        failed = -1
        #check if we should import into this host
        if spaces[host_name]>-1:
            print('Bringing project over to ', host_url)

            #hit deploy webhook
            response = requests.post(url = '{}/webhooks/projects/{}/deploy'.format(host_url,project_name))
            
            #if project doesnt exist create a new project and then sync the github repo
            if response.status_code == 404:
                print('Project Does Not Exist, creating project')
                sdk.update_session(looker_sdk.models.WriteApiSession(workspace_id="dev"))
                try: 
                    proj = sdk.project(project_name)
                    try:
                        key = sdk.git_deploy_key(proj.id)
                    except:
                        key = sdk.create_git_deploy_key(proj.id)
                except:
                    proj = sdk.create_project(looker_sdk.models.WriteProject(name=project_name))
                    key = sdk.create_git_deploy_key(proj.id)
                demo_repo = g.get_organization('looker').get_repo(args.repo_name)
                try:
                    demo_repo.create_key(title='Looker Deploy Key',key=key)
                except:
                    pass
                sdk.update_project(proj.id, looker_sdk.models.WriteProject(git_remote_url=demo_repo.ssh_url))

                git_tests = sdk.all_git_connection_tests(proj.id)
                for i, test in enumerate(git_tests):
                    result = sdk.run_git_connection_test(project_id=proj.id, test_id=test.id)
                    if result.status != 'pass':
                        failed += 1
                if failed >-1:
                    print('Cant create project / connect to git for', host_url)
                    failed_hosts.append(host_url)
                else:
                    sdk.create_git_branch(proj.id, looker_sdk.models.WriteGitBranch(name="initiate_remote",ref="origin/master"))
                    sdk.deploy_to_production(proj.id)
                    response = requests.post(url = '{}/webhooks/projects/{}/deploy'.format(host_url,project_name))
                
            # dash_files = [p for p in sdk.all_project_files(project_name) if p.type == 'dashboard']
            if failed < 0:
                for dash_id in dashboard_ids:
                    title = dashboards_dict[dash_id]['demo_dashboards.dashboard_name']

                    #lookml dashboards ID are generated from the model + title 
                    lookml_dash_id = dashboards_dict[dash_id]['demo_dashboards.lookml_dashboard_id']
                    space_id = dashboards_dict[dash_id]['demo_dashboards.'+ host_name]
    
                    #check to see if the dashboard exists in the space
                    exists = 0
                    slug = dashboards_dict[dash_id]['demo_dashboards.dashboard_slug']
                    for u_dash in sdk.space_dashboards(str(space_id)):
                        if u_dash.slug == slug:
                            exists = 1
                            new_dash = u_dash
                        
                    if exists:
                        print('Dashboard %s already exists, syncing it with LookML' %title)
                    else:
                        print('Dashboard %s does not yet exist, creating it in space %s' %(title, str(space_id)))
                    if exists == 1:
                        sdk.sync_lookml_dashboard(lookml_dash_id,looker_sdk.models.WriteDashboard())
                    #otherwise import using the dashboard id, to the given space
                    else:
                        #import the dashboard to the space
                        try: 
                            new_dash = sdk.import_lookml_dashboard(lookml_dash_id,str(space_id),{})
                        except:
                            print('LookML dashboard doesnt exist, check includes: ', lookml_dash_id)
                    
                    #set the slug 
                    sdk.update_dashboard(str(new_dash.id), looker_sdk.models.WriteDashboard(slug=slug))
                    
                    #check boards and pin to places list
                    #wont create the board if it doesnt exist but will create the use case if it doesnt exist
                    #wont unpin dashboard from other places
                    if host_name in dashboards_board_dict[dash_id].keys():
                        for i in range(len(dashboards_board_dict[dash_id][host_name])):
                            board_id = dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.{}_board'.format(host_name)].split('/')[-1]
                            #try:
                            board = sdk.homepage(str(board_id))
                            board_sections=board.homepage_sections
                            found_section = False
                            found_dash = False
                            for section in board_sections:
                                #check if its the right section
                                if section.title == dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_name']:
                                    found_section = True
                                    #update the description if its wrong
                                    #print(section.description, dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_description'])
                                    if section.description != dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_description']:
                                        print('Updating the description for ', section.title)
                                        sdk.update_homepage_section(section.id, looker_sdk.models.WriteHomepageSection(homepage_section_id=section.id,description=dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_description']))
                                    #check if board is already pinned
                                    for board_dash in section.homepage_items:
                                        if str(board_dash.dashboard_id) == str(new_dash.id):
                                            found_dash = True
                                            break
                                    #otherwise pin it
                                    if not found_dash:
                                        print('dashboard {} not on use case {}, pinning it'.format(new_dash.id, dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_name']))
                                        sdk.create_homepage_item(looker_sdk.models.WriteHomepageItem(homepage_section_id=section.id,dashboard_id=new_dash.id))
                                    break
                            if not found_section:
                                print('use case {} not found, creating it and pinning dashboard {}'.format(dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_name'], new_dash.id))
                                section = sdk.create_homepage_section(looker_sdk.models.WriteHomepageSection(homepage_id=board.id,title=dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_name'],
                                    description=dashboards_board_dict[dash_id][host_name][i]['demo_use_cases.use_case_description']))
                                sdk.create_homepage_item(looker_sdk.models.WriteHomepageItem(homepage_section_id=section.id, dashboard_id=new_dash.id))
                            # except looker_sdk.error.SDKError:
                            #     print('Board {} doesnt exist'.format(board_id))
                        
        
>>>>>>> branch 'master' of git@github.com:looker/call_center_demo.git
