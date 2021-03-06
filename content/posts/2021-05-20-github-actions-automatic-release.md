---
title: Automatic release drafting to Github Releases
date: 2021-05-20 09:00:00
tags:
    - github
categories:
- automation
keywords:
    - actions
    - ci
    - github release
---
## Generate draft release on GitHub with GitHub Actions

I was trying to find a way to do GitHub releases with GitHub Actions or GitLab CI. When I happen to find semantic-release project. One of the benefits of GitHub Actions is that the majority of its users open source their workflows by default. I was able to kick start my workflow for keeping up with releases thanks to code from benmvp, a GitHub user and keynote speaker. This was a huge help with setting up our CI to create drafted releases directly to GitHub Release page.

```yaml
name: Release

on:
  push:
    branches:
      - master

jobs:
  main:
    name: Draft Release
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v1

      - name: Use Node v12
        uses: actions/setup-node@v1
        with:
          node-version: 12

      - name: Install dependencies
        run: npm ci

      - name: Double check unit tests
        run: npm test
        env:
          CI: true

      - name: Double check integration tests
        run: npm run integrate
        env:
          CI: true

      - name: Build package
        run: npm run build

      - name: Publish new version to GitHub Release
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: npx semantic-release
```
If you take a look at that workflow, you can see at the bottom that he’s using the npx command to leverage semantic-release directly with its CLI. GitHub Actions workflows allow you to run set runner environments and run shell commands. That solves the one problem, but I’m a big fan of actually automating my changelog as well.

I leverage actions to generate my release notes for projects. I discovered that it provides a changelog and bumps the version number in package.json file.


### Do the Github release from Gitlab CI pipline.

We can also use a lot simpler and more universal solution if we go with GitHub Cli tool. For this, to work we will need to create a base Docker image where this job of ours will run. You will also need to set GitlabCI environment variable "GITHUB_TOKEN" with your private token with access to full `repo:` and `org:read`

After this, you should be able to run the job and it will create a draft of your release. If you want to attach any files to the release simply specify the path at the end of "gh release" line with `./` if stored in your repository root folder.

Gitlab CI example job.
```yaml
script:
    - gh config set prompt disabled
    - VERSION=$(jq -r .version path/to_your_version_file/package.json)
    - gh release create --repo OWNER/PROJECTNAME --draft v${VERSION}  --title "v${VERSION}"
```

Tool needed inside dokcer file are [jq](https://stedolan.github.io/jq/) and [GIthubCLI](https://cli.github.com/)

