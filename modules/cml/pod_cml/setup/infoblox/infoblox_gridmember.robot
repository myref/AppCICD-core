*** Settings ***
Documentation                                      This robotfile executes the commands on a vnios node to configure it as a gridmember
...                                                usage:
...                                                robot -v lab:'CML-West Europe-ap01' -v MEMBER:'A' infoblox_gridmember.robot 
...                                                robot -v lab:'CML-West Europe-ap01' -v MEMBER:'B' -v ib_lan1_addr:'192.168.201.147' -v ib_mgmt_addr:'192.168.205.67' infoblox_gridmember.robot 
                            
Library                                            SSHLibrary
                            
Suite Setup                                        Open Connection And Log In
Suite Teardown                                     Close All Connections
                            
*** Variables ***                            
${HOST}                                            %{TF_VAR_cml_host}
${USERNAME}                                        %{TF_VAR_cml_username}
${PASSWORD}                                        %{TF_VAR_cml_password}
${ib_node}                                         Member ${MEMBER}
${ib_user}                                         %{ib_user}
${ib_pwd}                                          %{ib_pwd}
${ib_lan1_addr}                                    192.168.201.146
${ib_lan1_mask}                                    255.255.255.248
${ib_lan1_gw}                                      192.168.201.145
${ib_mgmt_addr}                                    192.168.205.66
${ib_mgmt_mask}                                    255.255.255.248
${ib_mgmt_gw}                                      192.168.205.65
${ib_gm_vip}                                       192.168.205.50
${ib_gm_grid}                                      %{ib_grid}
${ib_gm_secret}                                    %{ib_grid_secret}

*** Test Cases ***
Set interfaces
    Configure LAN1 interface And Verify Return Code
    Configure MGMT interface And Verify Return Code

Set licenses 
    Infoblox login
    Set grid license
    Infoblox login
    Set NIOS license

Add node to grid
    Infoblox login
    Configure Grid membership

*** Keywords ***
Open Connection And Log In
   Open Connection                                 ${HOST}
   Login                                           ${USERNAME}         ${PASSWORD}
   Write                                           open /${lab}/${ib_node}/0
   Infoblox_login                
                
Infoblox login                
   Write Until Expected Output                     \n                  expected=login:     timeout=5 min 	retry_interval=0.5s
   Write                                           ${ib_user}
   ${stdout}= 	                                   Read Until          Local password:
   Write                                           ${ib_pwd}
   ${stdout}=                                      Read Until          Infoblox >

Set nios license
    [Documentation]                                Configure temporary grid license
    ...                                            The keyword returns the standard output by default. Flow:
    ...                                            Infoblox > set temp_license 
    ...                                            
    ...                                              1. DNSone (DNS, DHCP)
    ...                                              2. DNSone with Grid (DNS, DHCP, Grid)
    ...                                              3. Network Services for Voice (DHCP, Grid)
    ...                                              4. Add NIOS License
    ...                                              5. Add DNS Server license
    ...                                              6. Add DHCP Server license
    ...                                              7. Add Grid license
    ...                                              8. Add Microsoft management license
    ...                                              9. Add Multi-Grid Management license
    ...                                             10. Add Query Redirection license
    ...                                             11. Add Response Policy Zones license
    ...                                             12. Add FireEye license
    ...                                             13. Add DNS Traffic Control license
    ...                                             14. Add Cloud Network Automation license
    ...                                             15. Add Security Ecosystem license
    ...                                             16. Add Threat Analytics license
    ...                                             17. Add Flex Grid Activation license
    ...                                             18. Add Flex Grid Activation for Managed Services license
    ...                                            
    ...                                            Select license (1-18) or q to quit: 7
    ...                                            
    ...                                            This action will generate a temporary 60-day Add Grid license.
    ...                                            Are you sure you want to do this? (y or n): y
    ...                                            Grid temporary license installed.
    ...                                            
    ...                                            Temporary license is installed.
    ...                                            
    ...                                            
    ...                                            The UI needs to be restarted in order to reflect license changes.
    ...                                            Restart UI now, this will log out all UI users? (y or n):y
    ...                                            
    ...                                            Are you sure you want to do this? (y or n): y
    ...                                            UI restarted.
    ...                    
    Write                                          set temp_license
    Read Until                                     Select license (1-18) or q to quit:
    Write                                          4
    Read Until                                     Enter a number corresponding to a NIOS model (1 - 16) or q to quit:
    Write                                          7
    Read until                                     Are you sure you want to do this? (y or n):
    Write                                          y
    Read Until                                     Disconnect NOW if you have not been expressly authorized to use this system.

