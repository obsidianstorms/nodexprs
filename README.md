# Demo NodeJS Express

## Setup
* run `make build`
* Fill in any [Secrets](#secret) or [Git Secrets](#gitsecret) as needed.
    
## Execute
* `make run`

## Development

### IntelliJ Config
* Preferences > Language & Frameworks > Javascript > Language Version: EMCAScript 6

### Docker Permissions
* Possible error during `make build`: `Got permission denied while trying to connect to the Docker daemon socket`
* Fix: In a terminal: `sudo usermod -a -G docker $USER`

## <a name="secret"></a>Secrets
* Fill in `config/secrets.json` with any credentials needed for target sites
    * Update `src/run.js` as needed

## <a name="gitsecret"></a>Git Secret
* Setup
    * Fill in `config/git-secret.txt` if it's generated and run `./init.sh` again
    * See below how to generate
* Create an access token
    * Follow this guide: https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/
    * For info reference: https://github.com/blog/1270-easier-builds-and-deployments-using-git-over-https-and-oauth
* If not present, create `git-secret.txt` in the config folder 
* Paste the token into the `git-secret.txt` file, no additional content or whitespaces.