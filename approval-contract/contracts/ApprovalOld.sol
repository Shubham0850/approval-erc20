// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IApprovel {
    function transferFund(uint256 _amount) external returns(bool);
}

contract ApprovelContract is ERC20, IApprovel {
    address public buyer;
    address public seller;

    constructor() ERC20("CpToken", "CPY") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    function setBuyer(address _buyer) public{
        buyer = _buyer;
    }

    function setSeller(address _seller) public{
        seller = _seller;
    }

    function approveAmount(uint256 _amount) public payable {
        require(msg.sender == buyer, "only buyer can approve the transaction");
        approve(address(this), _amount);
    }

    function transferFund(uint256 _amount) external override returns(bool) {
        require(msg.sender == address(this), "Only verifier can call this");
        bool transfered = transferFrom(buyer, seller, _amount);
        return transfered;
    }

    function triggerTransfer(uint256 _amount) external returns(bool) {
        return IApprovel(address(this)).transferFund(_amount); 
    }
}
