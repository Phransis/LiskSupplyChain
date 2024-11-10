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
    struct Product {
        uint256 id;
       string name;
       address owner;
       uint16 price;
       uint256 quantity;
       string description;
       string from;
       string to;
       Status status;

    }

    uint256 public  productCount = 0;
    address public  ProductOwner;
    mapping (uint256 => Product) public  products;

    //Modifier for Role-Based Access
    modifier onlyOwner(uint _productId){
        require(products[_productId].owner == msg.sender, "Not Owner");
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
            status: Status.Created
        });
        emit ProductCreated(productCount, _name, msg.sender);
    }

    //Update a Product Status

    function updateProductStatus(uint productId, Status status) public onlyOwner(productId) {
        products[productId].status = status;
        emit ProductStatusUpdated(productId, status);
    }

    //Get product details

    function productDetails(uint _productId) public view returns (Product memory){
        return products[_productId];
    }

    //Transfer Ownership of a Product

    function changeOwnership(uint productId, address newOwner) public onlyOwner(productId){
        products[productId].owner = newOwner;

        emit OwnershipTransferred(productId, newOwner);
    }
}