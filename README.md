> 
<img align="right" height="100" src="https://github.com/microsoft/OpenEduAnalytics/blob/main/docs/pics/oea-logo-nobg.png">

# Xporter Module
This module enables the orchestration and analysis of school data from Xporter.  Xporter is a common SIS data extraction tool installed in 20k schools in the UK, and supports the Community Brands porfolio of Education products in the US and internationally.  Over 100 EdTech partners use Xporter to provision data to their own products.  Use of this Xporter module for OEA enables Use Cases where integration with the school SIS is beneficial.
![image](https://github.com/Sarang-CommunityBrands/OEA/blob/main/docs/images/Xporter_module_overview_visual.PNG) 

For further details on Xporter including how it works for EdTech Partners, Local Authorities and Schools and Trusts see https://www.xporter.uk/

## Problem Statement and Module Impact
For effective Education Analytics it is important to have access to contextual information about the school, student and staff.  This contextual information may pertain to year groups, classes and courses but also on levels of special educational need, and aspects such as levels of family income deprivation.    In particular, when this information is aggregated across schooling systems it may reside in different student information systems (SIS).  Xporter provides a standardised schema solution to this challenge by calling multiple vendor-specific API, and this Module for OEA provides access to data following OEA standard practices inside a customers owned Azure Synapse infrastructure.

This module is therefore fundamental to both individual analysis of data from a supported SIS as well as using these data in combination with other OEA Modules, such as M365 and Insights to add contextual dimensions to student engagement and learning outcomes analysis (for example).

## Module Setup Instructions
This module has two pre-requisites and four main steps to complete the setup.  An overiew is as follows:
![image](https://github.com/Sarang-CommunityBrands/OEA/blob/main/docs/images/Xporter_module_setup_instructions.PNG) 

Step 1: (Pre-requisite) The module assumes that you have already established an OEA environment of at least v0.7.  If you do not already have an OEA environment available, please follow the steps available at https://github.com/microsoft/OpenEduAnalytics 

Step 2: (Pre-requisite for live operation, not required for Test data only) Live operation to your school data estate requires a subscription to Xporter for your institutions.  If you are an existing Xporter partner you may use your existing Relying Party and Secret for OEA.  For new subscriptions please see https://www.xporter.uk/become-a-partner/ or contact your Community Brands account manager.

Step 3: Open Cloud Shell in your Azure subscription (use ctrl+click on the button below to open in a new page)
[![Launch Cloud Shell](https://azurecomcdn.azureedge.net/mediahandler/acomblog/media/Default/blog/launchcloudshell.png "Launch Cloud Shell")](https://shell.azure.com/bash)\
Download the Xporter framework setup script and framework assets to your Azure clouddrive\
`cd clouddrive`\
`wget https://github.com/Sarang-CommunityBrands/OEA/blob/main/Xporter_OEA_setup.zip`\
`unzip ./Xporter_OEA_setup.zip`

Step 4: Use the Cloud Shell Editor to change the parameters in the final line in the xporter_module.ps1 script to represent your OEA environment:

* Param1 - Your Azure Subscription (for example 85b8c3b3-15d3-4099-aabc-15a34b4abb1a)
* Param2 - Your OEA Resource Group Name (for example rg-oea-yoursuffix)
* Param3 - Your Key Vault Name (for example kv-oea-yoursuffix)
* Param4 - Your Synapse Name (for example syn-oea-yoursuffix)
* Param5 - Your Spark Pool Name (for example spark3p2sm)

For example: \
`Set-OEA 85b8c3b3-15d3-4099-aabc-15a34b4abb1a rg-oea-yoursuffix kv-oea-yoursuffix syn-oea-yoursuffix spark3p2sm`

Hit CTRL+S to save the file (or right click and select Save)\
Run the setup script like this:\
`pwsh ./xporter_module.ps1`

## Data Sources
The following are the Xporter API endpoints that are supported in the current release:

1. [Schoolinfo](https://xporter.groupcall.com/Manage#Query-xod.1.SchoolInfo)
2. [Students](https://xporter.groupcall.com/Manage#Endpoint-1.school.students)
3. [Groups](https://xporter.groupcall.com/Manage#Query-xod.1.Groups)
4. [StudentMembers](https://xporter.groupcall.com/Manage#Query-xod.1.Groups)
5. [AttendanceSummary](https://xporter.groupcall.com/Manage#Query-xod.1.AttendanceSummary)
6. [Historical Attendance Summary](https://xporter.groupcall.com/Manage#Query-xod.1.HistoricalAttendanceSummary)

## Module Components 
Sample out-of-the box assets for this OEA module include: 
1. [Pipeline](https://github.com/Sarang-CommunityBrands/OEA/tree/main/pipeline) for ingesting data into the data lake and automating the various stages of the process.
2. [Notebook](https://github.com/Sarang-CommunityBrands/OEA/tree/main/notebook) for cleaning, transforming, anonymizing and enriching the data.
3. Test data configuration to hosted demo SIS instances which supports the module pipeline and Power BI template. 
4. [PowerBI Template](https://github.com/Sarang-CommunityBrands/OEA/tree/main/powerbi) for exploring, visualizing and deriving insights from the data.

## Module User Guide
A [User Guide](https://github.com/Sarang-CommunityBrands/OEA/tree/main/docs/xporterOEAmoduleuserguide.pdf) that explains further information about the use of the module and the Power BI template is available.


Community Brands UK and the Xporter Module [welcome contributions.](https://github.com/microsoft/OpenEduAnalytics/blob/main/docs/license/CONTRIBUTING.md) 

This module was developed by Community Brands UK in partnership with Greenwood Academies Trust and Dixons Academies Trust. The architecture and reference implementation for all modules is built on [Azure Synapse Analytics](https://azure.microsoft.com/en-us/services/synapse-analytics/) - with [Azure Data Lake Storage](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction) as the storage backbone,  and [Azure Active Directory](https://azure.microsoft.com/en-us/services/active-directory/) providing the role-based access control.

# Legal Notices

Microsoft and any contributors grant you a license to the Microsoft documentation and other content
in this repository under the [Creative Commons Attribution 4.0 International Public License](https://creativecommons.org/licenses/by/4.0/legalcode),
see the [LICENSE](https://github.com/microsoft/OpenEduAnalytics/blob/main/docs/license/LICENSE) file, and grant you a license to any code in the repository under the [MIT License](https://opensource.org/licenses/MIT), see the [LICENSE-CODE](https://github.com/microsoft/OpenEduAnalytics/blob/main/docs/license/LICENSE-CODE) file.

Microsoft, Windows, Microsoft Azure and/or other Microsoft products and services referenced in the documentation may be either trademarks or registered trademarks of Microsoft in the United States and/or other countries. The licenses for this project do not grant you rights to use any Microsoft names, logos, or trademarks. Microsoft's general trademark guidelines can be found at http://go.microsoft.com/fwlink/?LinkID=254653.

Privacy information can be found at https://privacy.microsoft.com/en-us/

Microsoft and any contributors reserve all other rights, whether under their respective copyrights, patents, or trademarks, whether by implication, estoppel or otherwise.