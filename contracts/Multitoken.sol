// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Multitoken is ERC1155, ERC1155Burnable {
    uint256 public constant NFT_1 = 0;
    uint256 public constant NFT_2 = 1;
    uint256 public constant NFT_3 = 2;

    address payable public immutable _owner;

    string private _uri = "https://ipfs/directory/tokens/";

    uint256[] public currentSupply = [50, 50, 50];
    uint256 public tokenPrice = 0.01 ether;    

    constructor() ERC1155("https://ipfs/directory/tokens/") {
        _owner = payable(msg.sender);
    }

    function mint(
        uint256 _id,
        uint256 _amount,
        bytes memory _data
    ) external payable {
        require(_id < 3, "This token _id does not exists");
        require(currentSupply[_id] > 0, "Max supply reached");
        require(msg.value >= tokenPrice, "Insufficient payment");
        _mint(msg.sender, _id, _amount, _data);
        currentSupply[_id] -= 1;
        emit TransferSingle(msg.sender, address(0), msg.sender, _id, _amount);
    }

    function uri(
        uint256 _id
    ) public view virtual override returns (string memory) {
        require(_id < 3, "This token _id does not exists");
        return string.concat(_uri, Strings.toString(_id), ".json");
    }

    function withdraw() external {
        require(msg.sender == _owner, "You do not have permission");
        uint256 amount = address(this).balance;
        (bool success, ) = _owner.call{value: amount}("");
        require(success == true, "Failed to withdraw");
    }
}
