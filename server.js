
const express = require('express')
const js = require('jsearch')
const app = express()
const MongoClient = require("mongodb").MongoClient;
var schedule = require('node-schedule');
const port = 3000




var d = null
var collection = null
var product = 'car'
//mongodb link here

mongoClient.connect(function (err, client) {

  if (err) {
    return console.log(err);
  }

  d = client.db("advertisement_analyzer");
  collection = d.collection("Users")
  collection1 = d.collection("AnalyzerFiles")
  collection2 = d.collection("ActionList")
  collection3 = d.collection("Product_Analyzer")
  collection4 = d.collection("Reports")
  // взаимодействие с базой данных
});



var callback = function (data) {
  console.log(data)
}


app.get("/", (request, response) => {
  //response.send('Hello from Express!')
  collection.find({}).toArray(function (err, person) {
    console.log(JSON.stringify(person, null, 2));
    response.send(person)
  });
})

// Parse URL-encoded bodies (as sent by HTML forms)
app.use(express.urlencoded());

// Parse JSON bodies (as sent by API clients)
app.use(express.json());

// Access the parse results as request.body
// app.post('/', function(request, response){
//    //console.log(request.body);
//     // var query = { name: request.body.name };
//     // collection.deleteOne(query, function(err, obj) {
//     //     if (err) throw err;
//     //     console.log("1 document deleted");
//     //   });
//    var doc = { login: request.body.login, password:  request.body.password};
//     collection.insertOne(request.body, function(err, res) {
//         if (err) throw err;
//         console.log("Document inserted");
//         // close the connection to db when you are done with it
//     });
// });

app.post('/edit', function (request, response) {
  // console.log(request.body)
  var myquery = { name: request.body.name };
  var newvalues = { $set: { player2Ships: request.body.player2Ships, player2Ready: true } };
  collection.updateOne(myquery, newvalues, function (err, res) {
    if (err) throw err;
    console.log("1 document updated");
  });
});
var j = schedule.scheduleJob('0 0 * * *',function () {
  var count = 0;
  collection1.find().toArray(function (err, user) {
    // hanlde err..
    if (user) {
      //console.log(user[0].name)
      user.forEach(element => async function(){
        let promise = new Promise((resolve, reject) => {
          js.google(element.productName, 1, async function (response) {
          //console.log(response.length); // for Google results 
          count += response.length;
        })
        setTimeout(() => resolve("готово!"), 1000)
      })
        let result = await promise;
        var date = new Date();
        var month = date.getMonth()() + 1;
        var year = date.getFullYear();
        var date = date.getDate();
        var doc = { name: "Google", product: element.productName, month: month, year: year, date: date, results: count };
        collection3.insertOne(doc, function (err, res) {
          if (err) throw err;
          console.log("Document inserted");
          // close the connection to db when you are done with it
        });
      });
      // user exists 
    }
  })
});
app.post('/', function (request, response) {
  // use `findOne` rather than `find`
  //console.log(request.body)
//   var count = 0;
//   let promise = new Promise((resolve, reject) => {
//     js.google("MyProduct", 1, function (response) {
//     //console.log(response); // for Google results 
//     count += response.length;
//   })
//   setTimeout(() => resolve("готово!"), 1000)
// })
//   let result = await promise;
  // console.log(count)
  collection.findOne({ 'login': request.body.login }, function (err, user) {
    // hanlde err..
    if (user) {
      response.send(user)
      // user exists 
    } else {
      var doc = { login: request.body.login, password: request.body.password };
      collection.insertOne(request.body, function (err, res) {
        if (err) throw err;
        console.log("Document inserted");
        response.send("inserted")
        // close the connection to db when you are done with it
      });
      // user does not exist
    }
  })
})

