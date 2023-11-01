*** Settings ***
Library                               SeleniumLibrary
Library                               OperatingSystem
Library                               XML
Documentation                         grid name  
...                                   Shared Secret
...                                   Shared Secret Retype
...                                   VPN port -> 1194 ...                    
...                                   advanced:
...                                   Enable GUI Redirect from Member -> on //*[@id="idae"]/html/body/div[25]/div[2]/div[1]/div/div/div/div[2]/div/div/div[1]/div/div/div/div/div/form/div[2]/div[1]/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[2]/input
...                                   Enable GUI/API Access via both MGMT and LAN1/VIP -> off
...                                   Enable Network Users Feature -> on
...                                   Enable Updates Of RIR Registrations -> off
...                                   Enable Informational GUI Banner -> on
...                                   Banner Color -> Red
...                                   Message -> Infoblox test appliance for testing in CML
...                                   Present the option of recursive deletion of networks or zones to -> All Users
...                                   Enable DNS Object Permissions in Networks and Ranges -> off
...                                   DSCP Value -> 0
...                                   Show Grid Visualization -> on
...                                   Show Restart Banner -> on
...                                   Require Name -> off ...                    

Suite Setup       Open Browser   https://${ib_gm_vip}      ${BROWSER1}       remote_url=http://172.17.0.2:4444    options=add_argument("--ignore-certificate-errors")
Suite Teardown    Close Browser

*** Test cases ***
Infoblox Login   
    Present credentials

Infoblox EULA and Data Collection 
    Accept EULA
    Data Collection Opt-out

Grid Setup
    Wait for Grid Setup popup
    Configure Grid
    Configure Ports and Addresses
    Configure Admin Password
    Configure Time Zone
    Confirm Configuration

*** Variables ***

${BROWSER1}                                firefox
${DELAY}                                   0
${HOST}                                    %{TF_VAR_cml_host}
${USERNAME}                                %{TF_VAR_cml_username}
${PASSWORD}                                %{TF_VAR_cml_password}
${ib_node}                                 Gridmaster
${ib_user}                                 %{ib_user}
${ib_pwd}                                  %{ib_pwd}
${ib_lan1_addr}                            192.168.32.50
${ib_lan1_mask}                            255.255.255.0
${ib_lan1_gw}                              192.168.32.49
${ib_gm_vip}                               192.168.32.50
${ib_gm_grid}                              %{ib_grid}
${ib_gm_secret}                            %{ib_grid_secret}
${ib_host_name}                            %{ib_host_name}

*** Keywords ***
Present credentials
    Sleep                                  10s
    Wait Until Page Contains               Grid Manager
    Input Text                             username                               ${ib_user}
    Input Text                             password                               ${ib_pwd}
    Click Button                           Login

Accept EULA
    Wait Until Element Is Visible          agreeButton                            timeout=5 min
    Click Button                           agreeButton

Data Collection Opt-out
    Wait Until Element Is Visible          agreeButton                            timeout=5 min
    Click Button                           OK

Wait for Grid Setup popup
    Wait Until Page Contains               Grid Setup Wizard                       timeout=5 min
    Wait Until Page Contains Element       name=view:welcomeStep:welcomeOption
    Click Element                          name=view:welcomeStep:welcomeOption
    Wait Until Page Contains Element       name=buttons:next
    Click Element                          name=buttons:next

Configure Grid    
    Wait Until Page Contains               Grid Name
    Input Text                             name=view:gridMasterStep:gridName               ${ib_gm_grid}
    Input Text                             name=view:gridMasterStep:pwdsharedSecret        ${ib_gm_secret}
    Input Text                             name=view:gridMasterStep:cnfSharedSecret        ${ib_gm_secret}
    Input Text                             name=view:gridMasterStep:hostName               ${ib_host_name}
    Click Element                          name=buttons:next

Configure Ports and Addresses
    Wait Until Page Contains               Ports and Addresses
    Wait Until Page Contains Element       name=buttons:next
    Click Element                          name=buttons:next

Configure Admin Password
    Wait Until Page Contains               admin password
    Wait Until Page Contains Element       name=buttons:next
    Click Element                          name=buttons:next

Configure Time Zone
    Wait Until Page Contains               Time Zone
    Wait Until Page Contains Element       name=buttons:next
    Click Element                          name=buttons:next

Confirm Configuration
    Wait until Page Contains               standalone appliance                    timeout=5 min
    Wait Until Page Contains Element       name=buttons:finish
    Click Element                          name=buttons:finish
 