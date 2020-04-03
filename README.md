# clean-repo-artifacts
Github Action  to Clean Repository artifacts

currently when using UploadArtifacts within Github workflow it isnt possible to delete them at the end of the workflow.
the current GithubAction that exist are purging all artifacts from repository.

this Action can be used to delete all artifacts from repository except the ones you want to exclude.

## Usage
```
name: Clean Repository Artifacts

on:
  push:    
  
jobs:
  deployment:
    runs-on: 'ubuntu-latest'
    steps:
      - uses: actions/checkout@v2     
      - uses: cleanRepoArtifacts
        with:
          exclude: "HTML Test report"
        env: 
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GITHUB_REPO: ${{ github.repository }}
```          
