PROJECT OVERVIEW

You are free to clone it and modify it to your use case


This project is a supply chain system built on the blockchain
As the need for users to know the history and the trail of the products they patronize increase, there is the need for a system that addresses that.
And that's what this dApp addresses

This dApp leverages the transperency, immutability, scalability and decentralization bit of blockchain
    Transperency: anyone can know where a product was manufactured, its manufacturer, transporter, buyer etc.
    Immutability: the data entered about a product can not be changed.
    Scalability: as more manufacturers, products, users, transporters, retailer etc come on board, the efficiency and effectiveness of the dApp won't be affected
    Decentralization: the smart contract is being run by several nodes which prevents the dApp from being attacked

SMART CONTRACT FUNCTIONS

1. createProduct():
This function takes in the required parameters that a product must meet to it can be created.

2. updateProductStatus():
When a product is created, by default its status is "Created", this function is then used to update the status of the product depending on which stage it's at
ie. Created, Shipped, Received and Sold

3. productDetails():
By passing the product Id as an arguement to this function, we are able to see the entire details of a product.
eg. Its name, id, status and timestamp

4. productStatus():
This function returns the status of a product by passing the product Id as a parameter
eg. Created, Shipped etc.

5. changeOwnership():
By passing an address to this function, that address becomes the new owner of the product

6. viewStatus():
This function helps us to see the status of a product by passing a product Id to it

7. createCustomer():
When we want to create a user we use this function by passing in the rigt required parameters

8. getUser():
Pass a user Is to this function if you want to view the details of a user

9. getTotalUsers():
This function lets us know the total number of registered users on this dApp



Made with love for the community
