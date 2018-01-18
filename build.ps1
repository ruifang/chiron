if (!$Env:APPVEYOR_BUILD_NUMBER) { $Env:APPVEYOR_BUILD_NUMBER = "0" }
if (!$ENV:APPVEYOR_BUILD_VERSION) { $ENV:APPVEYOR_BUILD_VERSION = "1.0.0" }
if (!$ENV:DOCKER_PUSH) { $ENV:DOCKER_PUSH = $false }
if (!$ENV:APPVEYOR_REPO_BRANCH) { $ENV:APPVEYOR_REPO_BRANCH = "local" }

write-host "Build: $env:APPVEYOR_BUILD_NUMBER"
write-host "Version: $env:APPVEYOR_BUILD_VERSION"
write-host "Docker Push: $env:DOCKER_PUSH"

# docker-base
cd chiron-base;
$ENV:IMAGENAME = 'cortside/chiron-base'
./appveyor-build.ps1;
cd ..;

# auth
cd auth;
$ENV:IMAGENAME = 'cortside/chiron-auth'
./appveyor-build.ps1 $ENV:APPVEYOR_REPO_BRANCH $ENV:APPVEYOR_BUILD_VERSION $ENV:IMAGENAME;
cd ..;