app.post('/file', function (request, response) {
  // use `findOne` rather than `find`
  //console.log(request.body)
  collection1.findOne({ 'name': request.body.name }, function (err, user) {
    // hanlde err..
    if (user) {
      response.send("false")
      // user exists 
    } else {
      var doc = {
        name: request.body.name, budget: request.body.budget, startMonth: request.body.startMonth, startYear: request.body.startYear,
        startWeek: request.body.StartWeek, sourceWay: request.body.sourceName, userNames: request.body.userNames
      };
      collection1.insertOne(request.body, function (err, res) {
        if (err) throw err;
        console.log("Document inserted");
        // close the connection to db when you are done with it
      });
      // user does not exist
    }
  })
})

app.post('/report', function (request, response) {
  // use `findOne` rather than `find`
  //console.log(request.body)
  collection4.insertOne(request.body, function (err, res) {
    if (err) throw err;
    console.log("Report inserted");
    // close the connection to db when you are done with it
  });
  // user does not exist
})

app.post('/list', function (request, response) {
  // use `findOne` rather than `find`
  //console.log(request.body)
  collection2.insertOne(request.body, function (err, res) {
    if (err) throw err;
    console.log("Document inserted");
    // close the connection to db when you are done with it
  });
})

app.post('/findFiles', async function (request, response) {
  // use `findOne` rather than `find`
  //console.log(request.body)
  var names = []
  let promise = new Promise((resolve, reject) => {
    collection1.find({ 'userNames': request.body.login }).toArray(function (err, user) {
      // hanlde err..
      if (user) {
        //console.log(user[0].name)
        user.forEach(element => {
          names.push(element.name);
        });
        // user exists 
      }
    })
    collection1.find({ 'defaultUserNames': request.body.login }).toArray(function (err, user) {
      // hanlde err..
      if (user) {
        //console.log(user[0].name)
        user.forEach(element => {
          names.push(element.name);
        });
        // user exists 
      }
    })
    setTimeout(() => resolve("готово!"), 1000)
  })
  let result = await promise;
  response.send(names)
})

app.post('/findData', async function (request, response) {
  // use `findOne` rather than `find`
  //console.log(request.body)
  var d1 = null
  var collection6 = null
  console.log(request.body.name)
  const mongoClient1 = new MongoClient(request.body.name, { useNewUrlParser: true, useUnifiedTopology: true  });
  let promise = new Promise((resolve, reject) => {
    mongoClient1.connect(function (err, client) {

      if (err) {
        return console.log(err);
      }

      d1 = client.db(request.body.dbname);
      collection6 = d1.collection(request.body.collection)
      console.log(d1)
      console.log(collection6)
      setTimeout(() => resolve("готово!"), 1000)
      // взаимодействие с базой данных
    });
  });
  let result = await promise;
  collection6.find().toArray(function (err, user) {
    // hanlde err..
    if (user) {
      console.log("3")
      //console.log(user[0].name)
      response.send(user)
      // user exists 
    }
    else {
      console.log(err)
    }
    mongoClient1.close()
  })
})

app.post('/addData', async function (request, response) {
  // use `findOne` rather than `find`
  //console.log(request.body)
  var d1 = null
  var collection6 = null
  //mongodb link here
  
  let promise = new Promise((resolve, reject) => {
    mongoClient1.connect(function (err, client) {

      if (err) {
        console.log(111)
        return console.log(err);
      }

      d1 = client.db("test_for_analyzer");
      collection6 = d1.collection("test");
      setTimeout(() => resolve("готово!"), 1000)
      // взаимодействие с базой данных
    });
  });
  let result = await promise;
  collection6.insertOne(request.body, function (err, res) {
    if (err) throw err;
    console.log("Data inserted");
    response.send("true")
    // close the connection to db when you are done with it
    mongoClient1.close()
  });
  // user does not exist
})

