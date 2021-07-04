[![deploy status](https://gitlab.com/vdovhanych/dovh.gitlab.io/badges/master/pipeline.svg)](https://gitlab.com/vdovhanych/dovh.gitlab.io/-/commits/master)
[![Lint Code Base](https://github.com/vdovhanych/website/workflows/Lint%20Code%20Base/badge.svg)](https://github.com/marketplace/actions/super-linter)
![GH Pages deploy](https://github.com/vdovhanych/website/actions/workflows/gh-pages.yml/badge.svg)

## Github action - deploy to gh pages
Using simple hugo extended script, defined in `gh-pages.yml`
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

[ci]: https://about.gitlab.com/gitlab-ci/
[hugo]: https://gohugo.io
[install]: https://gohugo.io/overview/installing/
[documentation]: https://gohugo.io/overview/introduction/
[userpages]: http://doc.gitlab.com/ee/pages/README.html#user-or-group-pages
[projpages]: http://doc.gitlab.com/ee/pages/README.html#project-pages
[post]: https://about.gitlab.com/2016/04/07/gitlab-pages-setup/#custom-domains
