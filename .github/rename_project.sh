#!/usr/bin/env bash
while getopts a:n:d:u: flag
do
    case "${flag}" in
        a) author_name=${OPTARG};;
        n) project_name=${OPTARG};;
        d) project_description=${OPTARG};;
        u) github_username=${OPTARG};;
    esac
done

echo "Author: $author_name";
echo "Project Name: $project_name";
echo "Description: $project_description";
echo "GitHub Username: $github_username";

echo "Renaming project..."

original_author="author_name"
original_project_name="project_name"
original_project_description="project_description"
original_github_username="github_username"

for filename in $(git ls-files)
do
    sed -i "s/$original_author/$author_name/g" $filename
    sed -i "s/$original_project_name/$project_name/g" $filename
    sed -i "s/$original_project_description/$project_description/g" $filename
    sed -i "s/$original_github_username/$github_username/g" $filename
    echo "Renamed $filename"
done

mv src/project_name src/$project_name
echo "# $project_name\n\n$project_description" > README.md

# This command runs only once on GHA!
rm -rf .github/template.yml
