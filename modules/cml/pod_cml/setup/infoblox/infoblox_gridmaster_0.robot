*** Settings ***
Documentation          This robotfile executes the commands on a vnios node to configure it as a gridmaster
...                    usage:
...                    robot -v lab:'Infoblox_configurator' infoblox_gridmaster.robot 

Library                SSHLibrary

Suite Setup            Open Connection And Log In
Suite Teardown         Close All Connections

*** Variables ***
${HOST}                %{TF_VAR_cml_host}
${USERNAME}            %{TF_VAR_cml_username}
${PASSWORD}            %{TF_VAR_cml_password}
${ib_node}             Gridmaster
${ib_user}             %{ib_user}
${ib_pwd}              %{ib_pwd}
${ib_lan1_addr}        192.168.32.50
${ib_lan1_mask}        255.255.255.0
${ib_lan1_gw}          192.168.32.2
${ib_gm_vip}           192.168.32.49
${ib_gm_grid}          %{ib_grid}
${ib_gm_secret}        %{ib_grid_secret}

*** Test Cases ***
Set interfaces
    Configure LAN1 interface And Verify Return Code

    
Set licenses 
    Infoblox login
    Set nios license
    Infoblox login
    Set dns license
    Infoblox login
    Set dhcp license
    Infoblox login
    Set grid license

*** Keywords ***
Open Connection And Log In
   Open Connection                 ${HOST}
   Login                           ${USERNAME}         ${PASSWORD}
   Write                           open /${lab}/${ib_node}/0
   Infoblox_login

Infoblox login
   Write Until Expected Output     \n                  expected=login:     timeout=5 min 	retry_interval=0.5s
   Write                           ${ib_user}
   ${stdout}= 	                   Read Until          Local password:
   Write                           ${ib_pwd}
   ${stdout}=                      Read Until          Infoblox >

Set nios license
    [Documentation]                Configure temporary grid license
    ...                            The keyword returns the standard output by default. Flow:
    ...                            Infoblox > set temp_license 
    ...                            
    ...                              1. DNSone (DNS, DHCP)
    ...                              2. DNSone with Grid (DNS, DHCP, Grid)
    ...                              3. Network Services for Voice (DHCP, Grid)
    ...                              4. Add NIOS License
    ...                              5. Add DNS Server license
    ...                              6. Add DHCP Server license
    ...                              7. Add Grid license
    ...                              8. Add Microsoft management license
    ...                              9. Add Multi-Grid Management license
    ...                             10. Add Query Redirection license
    ...                             11. Add Response Policy Zones license
    ...                             12. Add FireEye license
    ...                             13. Add DNS Traffic Control license
    ...                             14. Add Cloud Network Automation license
    ...                             15. Add Security Ecosystem license
    ...                             16. Add Threat Analytics license
    ...                             17. Add Flex Grid Activation license
    ...                             18. Add Flex Grid Activation for Managed Services license
    ...                            
    ...                            Select license (1-18) or q to quit: 7
    ...                            
    ...                            This action will generate a temporary 60-day Add Grid license.
    ...                            Are you sure you want to do this? (y or n): y
    ...                            Grid temporary license installed.
    ...                            
    ...                            Temporary license is installed.
    ...                            
    ...                            
    ...                            The UI needs to be restarted in order to reflect license changes.
    ...                            Restart UI now, this will log out all UI users? (y or n):y
    ...                            
    ...                            Are you sure you want to do this? (y or n): y
    ...                            UI restarted.
    ...    
    Write                          set temp_license
    Read Until                     Select license (1-18) or q to quit:
    Write                          4
    Read Until                     Enter a number corresponding to a NIOS model (1 - 16) or q to quit:
    Write                          7
    Read until                     Are you sure you want to do this? (y or n):
    Write                          y
    Read Until                     Disconnect NOW if you have not been expressly authorized to use this system.

