# Dice Roller
Accept input on dice roll requirements.  Roll random number within parameters.  Provide value and conditions

## Stat Roller
### Description
As a player, I want to be able to roll ability scores or character stats using a variety of conditions.

### I/O Requirements
* Accept dice size
* Accept dice count
* Accept drop count
* Return total value 
* Return individual dice values

### System Requirements
* No database
  * This is purely input, calculate, output
* An endpoint to submit to
* A processor to run the dice roller
* JSON data structure for the input and output
* NodeJS / Typescript processor (EMCAScript 6)

### Functional Requirements
A number of dice (dice count) should pick a random number between and including 1 and a max value (dice size).
A drop count describes how many of the dice count to drop where they are the lowest value.
The returned sum should be the total additive value of the remaining dice.
The return list of dice should contain the individual values of each dice included in the returned sum.

* The API has to handle receiving data and returning a response.

#### Actions
* Accept JSON object
  * HTTP Request
  * dice max value
  * dice count
  * drop count
* Evaluate JSON elements
  * Make sure values are integers with an upperlimit
    * Return error if not integer
    * Return error with upperlimit described
* Run individual calculations a number of times matching dice count
  * random between 1 and provided max value
* Record individual calculations
  * collect each calculation 
  * reject calculation count matching drop count where value is the lowest
    * retain remaining calculations even if values match the dropped values
* Summarize calculations
  * add remaining values together
* Build return JSON object
  * return list of remaining individual calculation values
  * return total value
* Return JSON object
  * HTTP Response

#### Endpoints
* Path: /stats
* Controller: StatsController



### Future
Accept character name.  Override character name.  Pick a stat to reroll specific dice.  Override dice value with static specific value.
UUID instead of character name.  

### Troubleshooting
* Internal Docker to Hosting Permissions:
  * https://stackoverflow.com/questions/32001523/docker-cant-write-to-directory-mounted-using-v-unless-it-has-777-permissions#33347496
  * In each `*-host.sh` file, use sudo for `docker run`
  * Unnecessary if ssh into the docker host first
    * Recommended first to try ssh into the host
    * This issue really only comes up if running the command in the project directory while the system if mounted to another system
* Access to TTY
  * `docker exec -it $(docker ps -aqf "name=<containername>") /bin/bash <command>`

### Old Information
* package.json: `"main": "lib/index.js",`