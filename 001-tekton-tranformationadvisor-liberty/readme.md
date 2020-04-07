# Application Migration using Transformation Advisor and Tekton pipeline
 
 Migrating a Monolith JKE application into Liberty based container application by using Transformation advisor  migration artifacts and Tekton pipeline)

## Prerequisites

* Cloud Pak for Applications installed on Openshift cluster
* Transformation Advisor
* Tekton pipeline
* oc CLI
* git

## Overview

* View Migration Complexity in TA
* Push Migration artifacts to GIT Repo from TA
* Configure a Webhook in Tekton
* Modify source code in GIT
* View Tekton pipeline running
* View application deployed in OC
* Access the application in browser

## Steps

### 1. Migration Complexity in TA

#### 1. Open migration complexity page in TA.

The applications are assessed using TA Data collector and results are uploaded to TA. The migration complexity page is displaying the details of the application

The page shows the JKE application complexity as well. 

![Migration Complexity](images/01-ta-complexity-page1.png?raw=true "Migration Complexity")


#### 2. Click on the 3 dots on the right and choose the `View Migration Plan` option.

![View Migration Plan](images/02-ta-complexity-page2.png?raw=true "View Migration Plan")


### 2. Prepare Migration Bundle

#### 1. In the migration bundle screen choose the  `Binary` option.

![Choose Binary](images/03-ta-migration-1.png?raw=true "Choose Binary")

#### 2. In the displayed screen, click `Add` button and upload your war/ear file.

![Migration artifacts](images/04-ta-migration-2.png?raw=true "Migration artifacts")

#### 3. War file is uploaded and you can see the other migration artifacts as well.

![Migration artifacts](images/05-ta-migration-3.png?raw=true "Migration artifacts")


### 3. Push Migration Bundle to GIT

#### 1. Create a new empty repo in GIT for this application as like this.

![Git Repo](images/06-git-create-repo.png?raw=true "Git Repo")


#### 2. GIT details

a) Enter the `Git Repo`, `UserId`, `User Token` details 
b) Click `Send to Git` button in the TA.

![GIT Param](images/07-ta-git-1.png?raw=true "GIT Param")

The artifacts are being send to GIT

![Send to GIT](images/08-ta-git-2.png?raw=true "Send to GIT")

#### 3. See the artifacts are copied to GIT repo.

![Artifacts in GIT](images/09-git-after-bundle-push.png?raw=true "Artifacts in GIT")


### 4. Create Webhook in Tekton

#### 1. Install `ta-liberty-pipeline-pro` pipeline.

Here we are going to use the custom tekton pipeline created in the namespace `ta-liberty-pipeline-pro`. You don't need to install if it is already installed.

To install the pipeline you can refer the link [Installing ta-liberty-pipeline](https://github.com/GandhiCloudLab/tekton/tree/master/001-tekton-tranformationadvisor-liberty/ta-liberty-pipeline)

#### 2. Open Add Webhook page

Open the Tekton Web UI

1) Choose the namespace `ta-liberty-pipeline-pro`

2) Click on `Webhooks` in the left menu

3) Click on `Add Webhook` button in the Webhooks screen


![Create Webhook](images/12-tekton-webhook-create.png?raw=true "Create Webhook")

#### 3. Enter Webhook details

Enter Webhook details and click `create` button

| S.No| Property Name  | Values |  Comments | 
| ---|------------- | ------------- |-------------| 
|  1| Name  | jke  | Any name can be given| 
| 2 | Repository URL  |   | Your git repo url |
| 3  |   Access Token  | | Select the git-hub access token from the list. Otherwise click + button to enter Github user and Personal access token|
|  4| Namespace  | ta-liberty-pipeline-pro  | The namespace where the pipeline is available.|
|  5| Pipeline  | ta-liberty-pipeline-pipeline  | The name of the pipeline|
|  6| Service account  | ta-liberty-pipeline-service-account  |Service account|
|  7| Docker Registry  | index.docker.io/gandhicloud  | Your docker registry link|

![Create Webhook](images/13-tekton-webhook-entry.png?raw=true "Create Webhook")

#### 4. The webhook is created in Tekton like the below.

![ Webhook](images/14-tekton-webhook-created.png?raw=true " Webhook")

#### 5. See the webhook entry in the GIT repo as well.

![ Webhook in GIT](images/15-git-webhook-created.png?raw=true " Webhook in GIT")

### 5. Deploy App in Openshift using Tekton

1. Modify some files in GIT Repo and commit the file.

![ Modify file](images/16-git-modify-source.png?raw=true " Modify file")

2. Open the Tekton Web UI and click on the `PipelineRuns` menu. 

Tekton pipeline should have been started.

![ Tekton started](images/17-tekton-pipeline-started.png?raw=true " Tekton started")

3. Tekton pipeline running.

![ Tekton running](images/18-tekton-pipeline-running.png?raw=true " Tekton running")

4. Tekton pipeline completed.

![ Tekton completed](images/19-tekton-pipeline-completed.png?raw=true " Tekton completed")


### 6. View the Application Deployment in Openshift

1. Login into your Redhat Openshift Container Platform like below

```
oc login --token=NIqa12ewuV2AR-ZTAbG0v --server=https://api.ganwhite.os.fyre.ibm.com:6443
```

![ OC Login](images/20-oc-login.png?raw=true " OC Login")


2. Goto the `ta-liberty-pipeline-pro` namespace/project in Openshift

```
oc project ta-liberty-pipeline-pro
```

![ Switch Project](images/21-oc-project-switch.png?raw=true " Switch Project")


3. Get the PODs status by running the below comman d

```
oc get pods | grep jke
```

![ OC get pods](images/22-oc-get-pods.png?raw=true " OC get pods")


3. Get the service status by running below command

```
oc get service
```

![ OC get Service](images/23-oc-get-svc.png?raw=true " OC get Service")


### 7. Create Route in OCP web console 

1. Goto Route

Choose the Project `ta-liberty-pipeline-pro` and goto Route screen.

Click on the create Route.

![ Route ](images/24-route-1.png?raw=true " Route")

2. Enter Route details


a) Enter the Name (any value).

b) Choose Service

c) Choose Port

d) Click on Create

![ Route ](images/25-route-2.png?raw=true " Route")

3. Route is created.

![ Route ](images/26-route-3.png?raw=true " Route")


### 8. Access the application in the browser 

1. Get the above created url and access the application in the browser.

```
http://jke-ta-liberty-pipeline-pro.apps.ganwhite.os.fyre.ibm.com/jkeWeb
```

![ Application running](images/27-access-application.png?raw=true " Application running")

## Note

1. This pipeline is fully customized for TA generated Liberty artifacts.

2. Many application can be deployed using pipeline by creating different webhooks.

3. All the applications will be deployed under the namespace/project called `ta-liberty-pipeline-pro`. To deploy in different namesapce, you need to add `namespace: <<my-namespace>>` in the yaml files available under `operator` folder of the migration bundle artifacts.

