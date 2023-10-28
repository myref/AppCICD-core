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

Suite Setup       Open Browser   ${URL}      ${BROWSER1}       remote_url=http://seleniumffhost:4444    options=add_argument("--ignore-certificate-errors")
Suite Teardown    Close Browser

*** Test cases ***
Infoblox Login   
    Present credentials
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

${BROWSER1}                            firefox
${DELAY}                               0
${URL}                                 https://192.168.205.50
${HOST}                                %{TF_VAR_cml_host}
${USERNAME}                            %{TF_VAR_cml_username}
${PASSWORD}                            %{TF_VAR_cml_password}
${ib_node}                             Gridmaster
${ib_user}                             %{ib_user}
${ib_pwd}                              %{ib_pwd}
${ib_lan1_addr}                        192.168.205.50
${ib_lan1_mask}                        255.255.255.248
${ib_lan1_gw}                          192.168.205.49
${ib_gm_vip}                           192.168.205.50
${ib_gm_grid}                          %{ib_grid}
${ib_gm_secret}                        %{ib_grid_secret}

*** Keywords ***
Present credentials
    Wait Until Page Contains           Grid Manager
    Input Text                         Username                               ${ib_user}
    Input Text                         Password                               ${ib_user}
    Click Button                       Login

Accept EULA
    Wait Until Page Contains           Agreement
    Click Button                       I Accept

Data Collection Opt-out
    Wait Until Page Contains           Collection
    Click Button                       OK

Wait for Grid Setup popup
    Wait Until Page Contains           Grid Setup Wizard
    Click Element                      Configure a Grid Master
    Click Element                      Next

Configure Grid    
    Wait Until Page Contains           Grid Name
    Input Text                         Grid Name                               ${ib_gm_grid}
    Input Text                         Shared Secret                           ${ib_gm_secret}
    Input Text                         Confirm Shared Secret                   ${ib_gm_secret}
    Click Element                      Next

Configure Ports and Addresses
    Wait Until Page Contains           Ports and Addresses
    Click Element                      Next

Configure Admin Password
    Wait Until Page Contains           admin password
    Click Element                      Next

Configure Time Zone
    Wait Until Page Contains           Time Zone
    Click Element                      Next

Confirm Configuration
    Wait unitl Page Contains           standalone appliance
    Click Element                      Finish