Set grid license
    [Documentation]                                Configure temporary grid license
    ...                                            The keyword returns the standard output by default. Flow:
    ...                                            Infoblox > set temp_license 
    ...                                            
    ...                                              1. DNSone (DNS, DHCP)
    ...                                              2. DNSone with Grid (DNS, DHCP, Grid)
    ...                                              3. Network Services for Voice (DHCP, Grid)
    ...                                              4. Add NIOS License
    ...                                              5. Add DNS Server license
    ...                                              6. Add DHCP Server license
    ...                                              7. Add Grid license
    ...                                              8. Add Microsoft management license
    ...                                              9. Add Multi-Grid Management license
    ...                                             10. Add Query Redirection license
    ...                                             11. Add Response Policy Zones license
    ...                                             12. Add FireEye license
    ...                                             13. Add DNS Traffic Control license
    ...                                             14. Add Cloud Network Automation license
    ...                                             15. Add Security Ecosystem license
    ...                                             16. Add Threat Analytics license
    ...                                             17. Add Flex Grid Activation license
    ...                                             18. Add Flex Grid Activation for Managed Services license
    ...                                            
    ...                                            Select license (1-18) or q to quit: 7
    ...                                            
    ...                                            This action will generate a temporary 60-day Add Grid license.
    ...                                            Are you sure you want to do this? (y or n): y
    ...                                            Grid temporary license installed.
    ...                                            
    ...                                            Temporary license is installed.
    ...                                            
    ...                                            
    ...                                            The UI needs to be restarted in order to reflect license changes.
    ...                                            Restart UI now, this will log out all UI users? (y or n):y
    ...                                            
    ...                                            Are you sure you want to do this? (y or n): y
    ...                                            UI restarted.
    ...                    
    Write                                          set temp_license
    Read Until                                     Select license
    Write                                          7
    Read until                                     Are you sure you want to do this? (y or n):
    Write                                          y
    Read until                                     Restart UI now, this will log out all UI users? (y or n):
    Write                                          y
    Read until                                     Are you sure you want to do this? (y or n):
    Write                                          y
    Write                                          exit

