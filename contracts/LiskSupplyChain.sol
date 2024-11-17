// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract LiskSupplyChain{
    //Define Roles
    enum Roles {Manufacturer, Distributor, Retailer, Customer}

    //Define Status
    enum Status {Created, Shipped, Received, Sold}

    //Define Events
    event ProductCreated(uint256 productId, string name, address owner);
    event ProductStatusUpdated(uint256 productId, Status status);
    event OwnershipTransferred(uint256 productId, address newOwner);
    event CustomerCreated(uint256 id, string name, address userAddress);

    //Defne the structure of a Product
    struct Product {
        uint256 id;
       string name;
       address owner;
       uint16 price;
       uint256 quantity;
       string description;
       string from;
       string to;
       uint256 date; 
       Status status;

    }

    //Defne the structure of a Product
    struct User {
        uint256 id;
        string name;
        address userAddress;
        string location;
        string description;
        uint256 date;
        Roles role;

    }

    //Define variables
    uint256 public  productCount = 0;
    uint256 public userCount = 0;
    address public  ProductOwner = msg.sender;
    mapping (uint256 => Product) public  products;
    mapping (uint256 => User) public users;

    //Modifier for Role-Based Access
    modifier onlyOwner(uint _productId){
        require(products[_productId].owner == msg.sender, "Not Owner");
        _;
    }

    //Modifier to check if a Product ID exists
    modifier isProductIdValid(uint productId){
        require(productId > 0 && productId <= productCount, "Product ID does not exist");
        _;
    }
    
    //Modifier to check if a User ID exists
    modifier isUserIdvalid(uint256 userId){
        require(userId > 0 && userId <= userCount, "User ID does not exist");
        _;
    }

    //Create a Product
    function createProduct(string memory _name, uint16 _price, uint256 _quantity, string memory desc, string memory _from, string memory  _to) public{
        productCount++;
        products[productCount] = Product({
            id: productCount,
            name: _name,
            owner: msg.sender,
            price: _price,
            quantity: _quantity,
            description: desc,
            from: _from,
            to: _to,
            status: Status.Created,
            date: block.timestamp
        });
        emit ProductCreated(productCount, _name, msg.sender);
    }

    //Update a Product Status
    function updateProductStatus(uint productId, Status status) public onlyOwner(productId) isProductIdValid(productId) {
        products[productId].status = status;
        emit ProductStatusUpdated(productId, status);
    }

    //Get product details
    function productDetails(uint _productId) isProductIdValid(_productId) public view returns (Product memory){
        return products[_productId];
    }

    //Transfer Ownership of a Product
    function changeOwnership(uint productId, address newOwner) public onlyOwner(productId)  isProductIdValid(productId){
        require(newOwner != address(0), "New owner should not be the zero address");
        require(newOwner == msg.sender, "New Owner can not be the current owner");
        products[productId].owner = newOwner;

        emit OwnershipTransferred(productId, newOwner);
    }

    //View a products Status
    function viewStatus(uint256 productId)  isProductIdValid(productId) public view returns (Status status){
        return products[productId].status;
    }

    // Assign Usser Role
    function createCustomer(string memory name, string memory location, string memory desc, Roles _role) public {
        userCount++;
        users[userCount] = User({
            id: userCount,
            name: name,
            userAddress: msg.sender,
            location: location,
            description: desc,
            date: block.timestamp,
            role: _role
        });
        emit CustomerCreated(userCount, name, msg.sender);
    }

    //Retreiving a User by ID
    function getUser(uint256 userId) isUserIdvalid(userId) public view returns (User memory){
        return users[userId];
    }

    //Retreiving all Users
    function getTotalUsers() public view returns (uint256 ){
        return userCount;
    }

    // function getAllCustomers( uint256 id) public view returns (uint256){
    //     uint256 allCustomers= 0;
    //     if (users[id].role = Roles.Customer){
    //         allCustomers++;
    //     }
    //     return allCustomers;
    // }

    function checkStatus(Status _status) public pure returns(string memory){
        if (_status == Status.Created) return "Created";
        if (_status == Status.Shipped) return "Shipped";
        if (_status == Status.Received) return "Received";
        if (_status == Status.Sold) return "Sold";
        return "Unknown";
    }

    function productStatus(uint256 productId) isProductIdValid(productId) public view returns(string memory){
        if (products[productId].status == Status.Created) return "Created";
        if (products[productId].status == Status.Shipped) return "Shipped";
        if (products[productId].status == Status.Received) return "Received";
        return "Unknown";
    }
}