Set dns license
    [Documentation]                Configure temporary dns license
    ...                            The keyword returns the standard output by default. Flow:
    ...                            Infoblox > set temp_license 
    ...                            
    ...                              1. DNSone (DNS, DHCP)
    ...                              2. DNSone with Grid (DNS, DHCP, Grid)
    ...                              3. Network Services for Voice (DHCP, Grid)
    ...                              4. Add NIOS License
    ...                              5. Add DNS Server license
    ...                              6. Add DHCP Server license
    ...                              7. Add Grid license
    ...                              8. Add Microsoft management license
    ...                              9. Add Multi-Grid Management license
    ...                             10. Add Query Redirection license
    ...                             11. Add Response Policy Zones license
    ...                             12. Add FireEye license
    ...                             13. Add DNS Traffic Control license
    ...                             14. Add Cloud Network Automation license
    ...                             15. Add Security Ecosystem license
    ...                             16. Add Threat Analytics license
    ...                             17. Add Flex Grid Activation license
    ...                             18. Add Flex Grid Activation for Managed Services license
    ...                            
    ...                            Select license (1-18) or q to quit: 7
    ...                            
    ...                            This action will generate a temporary 60-day Add Grid license.
    ...                            Are you sure you want to do this? (y or n): y
    ...                            Grid temporary license installed.
    ...                            
    ...                            Temporary license is installed.
    ...                            
    ...                            
    ...                            The UI needs to be restarted in order to reflect license changes.
    ...                            Restart UI now, this will log out all UI users? (y or n):y
    ...                
    ...                            Are you sure you want to do this? (y or n): y
    ...                            UI restarted.
    ...    
    Write                          set temp_license
    Read Until                     Select license
    Write                          5
    Read until                     Are you sure you want to do this? (y or n):
    Write                          y
    Read until                     Restart UI now, this will log out all UI users? (y or n):
    Write                          y
    Read until                     Are you sure you want to do this? (y or n):
    Write                          y
    Write                          exit

Set dhcp license
    [Documentation]                Configure temporary dhcp license
    ...                            The keyword returns the standard output by default. Flow:
    ...                            Infoblox > set temp_license 
    ...                            
    ...                              1. DNSone (DNS, DHCP)
    ...                              2. DNSone with Grid (DNS, DHCP, Grid)
    ...                              3. Network Services for Voice (DHCP, Grid)
    ...                              4. Add NIOS License
    ...                              5. Add DNS Server license
    ...                              6. Add DHCP Server license
    ...                              7. Add Grid license
    ...                              8. Add Microsoft management license
    ...                              9. Add Multi-Grid Management license
    ...                             10. Add Query Redirection license
    ...                             11. Add Response Policy Zones license
    ...                             12. Add FireEye license
    ...                             13. Add DNS Traffic Control license
    ...                             14. Add Cloud Network Automation license
    ...                             15. Add Security Ecosystem license
    ...                             16. Add Threat Analytics license
    ...                             17. Add Flex Grid Activation license
    ...                             18. Add Flex Grid Activation for Managed Services license
    ...                            
    ...                            Select license (1-18) or q to quit: 7
    ...                            
    ...                            This action will generate a temporary 60-day Add Grid license.
    ...                            Are you sure you want to do this? (y or n): y
    ...                            Grid temporary license installed.
    ...                            
    ...                            Temporary license is installed.
    ...                            
    ...                            
    ...                            The UI needs to be restarted in order to reflect license changes.
    ...                            Restart UI now, this will log out all UI users? (y or n):y
    ...                            
    ...                            Are you sure you want to do this? (y or n): y
    ...                            UI restarted.
    ...    
    Write                          set temp_license
    Read Until                     Select license
    Write                          6
    Read until                     Are you sure you want to do this? (y or n):
    Write                          y
    Read until                     Restart UI now, this will log out all UI users? (y or n):
    Write                          y
    Read until                     Are you sure you want to do this? (y or n):
    Write                          y
    Write                          exit

