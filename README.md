# FLOAT API

## Description
This project provides a GraphQL API to be used by Float customers to retrieve their repayment amount.

The API contains one query, calculateRepaymentAmount that accepts two required arguments
 - amount: A decimal representing the amount to be borrowed in kobo
 - repayingOn: A date representing when the borrower intends to pay back the 
 loan

The API returns the following:
 - amount: A decimal represent the total amount to be repaid in Naira.
 - errors: A String array containing errors in the request (if any)

A version of this API is available at https://evening-brushlands-41637.herokuapp.com/graphiql

## Dependencies:

* Ruby version - 2.7.3
* Rails version - 6.1.3.2

## Installation

Follow these steps to install and start the app:
You should have the dependencies above already setup

Clone this repo and `cd` into the directory:

``` 
$ git clone https://github.com/AkosuaA/float-api.git
$ cd float-api
```
Then, install the required gems by running 

```
$ bundle install
```

Then to start the server, run

```
$ rails server
```


## Running Test
To run the tests for this project, use the command

```
$ rspec
```

