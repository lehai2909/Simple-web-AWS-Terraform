var express = require('express');
var router = express.Router();

const AWS = require('aws-sdk');

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.render('users', { title: 'Users' });
});
router.post('/', function(req, res, next) {
  console.log(req.body.first_name);
  console.log(req.body.last_name);
  res.render('users', { title: 'Users' });

  const AWS = require('aws-sdk');

  AWS.config.update({
      region: "us-west-2"
    });

// Instantiate a DynamoDB document client with the SDK
  const dynamodb = new AWS.DynamoDB.DocumentClient();


  //const { DynamoDBClient, ListTablesCommand } = require("@aws-sdk/client-dynamodb");
  //const dynamodb = new DynamoDBClient({ region: "us-west-2" });
  // Use built-in module to get current date & time
  let date = new Date();
  // Store date and time in human-readable format in a variable
  let now = date.toISOString();
  // Define handler function, the entry point to our code for the Lambda service
  // We receive the object that triggers the function as a parameter
  firstName = req.body.first_name;
  lastName = req.body.last_name;

    // Extract values from event and format as strings
    let name = firstName + " " + lastName;
    // Create JSON object with parameters for DynamoDB and store in a variable
    let params = {
        TableName:'HelloWorldDatabase',
        Item: {
            'ID': name,
            'LatestLoginTime': now
        }
    };
    // Using await, make sure object writes to DynamoDB table before continuing execution
    dynamodb.put(params,function(err, data) {
        if (err) {
            console.error("Unable to add item. Error JSON:", JSON.stringify(err, null, 2));
        } else {
            console.log("Added item");
        }
    });
});
module.exports = router;