app.post('/findFile', function (request, response) {
  // use `findOne` rather than `find`
  //console.log(request.body)
  collection1.findOne({ 'name': request.body.name }, (function (err, user) {
    // hanlde err..
    if (user) {
      //console.log(user[0].name)
      response.send(user)
      // user exists 
    }
  })
  )
})
app.post('/findProduct', function (request, response) {
  // use `findOne` rather than `find`
  //console.log(request.body)
  var data = []
  collection3.find().toArray(function (err, user) {
    // hanlde err..
    if (user) {
      //console.log(user[0].name)
      // user.forEach(element => {
      //   if (element.product == request.body.name){
      //     data.push(element.results);
      //   }
      // });
      // user exists 
      response.send(user)
    }
    //response.send(data)
  })
})

app.post('/changeUser', function (request, response) {
  // use `findOne` rather than `find`
  //console.log(request.body)
  var names = []
  var names1 = []
  collection1.findOne({ 'name': request.body.name }, (function (err, user) {
    // hanlde err..
    if (user) {
      names = user.userNames
      names1 = user.defaultUserNames
      //console.log(user[0].name)
      //response.send(user)
      // user exists 
      if (request.body.type == 'admin') {
        const index = names1.indexOf(request.body.login);
        if (index > -1) {
          names1.splice(index, 1);
        }
        names.push(request.body.login);
        var myquery = { name: request.body.name };
        var newvalues = { $set: { userNames: names, defaultUserNames: names1 } };
        collection1.updateOne(myquery, newvalues, function (err, res) {
          if (err) throw err;
          console.log("1 document updated");
        });
      }
      if (request.body.type == 'default') {
        if (names.length > 1) {
          const index = names.indexOf(request.body.login);
          if (index > -1) {
            names.splice(index, 1);
          }
          names1.push(request.body.login);
          var myquery = { name: request.body.name };
          var newvalues = { $set: { userNames: names, defaultUserNames: names1 } };
          collection1.updateOne(myquery, newvalues, function (err, res) {
            if (err) throw err;
            console.log("1 document updated");
          });
        }
      }
      if (request.body.type == 'none') {
        if (names.length > 1) {
          const index = names.indexOf(request.body.login);
          if (index > -1) {
            names.splice(index, 1);
          }
        }
        const index2 = names1.indexOf(request.body.login);
        if (index2 > -1) {
          names1.splice(index2, 1);
        }
        var myquery = { name: request.body.name };
        var newvalues = { $set: { userNames: names, defaultUserNames: names1 } };
        collection1.updateOne(myquery, newvalues, function (err, res) {
          if (err) throw err;
          console.log("1 document updated");
        });
      }
    }
  })
  )
})

app.post('/findUser', function (request, response) {
  // use `findOne` rather than `find`
  //console.log(request.body)
  collection.findOne({ 'login': request.body.login }, (function (err, user) {
    // hanlde err..
    if (user) {
      //console.log(user[0].name)
      response.send(user)
      // user exists 
    }
  })
  )
})

app.post('/editUser', function (request, response) {
  // console.log(request.body)
  var myquery = { login: request.body.login };
  var newvalues = { $set: { login: request.body.login, dateOFBirth: request.body.dateOfBirth, company: request.body.company, name: request.body.name } };
  collection.updateOne(myquery, newvalues, function (err, res) {
    if (err) throw err;
    console.log("1 document updated");
  });
});

app.post('/updateList', function (request, response) {
  // console.log(request.body)
  var myquery = { name: request.body.name };
  var newvalues = { $set: { actions: request.body.actions } };
  collection2.updateOne(myquery, newvalues, function (err, res) {
    if (err) throw err;
    console.log("1 document updated");
  });
});

app.post('/findList', function (request, response) {
  // use `findOne` rather than `find`
  //console.log(request.body)
  collection2.findOne({ 'name': request.body.name }, (function (err, user) {
    // hanlde err..
    if (user) {
      //console.log(user[0].name)
      response.send(user.actions)
      // user exists 
    }
  })
  )
})

app.listen(port, (err) => {
  if (err) {
    return console.log('something bad happened', err)
  }
  console.log(`server is listening on ${port}`)
})