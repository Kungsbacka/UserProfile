# UserProfile
UserProfile contains two parts: a web page (UserProfile) where a user can upload and crop a profile image and a Windows service (ADCommit) that takes uploaded images and writes them to the thumbnailPhoto attribute in Active Directory.

## Windows Integrated Authentication (WIA)
UserProfile uses WIA for authentication and to identify the user. Enable Windows authentication on the IIS site for the app to function properly. WIA and file upload has not worked properly on iOS in the past. That is why the app displays a warning for users with mobile devices. 

## Permissions
Make sure the application pool account can write to the Cache, Commit and Upload folders. The account that runs the ADCommit service must have read and write permissions to the Commit folder and permission to write to the thumbnailPhoto attribute.

## Install ADCommit service
The preferred way is to run the service with a Managed Service Account (MSA). Create a new MSA with New-ADServiceAccount, install it on the relevant server and install the service:

    sc.exe create ADCommit start= auto obj= [MSA] binPath= [Path to ADCommit.exe]

## Event log
ADCommit writes to the event log "ADCommit". Create log and source before starting the service:

    New-EventLog -LogName 'ADCommit' -Source 'ADCommit'
