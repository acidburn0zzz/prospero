# Development workflow

#### 0. Pre-requisites

- Read carefully and accept the [Prospéro code of conduct](../CODE_OF_CONDUCT.md)
- Have a [Framagit](https://framagit.org/) account
- Enable [Two-Factor Authentication](https://framagit.org/profile/two_factor_auth) to your account
- Got to the [project's home page](https://framagit.org/lobster/prospero) and request developer accces by clicking on **Request access**
- Install version **2.0** or later of [Git](https://git-scm.com/downloads)

_If you have already performed step 1, please update your **develop** local branch by running the following:_

```sh
cd prospero
git checkout develop
git pull --rebase
```

_...then go straight [to step 2](#2-set-your-git-identity)._

#### 1. Clone repository

- Create a [Personal Access Token](https://framagit.org/profile/personal_access_tokens) with scopes **api**, **read_repository**, and **write_repository**
- Replace `<framagit_user>` with your Framagit username in the following command (e.g. lobster)
- Replace `<framagit_access_token>` with your Framagit access token in the following command (e.g. usaZay21sss8M6xrCD5g)

```sh
git clone https://<framagit_user>:<framagit_access_token>@framagit.org/lobster/prospero.git
```

_Example:_

```sh
git clone https://lobster:usaZay21sss8M6xrCD5g@framagit.org/lobster/prospero.git
```

Change to the project root directory before performing the next steps:

```sh
cd prospero
```

#### 2. Set your Git identity

_If you have already set user's name and e-mail to your Git configuration, you may skip this step._

Set the name and e-mail that will be written in your [commits](https://git-scm.com/docs/git-commit).


```sh
git config --local user.name "Your Name"
git config --local user.email email@domain.whatever
```

_Example_

```sh
git config --local user.name "Lobster"
git config --local user.email lobster@riseup.net
```

_If you may want to set this identity globally to all your Git projects, in this case replace `--local` with **`--global`** in the previous commands._

#### 3. Set automatic Pull rebase

_You have already set automatic Pull rebase to your Git configuration, you may skip this step._

In order to avoid useless [merge commits](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging) everytime you [pull remote branches](https://www.git-scm.com/docs/git-pull), please set automatic [Pull rebase](https://git-scm.com/book/en/v2/Git-Branching-Rebasing).

```sh
git config --local pull.rebase true
```

_You may want to set automatic Pull rebase to all your Git projects, in this case replace `--local` with **`--global`** in the previous command._

#### 4. Create your feature branch

Create a new branch named with `dev/` prefix.

```sh
git checkout -b dev/your-feature-name
```

_Example:_

```sh
git checkout -b dev/accounts-management
```

#### 5. Perform your local changes

Edit files, create atomic [commits](https://git-scm.com/docs/git-commit) with explicit and descriptive messages.

For example, **please do**:

```sh
git commit --message "Add license to README"
```

...instead of:

```sh
git commit --message "Update README"
```

#### 6. Push your branch to the remote repository

The first time you push a newly created branch, you need to create it in the remote repository:

```sh
git push --set-upstream origin dev/your-branch-name
```

_Example:_

```sh
git push --set-upstream origin dev/accounts-management
```

Since your branch have already been created in the remote repository, you can push new local changes by running:

```sh
git push
```

#### 7. Create a merge request

When your changes [work perfectly on your local machine](running_prospero_in_the_development_environment.md), no code-style offenses are detected, all tests pass, and you have pushed all your local changes to the remote repository, you are able to create a Merge Request by [clicking here](https://framagit.org/lobster/prospero/merge_requests/new).

- Select your feature branch as **source branch**
- Select **develop** as **target branch**
- Click on **Compare branches and continue**
- Add an explicit title and a complete description
- Click on **Submit merge request**

Wait for the pipeline to be executed for your branch, you should see something like the following at your merge request's page:
![](merge-request-pipeline.jpg)

- Make sure the pipeline has passed
- Make sure your merge request doesn't decrease the [current code coverage](https://lobster.frama.io/prospero/coverage)

If your merge request respects the previous conditions, edit it and assign it to another team member for reviewing. Othewise, repeat steps 5 and 6 until the merge request respects all required conditions.

#### 8. Wait for feedback

_The code review documentation will come soon..._

When everything is alright, your merge request will be merged. Congratulations!

## See also
- [Running Prospéro in the development environment](running_prospero_in_the_development_environment.md)