Configure MGMT interface And Verify Return Code
    [Documentation]                                Infoblox > set interface mgmt
    ...                                            Enable Management port? (y or n): y
    ...                                            Enter Management IP address: 192.168.205.67
    ...                                            Enter Management netmask [Default: 255.255.255.0]: 255.255.255.248
    ...                                            Enter Management gateway address [Default: 192.168.205.65]: 
    ...                                            Configure Management IPv6 network settings? (y or n): n
    ...                                            Restrict Support and remote console access to MGMT port? (y or n): y
    ...                                              Management IPv4 address:         192.168.205.67
    ...                                              Management IPv4 netmask:         255.255.255.248
    ...                                              Management IPv4 Gateway address: 192.168.205.65
    ...                                              Restrict Support and remote console access to MGMT port: true
    ...                                                    Is this correct? (y or n):  y
    ...                                                    Are you sure? (y or n):  y
    ...                                             The management port settings have been updated         
    ...                
    Read Until                                     login:
    Write                                          ${ib_user}
    Read Until                                     password:
    Write                                          ${ib_pwd}
    Read Until                                     Infoblox >
    Write                                          set interface mgmt
    Read Until                                     Enable Management port? (y or n):
    Write                                          y
    Read Until                                     Enter Management IP address:
    Write                                          ${ib_mgmt_addr}
    Read Until                                     Enter Management netmask [Default: 
    Write                                          ${ib_mgmt_mask}
    Read Until                                     Enter Management gateway address [Default: 
    Write                                          ${ib_mgmt_gw}
    Read Until                                     Configure Management IPv6 network settings? (y or n):
    Write                                          n
    Read Until                                     Restrict Support and remote console access to MGMT port? (y or n):
    Write                                          y
    Read Until                                     Is this correct? (y or n): 
    Write                                          y
    Read Until                                     Are you sure? (y or n): 
    Write                                          y
    Read Until                                     The management port settings have been updated
    Write                                          exit

Configure LAN1 interface And Verify Return Code
    [Documentation]                                LAN1 interface is for internal traffic. Flow for member B:
    ...                                            Enter IP address: 192.168.201.147
    ...                                            Enter netmask [Default: 255.255.255.0]: 
    ...                                            Enter gateway address [Default: 192.168.201.1]: 
    ...                                            Enter VLAN tag [Default: Untagged]: 
    ...                                            Configure IPv6 network settings? (y or n): n
    ...                                            Become grid member? (y or n): n
    ...                                            
    ...                                             New Network Settings:
    ...                                              IPv4 address:         192.168.201.147
    ...                                              IPv4 Netmask:         255.255.255.0
    ...                                              IPv4 Gateway address: 192.168.201.1
    ...                                              IPv4 VLAN tag:        Untagged
    ...                                            
    ...                                             Old IPv4 Network Settings:
    ...                                              IPv4 address:         192.168.1.2
    ...                                              IPv4 Netmask:         255.255.255.0
    ...                                              IPv4 Gateway address: 192.168.1.1
    ...                                              IPv4 VLAN tag:        Untagged
    ...                                                    Is this correct? (y or n): y
    ...                                                    Are you sure? (y or n): y
    ...                                            Network settings have been updated.
    ...                                            
    ...                                            Good Bye
    ...                                            System restart...
    ...                
    Write                                          set network
    Read Until                                     Enter IP address:
    Write                                          ${ib_lan1_addr}
    Read Until                                     Enter netmask [Default: 
    Write                                          ${ib_lan1_mask}
    Read Until                                     Enter gateway address [Default: 
    Write                                          ${ib_lan1_gw}
    Read Until                                     Enter VLAN tag [Default: 
    Write                                          Untagged
    Read Until                                     Configure IPv6 network settings? (y or n):
    Write                                          n
    Read Until                                     Become grid member? (y or n): 
    Write                                          n
    Read Until                                     Is this correct? (y or n): 
    Write                                          y
    Read Until                                     Are you sure? (y or n): 
    Write                                          y
    Set Client Configuration                       timeout=5 min
    Read Until                                     Good Bye

Configure Grid membership
    [Documentation]                                Configure grid  
    ...                                            Join status: No previous attempt to join a grid.
    ...                                             Enter New Grid Master VIP: 192.168.205.50
    ...                                            Enter Grid Name [Default Infoblox]: cml.lab
    ...                                            Enter Grid Shared Secret: !IBvpn01
    ...                                            Enable grid services on the Management port? (y or n): y
    ...                                              Join grid as member using the Managment port with attributes:
    ...                                                 Grid Master VIP:     192.168.205.50
    ...                                                 Grid Name:           cml.lab
    ...                                                 Grid Shared Secret:  !IBvpn01
    ...                                            
    ...                                            WARNING: Joining a grid will replace all the data on this node!
    ...                                                    Is this correct? (y or n): y
    ...                                                    Are you sure? (y or n): y
    ...                                            NOTE: This node will not become an active member of the ID grid
    ...                                            until it has been configured on the grid master.
    ...                                            
    ...                                            Good Bye
    Write                                          set membership
    Read Until                                     Enter New Grid Master VIP:
    Write                                          ${ib_gm_vip}  
    Read Until                                     Enter Grid Name 
    Write                                          ${ib_gm_grid}
    Read Until                                     Enter Grid Shared Secret: 
    Write                                          ${ib_gm_secret}
    Read Until                                     Enable grid services on the Management port? 
    Write                                          y
    Read Until                                     Is this correct? (y or n): 
    Write                                          y
    Read Until                                     Are you sure? (y or n): 
    Write                                          y
    Set Client Configuration                       timeout=5 min
    ${output}=                                     Read Until                     Synchronizing time with the grid master. 

