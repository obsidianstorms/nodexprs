const express = require('express');
const app = express();
const bodyParser = require('body-parser');

const {
  Stat,
  RollValidation
} = require("./lib");

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

const port = process.env.PORT || 8080;

const router = express.Router();

// Define middleware for variety of tasks
// - authentication
// - data validations
router.use(function(req, res, next) {
  console.log("Middleware executed");
  next(); // Always end this section with this command
});


// Test route: http://localhost:8080/api
router.get('/', function(req, res) {
  res.json({message: "You made it." });
});

// Add additional routes
// ...
router.route('/stats')
  .post(function(req, res) {
    const roll = new RollValidation(); //RollValidation
    //catch

    console.log(req.body);
    const stat = new Stat();

    res.json({message:"Posted"});
  });



// Register routes with prefix
app.use('/api', router);

// Start Server
app.listen(port);
console.log(`Running server on port: ${port}`);
