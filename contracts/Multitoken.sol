// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Multitoken {
    address payable public owner;
    string public name;
    string public status;

    constructor(string memory _name) {
        name = _name;        
    }

    function setStatus(string memory _status) public {
        status = _status;
    } 
}
