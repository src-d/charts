#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

REPO_NAME="${REPO_NAME:-stable}"
REPO_URL="${REPO_URL:-https://maartje.dev/charts-srcd/$REPO_NAME/}"
TARGET_BRANCH="${TARGET_BRANCH:-gh-pages}"
GH_REF="${GH_REF:-github.com/meyskens/charts.git}"
GH_REMOTE_URL="https://$GITHUB_TOKEN@$GH_REF"

log_error() {
    printf '\e[31mERROR: %s\n\e[39m' "$1" >&2
}

helm init --client-only
helm repo add "srcd-$REPO_NAME" "$REPO_URL"

packages_dir=$(mktemp -d)
repo_packages_dir="$packages_dir/$REPO_NAME"
index_dir=$(mktemp -d)
trap "rm -rf $packages_dir $index_dir" EXIT

pushd "$packages_dir"
git clone --branch=gh-pages --depth=1 "$GH_REMOTE_URL" .
git config user.email "infra@maartje.dev"
git config user.name "Charts sourced{d}"
[ -d "$REPO_NAME" ] || mkdir "$REPO_NAME"
pushd "$REPO_NAME"
[ -d "index.yaml" ] || touch index.yaml
mv index.yaml "$index_dir/index.yaml"
popd
popd

pushd "$REPO_NAME"
for dir in ./* ; do
    [ -d "$dir" ] || continue
    if helm dependency build "$dir"; then
        helm package --destination "$repo_packages_dir" "$dir"
    else
        log_error "Problem building dependencies of '$dir'."
        exit 1
     fi
done
popd

if ! helm repo index --url "$REPO_URL" --merge "$index_dir/index.yaml" "$repo_packages_dir"; then
    log_error "Exiting because unable to update index. Not safe to push update."
    exit 1
fi

cd "$packages_dir"
cat "$repo_packages_dir/index.yaml"
git add -A .
git commit -sm "Updating helm packages and index for $REPO_NAME"
git push "$GH_REMOTE_URL" "$TARGET_BRANCH:$TARGET_BRANCH"
