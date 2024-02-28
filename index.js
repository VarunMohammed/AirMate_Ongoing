const express = require('express')
const mysql = require('mysql')
const nodemailer = require('nodemailer')
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const dotenv = require('dotenv');

dotenv.config({path: "./.env"});
const app = express()
const port = 8080

const validEmail = 'airmate.dev@gmail.com';

const pool = mysql.createConnection({
    host: 'localhost',
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASS,
    database: process.env.MYSQL_DB
});

app.use(bodyParser.json());

app.post('/register', async (req,res) => {
    const { username, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);

    pool.query('INSERT INTO users (username,password) VALUES (?, ?)', [username, hashedPassword], (error, results) => {
        if(error) {
            console.error(error);
            return res.status(500).send("Error registering user");
        } else {
            res.status(200).send(`User ${username} registered successfully`);
        }
    });
});

app.post('/login', async (req,res) => {
    //const { username, password } = req.body;
    /*
    pool.query('SELECT * FROM users WHERE username = ?', [username], async (error, results) => {
        if(error) {
            console.error(error);
            res.status(500).send('Error logging in user');
        } else {
            if(results.length > 0) {
                const match = await bcrypt.compare(password, results[0].password);

                if(match) {
                    const token = jwt.sign({ username: results[0].username },
                        res.json({ token }));
                } else {
                    res.status(401).send('Invalid Password');
                }
            } else {
                res.status(401).send('USer not found');
            }
        }
    })
    */
   res.status(200);
});

/*
app.post('/forgot', (req, res) => {
  const emailId = req.query.email;
  //search if a mail  is present or not
  let query = `SELECT * FROM users WHERE email='${emailId}'`;
  pool.query(query ,(err, result)=>{
      if(result != 0){
          //send email to the received mailid with a random generated 5 digit code and store the code with emailid in the otp table
          //var randomPassword=Math.random().toString(36).substring(8)+'@#$%';//generating the new password
          const userOTP = Math.floor(Math.random() * (99999 - 10000 + 1)) + 10000;
          var nodemailer = require('nodemailer') ;
          
          var transporter = nodemailer.createTransport({
              service:'gmail',
              auth:{
                  user:"airmate.dev@gmail.com",
                  pass:"airmate.dev@123"
              }
          });

          var mailOptions={
              from : 'airmate.dev@gmail.com',
              to : emailId,
              subject : "Your AirMate Password Reset Code!",
              text : `This is your code :\n ${userOTP}\n\nThank you for using our services.\n\nBest Regards.`
          }

          console.log("Mail options are ",mailOptions);
          transporter.sendMail(mailOptions,(error,info)=> {
            if(error) {
                res.status(500).send(`Error: ${error}`);
            } else {
                res.status(200).json({userOTP});
            }
          });
          
      }else{
          res.end("Email Id not found");
      }
  });  
  if (emailId && emailId === validEmail) {
    // Email matches, return status code 200
    res.status(200).json({ message: 'Email is valid' });
  } else {
    // Email doesn't match, return status code 400
    res.status(400).json({ error: 'Invalid email' });
  }
});
*/

app.post('/forgot', (req, res) => {
    const emailId = req.query.email;
    const validEmail = "airmate.dev@gmail.com";
    //search if a mail  is present or not
    if (emailId && emailId === validEmail) {
      // Email matches, return status code 200
      res.status(200).json({ message: 'Email is valid' });
    } else {
      // Email doesn't match, return status code 400
      res.status(400).json({ error: 'Invalid email' });
    }
  });

app.post('/get-hash', (req,res) => {
    const { password } = req.body;

    bcrypt.hash(password, 10, (err, hashedValue) => {
        if(err) {
            print('Error:',err);
            res.status(500).json({ err });
        } else {
            res.json({ hashedValue });
        }
    })
})

app.post('/update-password', (req,res) => {
    const { username,newPassword } = req.body;

    if(!username || !newPassword) {
        res.status(400).json({ error : "Please provide both a username and new password"});
    }

    const sql = 'UPDATE  users SET password = ? WHERE username = ?';
    db.query(sql, [newPassword, username], (err, result) => {
        if(err) {
            return res.status(500).json({error: 'Internal Server Error'});
        }

        if(result.affectedRows === 0) {
            return res.status(404).json({error:'No user found with that username.'});
        }

        res.status(200).json({message: 'Password updated'});
    });
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})