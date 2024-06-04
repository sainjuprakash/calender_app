# calendar-app

## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.com/alpastechnology/alpalika-flutter.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://gitlab.com/alpastechnology/alpalika-flutter/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Automatically merge when pipeline succeeds](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing(SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Features

- Splash
- Localization
- Home
- Routing
- Themes
- Calendar
- Settings

## Libraries & Tools Used
- animate_do
- flex_color_scheme
- flutter
- flutter_bloc
- flutter_localizations
- intl
- nepali_date_picker
- nepali_utils
- shared_preferences

## Intial Setup for FVM

You have a few options to install FVM:

Install it as pub package:
```
dart pub global activate fvm
```

Install it by running the following command from Homebrew package manager (for MacOS and Linux):
```
brew tap leoafarias/fvm
brew install fvm
```

Install it by running the following command from your command line or PowerShell (for Windows):
```
choco install fvm
```

## Using FVM to run project

In this project, we are using flutter version 3.19.5, so we have to require that particular version in our system.

To do so we are using fvm commands to install flutter version 3.19.5

### FVM Version Install

Step 1:
```
fvm install 3.19.5
```

Step 2:
```
fvm list 
```
(check whether the version 3.19.5 is listed or not)

Step 3:
```
fvm use 3.19.5
```

Step 4:
```
fvm flutter doctor 
```
(confirm whether current flutter version is able to meet all requirements or not)

Step 4:
```
fvm flutter clean
```

Step 5:
```
fvm flutter pub get
```

Step 6:
```
fvm flutter run (running the project)
```
```
fvm flutter run -v (running the project with verbose)
```



## Here is the folder structure we have been using in this project

```
lib/
|- core/
|- cubit/
|- helpers/
|- l10n/
|- pages/
|- routes/
|- main.dart
