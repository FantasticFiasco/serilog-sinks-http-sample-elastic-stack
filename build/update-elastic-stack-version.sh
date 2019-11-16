#!/bin/bash
set -euxo pipefail

#echo "Host github.com" > ~/.ssh/config
#cat ~/.ssh/config

git remote set-url origin git@github.com:FantasticFiasco/serilog-sinks-http-sample-elastic-stack.git

git remote -v

cat ~/.ssh/known_hosts

echo "github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" > ~/.ssh/known_hosts

~/.ssh/known_hosts

git config user.name FantasticFiasco
git config user.email mattias.kindborg@gmail.com

git checkout $APPVEYOR_REPO_BRANCH

#echo "github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDgv/NJGiGXz3ABX3E11WG/U09B8w2NsErIGgpBWvQD03E7YUCgtmxXkPtTtX5bNcq106kf/ve7FGpb54ar1xThh27wWdE7syYWyv9tkM3J/WtAG2YFQT8etDFg/yoEZyWUxYQ6sBeqAkHmIhAjQd3gaPw0Mn6d/VJyk/f6dRWM13uSSEQwUj9Axsv1wCnYED2UFNJrirvZtiE7D7BnhIkeK+boImfrkq+8Jqb93fMqatkErmiTYGfjHOJSlyP64i2En83mqx0YMuce+4zqO+UPGtmf0FtyTGxeXYEhIBB99JGay1tFN6a9+q9sO42L/4RaCx3tJ804FOtY9+whynNU+cXug+bmWd7cyGSxZcYBM6yVmPz1+1qd6wxUSCHdVDuDjauW/Sl5ycThRc6cgU8Ui7KU/Dam8eku70CvuQwLACdbTqY4+v50XtBH2gWKqHEsdf8uJgGoMDj4+ZJjHfcoIG/uhrAQb9l6eVByNYVKlpRRcdRz68kdXluQag5Mn/YmcCjqNfzqm87il2niiUN+2o00TImeLAtmMC6ESsFq5EMGedmMlAtsm8iBhvWVjfFv+X0qmQnrWP0sD6j1jZdVnbn47o/sgEMjssAla8shy2zdZEZ9UrbA/AUPt9pGfhgJXd253lCbjSJuYQUI9p5RuwGJtmz+1d9pa1+1HBZ9dw==" > ~/.ssh/known_hosts

README=./README.md
DOCKERFILE_VERSION=`grep -oP '\d+\.\d+\.\d+' ./elastic-stack/elasticsearch/Dockerfile`

# Update Windows instructions
sed -i -E "s/\"kbn-version\", \"[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+\"/\"kbn-version\", \"${DOCKERFILE_VERSION}\"/g" $README

# Update Linux instructions
sed -i -E "s/'kbn-version: [[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+'/\'kbn-version: ${DOCKERFILE_VERSION}\'/g" $README



# Commit changes
git add $README
git diff-index --cached --quiet HEAD || git commit -m "docs(readme): update elastic version"
git push