Set grid license
    [Documentation]                Configure temporary grid license
    ...                            The keyword returns the standard output by default. Flow:
    ...                            Infoblox > set temp_license 
    ...                            
    ...                              1. DNSone (DNS, DHCP)
    ...                              2. DNSone with Grid (DNS, DHCP, Grid)
    ...                              3. Network Services for Voice (DHCP, Grid)
    ...                              4. Add NIOS License
    ...                              5. Add DNS Server license
    ...                              6. Add DHCP Server license
    ...                              7. Add Grid license
    ...                              8. Add Microsoft management license
    ...                              9. Add Multi-Grid Management license
    ...                             10. Add Query Redirection license
    ...                             11. Add Response Policy Zones license
    ...                             12. Add FireEye license
    ...                             13. Add DNS Traffic Control license
    ...                             14. Add Cloud Network Automation license
    ...                             15. Add Security Ecosystem license
    ...                             16. Add Threat Analytics license
    ...                             17. Add Flex Grid Activation license
    ...                             18. Add Flex Grid Activation for Managed Services license
    ...                            
    ...                            Select license (1-18) or q to quit: 7
    ...                            
    ...                            This action will generate a temporary 60-day Add Grid license.
    ...                            Are you sure you want to do this? (y or n): y
    ...                            Grid temporary license installed.
    ...                            
    ...                            Temporary license is installed.
    ...                            
    ...                            
    ...                            The UI needs to be restarted in order to reflect license changes.
    ...                            Restart UI now, this will log out all UI users? (y or n):y
    ...                            
    ...                            Are you sure you want to do this? (y or n): y
    ...                            UI restarted.
    ...    
    Write                          set temp_license
    Read Until                     Select license
    Write                          7
    Read until                     Are you sure you want to do this? (y or n):
    Write                          y
    Read until                     Restart UI now, this will log out all UI users? (y or n):
    Write                          y
    Read until                     Are you sure you want to do this? (y or n):
    Write                          y
    Write                          exit

Configure LAN1 interface And Verify Return Code
    [Documentation]                LAN1 interface is for internal traffic. Flow for member B:
    ...                            Enter IP address: 192.168.201.147
    ...                            Enter netmask [Default: 255.255.255.0]: 
    ...                            Enter gateway address [Default: 192.168.201.1]: 
    ...                            Enter VLAN tag [Default: Untagged]: 
    ...                            Configure IPv6 network settings? (y or n): n
    ...                            Become grid member? (y or n): n
    ...                            
    ...                             New Network Settings:
    ...                              IPv4 address:         192.168.201.147
    ...                              IPv4 Netmask:         255.255.255.0
    ...                              IPv4 Gateway address: 192.168.201.1
    ...                              IPv4 VLAN tag:        Untagged
    ...                            
    ...                             Old IPv4 Network Settings:
    ...                              IPv4 address:         192.168.1.2
    ...                              IPv4 Netmask:         255.255.255.0
    ...                              IPv4 Gateway address: 192.168.1.1
    ...                              IPv4 VLAN tag:        Untagged
    ...                                    Is this correct? (y or n): y
    ...                                    Are you sure? (y or n): y
    ...                            Network settings have been updated.
    ...                            
    ...                            Good Bye
    ...                            System restart...
    ...
    Write                          set network
    Read Until                     Enter IP address:
    Write                          ${ib_lan1_addr}
    Read Until                     Enter netmask [Default: 
    Write                          ${ib_lan1_mask}
    Read Until                     Enter gateway address [Default: 
    Write                          ${ib_lan1_gw}
    Read Until                     Enter VLAN tag [Default: 
    Write                          Untagged
    Read Until                     Configure IPv6 network settings? (y or n):
    Write                          n
    Read Until                     Become grid member? (y or n): 
    Write                          n
    Read Until                     Is this correct? (y or n): 
    Write                          y
    Read Until                     Are you sure? (y or n): 
    Write                          y
    Set Client Configuration       timeout=5 min
    Read Until                     Good Bye
