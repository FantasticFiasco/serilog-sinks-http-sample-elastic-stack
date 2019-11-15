#!/bin/bash
set -euxo pipefail

#echo "Host github.com" > ~/.ssh/config
#cat ~/.ssh/config

git remote set-url origin git@github.com:FantasticFiasco/serilog-sinks-http-sample-elastic-stack.git

git remote -v

git config user.name $GIT_USERNAME
git config user.email $GIT_EMAIL

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
