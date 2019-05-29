#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

REPO_URL="${REPO_URL:-https://src-d.github.io/charts/}"
TARGET_BRANCH="${TARGET_BRANCH:-gh-pages}"
GH_REF="${GH_REF:-github.com/src-d/charts.git}"
GH_REMOTE_URL="https://$GITHUB_TOKEN@$GH_REF"

log_error() {
    printf '\e[31mERROR: %s\n\e[39m' "$1" >&2
}

helm init --client-only
helm repo add src-d "$REPO_URL"

packages_dir=$(mktemp -d)
index_dir=$(mktemp -d)
trap "rm -rf $packages_dir $index_dir" EXIT

pushd $packages_dir
git clone --branch=gh-pages --depth=1 "$GH_REMOTE_URL" .
git config user.email "infra@sourced.tech"
git config user.name "Infra sourced{d}"
mv index.yaml "$index_dir/index.yaml"
popd

for dir in $(ls | grep -vE '^scripts$|^docs$'); do
    [ -d "$dir" ] || continue
    if helm dependency build "$dir"; then
        helm package --destination "$packages_dir" "$dir"
    else
        log_error "Problem building dependencies of '$dir'."
        exit 1
     fi
done

if ! helm repo index --url "$REPO_URL" --merge "$index_dir/index.yaml" "$packages_dir"; then
    log_error "Exiting because unable to update index. Not safe to push update."
    exit 1
fi

cd $packages_dir
git add -A .
git commit -sm 'Updating helm packages and index'
git push "$GH_REMOTE_URL" "$TARGET_BRANCH:$TARGET_BRANCH"
