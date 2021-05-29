[![deploy status](https://gitlab.com/vdovhanych/dovh.gitlab.io/badges/master/pipeline.svg)](https://gitlab.com/vdovhanych/dovh.gitlab.io/-/commits/master)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [GitLab CI](#gitlab-ci)
- [Commit message example](#commit-message-example)
- [Building locally](#building-locally)
  - [Preview your site](#preview-your-site)
- [Troubleshooting](#troubleshooting)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## GitLab CI

This project's static Pages are built by [GitLab CI][ci], following the steps
defined in [`.gitlab-ci.yml`](.gitlab-ci.yml).

## Commit message example
Theme modifications:
 - feat(theme): what is new

Content:
 - post(new): new post
 -  post(edit): edit to the already existed post (what changed)

Ci configuration:
 - fix(ci) what is fixed or chagned.
 - feat(ci) This is resevers for new features in the ci only.

## Building locally

To work locally with this project, you'll have to follow the steps below:

1. Fork, clone or download this project
1. [Install][] Hugo
1. Preview your project: `hugo server`
1. Add content


Read more at Hugo's [documentation][].

### Preview your site
[My site](https://dovh.cz)

If you clone or download this project to your local computer and run `hugo server`,
your site can be accessed under `localhost:1313`.

The theme used is adapted from https://github.com/monkeyWzr/hugo-theme-cactus.

## Troubleshooting

1. CSS is missing! That means two things:

    Either that you have wrongly set up the CSS URL in your templates, or
    your static generator has a configuration option that needs to be explicitly
    set in order to serve static assets under a relative URL.

[ci]: https://about.gitlab.com/gitlab-ci/
[hugo]: https://gohugo.io
[install]: https://gohugo.io/overview/installing/
[documentation]: https://gohugo.io/overview/introduction/
[userpages]: http://doc.gitlab.com/ee/pages/README.html#user-or-group-pages
[projpages]: http://doc.gitlab.com/ee/pages/README.html#project-pages
[post]: https://about.gitlab.com/2016/04/07/gitlab-pages-setup/#custom-domains
