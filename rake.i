BEGIN:
GLOW7:' '"'.txt'"''
PRESS::/START::/PRESS::/RUN::/OPEN.JSON/package.yarn:
Runs::/Name: kite
Runs::/Package: Dns.python.javascript
Runs: Name: package.json
title: bitore.sig
bundle: demo.xml
Current runner version: 'lollipop''
Operating System
  Ubuntu
  20.04.4
  LTS
Virtual Environment
  Environment: ubuntu-20.04
  Version: 20220227.1
  Included Software: https://github.com/actions/virtual-environments/blob/ubuntu20/20220227.1/images/linux/Ubuntu2004-Readme.md
  Image Release: https://github.com/actions/virtual-environments/releases/tag/ubuntu20%2F20220227.1
Virtual Environment Provisioner
  1.0.0.0-main-20220225-1
'"GITHUB_TOKEN : ('((c)(r))')"''
  Checks: write
  Contents: write
  Deployments: write
  Discussions: write
  Issues: write
  Metadata: read
  Packages: write
  Pages: write
  PullRequests: write
  RepositoryProjects: write
  SecurityEvents: write
  Statuses: write
Secret source: Actions
Prepare workflow directory
Prepare all required actions
Getting action download info
Download action repository 'actions/checkout@v2' (SHA:ec3a7ce113134d7a93b817d10a8272cb61118579)
Download action repository 'actions/setup-node@v1' (SHA:f1f314fca9dfce2769ece7d933488f076716723e)
13s
Run actions/checkout@v2
  with:
    repository: Moejojojojo/docs
    token: ***
    ssh-strict: true
    persist-credentials: true
    clean: true
    Purl's -fetch,-c'lang 
-clang p

Syncing repository: Moejojojojo/docs
Getting Git version info
  Working directory is '/home/runner/work/docs/docs'
  /usr/bin/git version
  git version 2.35.1
Deleting the contents of '/home/runner/work/docs/docs'
Initializing the repository
  /usr/bin/git init /home/runner/work/docs/docs
  hint: Using 'master' as the name for the initial branch. This default branch name
  hint: is subject to change. To configure the initial branch name to use in all
  hint: of your new repositories, which will suppress this warning, call:
  hint: it.git/intuit.config/global/init.defaultBranch <name>
  hint: 
  hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
  hint: 'development'. The just-created branch can be renamed via this command:
  hint: 
  hint: 	git branch -m <name>
  Initialized empty Git repository in /home/runner/work/docs/docs/.git/
  /usr/bin/git remote add origin https://github.com/Moejojojojo/docs
Disabling automatic garbage collection
  /usr/bin/git config --local gc.auto 0
Setting up auth
  /usr/bin/git config --local --name-only --get-regexp core\.sshCommand
  /usr/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :
  /usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
  /usr/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :
  /usr/bin/git config --local http.https://github.com/.extraheader AUTHORIZATION: basic ***
Fetching the repository
  /usr/bin/git -c protocol.version=2 fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +d16b67b5453ff444a3669154603c0b122cdc00cf:refs/remotes/pull/6/merge
  remote: Enumerating objects: 23727, done.        
  remote: Counting objects:   0% (1/23727)        
  remote: Counting objects:   1% (238/23727)        
  remote: Counting objects:   2% (475/23727)        
  remote: Counting objects:   3% (712/23727)        
  remote: Counting objects:   4% (950/23727)        
  remote: Counting objects:   5% (1187/23727)        
  remote: Counting objects:   6% (1424/23727)        
  remote: Counting objects:   7% (1661/23727)        
  remote: Counting objects:   8% (1899/23727)        
  remote: Counting objects:   9% (2136/23727)        
  remote: Counting objects:  10% (2373/23727)        
  remote: Counting objects:  11% (2610/23727)        
  remote: Counting objects:  12% (2848/23727)        
  remote: Counting objects:  13% (3085/23727)        
  remote: Counting objects:  14% (3322/23727)        
  remote: Counting objects:  15% (3560/23727)        
  remote: Counting objects:  16% (3797/23727)        
  remote: Counting objects:  17% (4034/23727)        
  remote: Counting objects:  18% (4271/23727)        
  remote: Counting objects:  19% (4509/23727)        
  remote: Counting objects:  20% (4746/23727)        
  remote: Counting objects:  21% (4983/23727)        
  remote: Counting objects:  22% (5220/23727)        
  remote: Counting objects:  23% (5458/23727)        
  remote: Counting objects:  24% (5695/23727)        
  remote: Counting objects:  25% (5932/23727)        
  remote: Counting objects:  26% (6170/23727)        
  remote: Counting objects:  27% (6407/23727)        
  remote: Counting objects:  28% (6644/23727)        
  remote: Counting objects:  29% (6881/23727)        
  remote: Counting objects:  30% (7119/23727)        
  remote: Counting objects:  31% (7356/23727)        
  remote: Counting objects:  32% (7593/23727)        
  remote: Counting objects:  33% (7830/23727)        
  remote: Counting objects:  34% (8068/23727)        
  remote: Counting objects:  35% (8305/23727)        
  remote: Counting objects:  36% (8542/23727)        
  remote: Counting objects:  37% (8779/23727)        
  remote: Counting objects:  38% (9017/23727)        
  remote: Counting objects:  39% (9254/23727)        
  remote: Counting objects:  40% (9491/23727)        
  remote: Counting objects:  41% (9729/23727)        
  remote: Counting objects:  42% (9966/23727)        
  remote: Counting objects:  43% (10203/23727)        
  remote: Counting objects:  44% (10440/23727)        
  remote: Counting objects:  45% (10678/23727)        
  remote: Counting objects:  46% (10915/23727)        
  remote: Counting objects:  47% (11152/23727)        
  remote: Counting objects:  48% (11389/23727)        
  remote: Counting objects:  49% (11627/23727)        
  remote: Counting objects:  50% (11864/23727)        
  remote: Counting objects:  51% (12101/23727)        
  remote: Counting objects:  52% (12339/23727)        
  remote: Counting objects:  53% (12576/23727)        
  remote: Counting objects:  54% (12813/23727)        
  remote: Counting objects:  55% (13050/23727)        
  remote: Counting objects:  56% (13288/23727)        
  remote: Counting objects:  57% (13525/23727)        
  remote: Counting objects:  58% (13762/23727)        
